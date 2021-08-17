import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Models/update.dart';
import 'package:crowd_funding_app/Screens/home_page.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/services/provider/update.dart';
import 'package:crowd_funding_app/widgets/authdialog.dart';
import 'package:crowd_funding_app/widgets/loading_progress.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class UpdateTextView extends StatefulWidget {
  const UpdateTextView({Key? key, required this.fundraiseId}) : super(key: key);
  final String fundraiseId;

  @override
  _UpdateTextViewState createState() => _UpdateTextViewState();
}

class _UpdateTextViewState extends State<UpdateTextView> {
  final _formKey = GlobalKey<FormState>();
  String _updateData = '';
  bool _post = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Story"),
        actions: [
          if (_post)
            TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    loadingProgress(context);

                    UserPreference userPreference = UserPreference();
                    PreferenceData preferenceData =
                        await userPreference.getUserToken();

                    Update update = Update(content: _updateData);

                    await context.read<UpdateModel>().createUpdate(
                        update, preferenceData.data, widget.fundraiseId);

                    Response response = context.read<UpdateModel>().response;
                    if (response.status == ResponseStatus.CONNECTIONERROR) {
                      Navigator.of(context).pop();
                      authShowDialog(context, Text(response.message),
                          close: true, error: true);
                    } else {
                      Fluttertoast.showToast(
                          msg: "Successfully Updated!",
                          toastLength: Toast.LENGTH_LONG);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          HomePage.routeName, (route) => false,
                          arguments: 2);
                    }
                  }
                },
                child: Text("POST")),
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          onChanged: () {
            setState(() {
              _post = _formKey.currentState!.validate();
            });
          },
          child: TextFormField(
            onSaved: (value) {
              setState(() {
                _updateData = value!;
              });
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Field empty";
              }
            },
            decoration: InputDecoration(
                hintText:
                    "Share a new developments or progress updates about your GoFundMe..."),
            maxLines: size.height.toInt(),
          ),
        ),
      )),
    );
  }
}
