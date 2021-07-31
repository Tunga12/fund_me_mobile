import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Models/update.dart';
import 'package:crowd_funding_app/Screens/home_page.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/services/provider/update.dart';
import 'package:crowd_funding_app/widgets/authdialog.dart';
import 'package:crowd_funding_app/widgets/loading_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class UpdatePage extends StatefulWidget {
  final String fundraiseId;
  UpdatePage(this.fundraiseId);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  String content = "";
  @override
  GlobalKey<FlutterSummernoteState> _keyEditor = GlobalKey();
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
        actions: [
          TextButton(
              onPressed: () async {
                loadingProgress(context);
                final value2 = await _keyEditor.currentState?.getText();
                await Future.delayed(Duration(milliseconds: 500));
                final value = await _keyEditor.currentState?.getText();

                UserPreference userPreference = UserPreference();
                PreferenceData preferenceData =
                    await userPreference.getUserToken();

                print("value content $value");

                Update update = Update(
                  content: value.toString(),
                  image:
                      'https://shrouded-bastion-52038.herokuapp.com/uploads/2021-07-27T12-28-31.913Zlocation_background.jpg',
                );

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
                      HomePage.routeName, (route) => false);
                }
              },
              child: Text("POST")),
        ],
        title: Text("New Update"),
      ),
      body: SingleChildScrollView(
        child: FlutterSummernote(
          hasAttachment: true,
          hint: "Your text here...",
          key: _keyEditor,
          customToolbar: """
              [
                    ['style', ['bold', 'italic', 'underline', 'clear']],
                    ['font', ['strikethrough', 'superscript', 'subscript']]
              ]""",
        ),
      ),
    );
  }
}

// child: SizedBox(
//   height: size.height,
//   child: TextFormField(
//     maxLines: size.height.toInt(),
//     decoration: InputDecoration(
//       border: OutlineInputBorder(borderSide: BorderSide.none),
//       hintText:
//           "Share new developments or progress updares about your GoFundMe...",
//     ),
//   ),
// ),
