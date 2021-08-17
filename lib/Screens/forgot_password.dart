import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/Screens/home_page.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:crowd_funding_app/services/provider/auth.dart';
import 'package:crowd_funding_app/services/provider/user.dart';
import 'package:crowd_funding_app/widgets/authdialog.dart';
import 'package:crowd_funding_app/widgets/forgot_password_invitation.dart';
import 'package:crowd_funding_app/widgets/loading_progress.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  String _password = '';
  bool _isObscuredNew = true;
  @override
  Widget build(BuildContext context) {
    print('Deep link requested');
    print(widget.url);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset your password'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  onSaved: (value) {
                    setState(() {
                      _password = value!;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "field required!";
                    } else if (value.length <= 7) {
                      return 'password must be atleast 8 chars';
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    labelText: "New password",
                    suffix: TextButton(
                      child: Text(_isObscuredNew ? 'Show' : 'Hide'),
                      onPressed: () {
                        print("show password");
                        setState(() {
                          _isObscuredNew = !_isObscuredNew;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (_password != value) {
                      return "password do not match";
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    labelText: "Confirm password",
                    suffix: TextButton(
                      child: Text(_isObscuredNew ? 'Show' : 'Hide'),
                      onPressed: () {
                        print("show password");
                        setState(() {
                          _isObscuredNew = !_isObscuredNew;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                SizedBox(
                  height: 50.0,
                  width: size.width,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).accentColor),
                    child: Text(
                      "Set password",
                      style: labelTextStyle.copyWith(
                          color: Theme.of(context).backgroundColor),
                    ),
                    onPressed: () async {
                      _formKey.currentState!.save();
                      if (_formKey.currentState!.validate()) {
                        print("validated");
                        print(_password);
                        loadingProgress(context);
                        await context
                            .read<UserModel>()
                            .resetPassword(_password, widget.url)
                            .then((value) async {
                          Response _user = context.read<UserModel>().response;
                          User _userNew = _user.data;
                          User newUser = _userNew.copyWith(password: _password);
                          await context.read<AuthModel>().signinUser(newUser);
                          AuthStatus authModel =
                              context.read<AuthModel>().signinStatus;
                          Response _response = context.read<AuthModel>().response;
                          if (authModel == AuthStatus.LOGGEDIN) {
                            print("email");
                            print(_userNew.email);
                            await context
                                .read<UserModel>()
                                .getUser(_response.data, newUser.password!);
                            Response response =
                                context.read<UserModel>().response;
                            print("sigin reponse ${response.data}");
                            if (response.data != null) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  HomePage.routeName,
                                  (Route<dynamic> route) => false);
                            } else {
                              Navigator.of(context).pop();
                              authShowDialog(context, Text(response.message),
                                  error: true, close: true);
                            }
                          }
                        }).catchError((error) {
                          Navigator.of(context).pop();
                          authShowDialog(context, Text(error.toString()),
                              close: true, error: true);
                        });
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
