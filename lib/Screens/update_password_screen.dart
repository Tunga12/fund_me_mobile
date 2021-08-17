import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/Screens/home_page.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:crowd_funding_app/services/provider/user.dart';
import 'package:crowd_funding_app/widgets/authdialog.dart';
import 'package:crowd_funding_app/widgets/forgot_password_invitation.dart';
import 'package:crowd_funding_app/widgets/loading_progress.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class UpdatePassword extends StatefulWidget {
  final User user;
  final String token;
  UpdatePassword({
    Key? key,
    required this.user,
    required this.token,
  }) : super(key: key);

  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  bool _currentPassword = true;
  bool _newPassword = true;
  bool _confirmPassword = true;

  final _formKey = GlobalKey<FormState>();

  final _passwordValue = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Set your password',
          style: appbarTextStyle,
        ),
        actions: [
          TextButton(
            onPressed: () async {
              _formKey.currentState!.save();
              if (_formKey.currentState!.validate()) {
                print("validated");
                loadingProgress(context);
                User _newUser = widget.user.copyWith(
                  password: _passwordValue['newPassword'],
                );
                await context
                    .read<UserModel>()
                    .updateUser(_newUser, widget.token);
                Response _response = context.read<UserModel>().response;
                if (_response.status == ResponseStatus.SUCCESS) {
                  await UserPreference().storeUserInformation(_newUser);
                  Fluttertoast.showToast(msg: "successfully updated");
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      HomePage.routeName, (route) => false,
                      arguments: 2);
                } else {
                  Navigator.of(context).pop();
                  authShowDialog(context, Text(_response.message),
                      error: true, close: true);
                }
                print(_passwordValue['newPassword']);
              }
            },
            child: Text(
              "SAVE",
              style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  obscureText: _currentPassword,
                  onSaved: (value) {
                    setState(() {
                      _passwordValue['currentPassword'] = value;
                    });
                  },
                  validator: (value) {
                    if (value != widget.user.password) {
                      return 'incorrect password';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Current password',
                    contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                    suffix: TextButton(
                      child: Text(_currentPassword ? 'Show' : 'Hide'),
                      onPressed: () {
                        print("show password");
                        setState(() {
                          _currentPassword = !_currentPassword;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    children: [
                      Text(
                        'forgot password or don\'t have one? ',
                        style: labelTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).secondaryHeaderColor),
                      ),
                      GestureDetector(
                          onTap: () {
                            print("reset password");
                            showDialog(
                                context: context,
                                builder: (context) => ForgotPasswordInvitaion(
                                      email: widget.user.email!,
                                    ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text('Reset password'),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  obscureText: _newPassword,
                  onSaved: (value) {
                    setState(() {
                      _passwordValue['newPassword'] = value;
                    });
                  },
                  validator: (value) {
                    if (value!.length <= 7) {
                      return 'password must aleast 8 chars';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'New password',
                    contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                    suffix: TextButton(
                      child: Text(_newPassword ? 'Show' : "Hide"),
                      onPressed: () {
                        print("show password");
                        setState(() {
                          _newPassword = !_newPassword;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  obscureText: _confirmPassword,
                  validator: (value) {
                    if (_passwordValue['newPassword'] != value) {
                      return 'new password do not match';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Confirm new password',
                    contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                    suffix: TextButton(
                      child: Text(_confirmPassword ? 'Show' : "Hide"),
                      onPressed: () {
                        print("show password");
                        setState(() {
                          _confirmPassword = !_confirmPassword;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
