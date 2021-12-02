import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/Screens/home_page.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:crowd_funding_app/services/provider/user.dart';
import 'package:crowd_funding_app/translations/locale_keys.g.dart';
import 'package:crowd_funding_app/widgets/authdialog.dart';
import 'package:crowd_funding_app/widgets/forgot_password_invitation.dart';
import 'package:crowd_funding_app/widgets/loading_progress.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

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
          LocaleKeys.set_your_password_appbar_title_text.tr(),
          style: appbarTextStyle,
        ),
        actions: [
          TextButton(
            key: Key('save_button'),
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
              LocaleKeys.save_button_text.tr(),
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
                  key: Key('current_password'),
                  obscureText: _currentPassword,
                  onSaved: (value) {
                    setState(() {
                      _passwordValue['currentPassword'] = value;
                    });
                  },
                  validator: (value) {
                    if (value != widget.user.password) {
                      return LocaleKeys.incorrect_password_lable_text.tr();
                    }
                  },
                  decoration: InputDecoration(
                    labelText: LocaleKeys.current_password_label_text.tr(),
                    contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                    suffix: TextButton(
                      child: Text(_currentPassword
                          ? LocaleKeys.show_button_text.tr()
                          : LocaleKeys.hide_button_text.tr()),
                      onPressed: () {
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
                        LocaleKeys.forgot_password_or_text.tr(),
                        style: labelTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).secondaryHeaderColor),
                      ),
                      GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => ForgotPasswordInvitaion(
                                      email: widget.user.email!,
                                    ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                                LocaleKeys.reset_password_button_text.tr()),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  key: Key('new_password'),
                  obscureText: _newPassword,
                  onSaved: (value) {
                    setState(() {
                      _passwordValue['newPassword'] = value;
                    });
                  },
                  validator: (value) {
                    if (value!.length <= 7) {
                      return LocaleKeys.not_enough_password_error_text.tr();
                    }
                  },
                  decoration: InputDecoration(
                    labelText: LocaleKeys.new_password_label_text.tr(),
                    contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                    suffix: TextButton(
                      child: Text(_newPassword
                          ? LocaleKeys.show_button_text.tr()
                          : LocaleKeys.hide_button_text.tr()),
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
                  key: Key('confirm_password'),
                  obscureText: _confirmPassword,
                  validator: (value) {
                    if (_passwordValue['newPassword'] != value) {
                      return LocaleKeys.new_password_dont_match_label_text.tr();
                    }
                  },
                  decoration: InputDecoration(
                    labelText: LocaleKeys.confirm_new_password_label_text.tr(),
                    contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                    suffix: TextButton(
                      child: Text(_confirmPassword
                          ? LocaleKeys.show_button_text.tr()
                          : LocaleKeys.hide_button_text.tr()),
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
