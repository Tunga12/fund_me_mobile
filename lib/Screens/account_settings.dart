import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/Screens/home_page.dart';
import 'package:crowd_funding_app/Screens/signin_page.dart';
import 'package:crowd_funding_app/Screens/update_password_screen.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/services/provider/user.dart';
import 'package:crowd_funding_app/translations/locale_keys.g.dart';
import 'package:crowd_funding_app/widgets/authdialog.dart';
import 'package:crowd_funding_app/widgets/loading_progress.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  final _formKey = GlobalKey<FormState>();
  User? user;
  String? token;

  getUser() async {
    UserPreference userPreference = UserPreference();
    PreferenceData data = await userPreference.getUserInfromation();
    PreferenceData tokenData = await userPreference.getUserToken();
    setState(() {
      user = data.data;
      token = tokenData.data;
    });
  }

  bool _loading = true;
  @override
  void initState() {
    getUser();
    super.initState();
  }

  IconData _iconData = Icons.visibility;

  Map<String, dynamic> _userInfo = {};

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Container();
    }
    print("account user $user");
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          LocaleKeys.account_listitle_text.tr(),
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              final form = _formKey.currentState;

              if (form!.validate()) {
                print("Saved!");
                form.save();
                User formUser = User(
                  firstName: _userInfo['firstName'],
                  lastName: _userInfo['lastName'],
                  email: _userInfo['email'],
                  password: _userInfo['password'],
                );
                loadingProgress(context);
                print("update user $user");
                print("token $token");
                await context.read<UserModel>().updateUser(formUser, token!);

                User _newUser = user!.copyWith(
                  firstName: _userInfo['firstName'],
                  lastName: _userInfo['lastName'],
                  email: _userInfo['email'],
                  password: _userInfo['password'],
                );

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
              }
            },
            child: Text(
              LocaleKeys.save_button_text.tr(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Theme.of(context).secondaryHeaderColor),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 7,
                    offset: Offset(0, 3))
              ],
            ),
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    children: [
                      Text(
                        LocaleKeys.general_settings_text.tr(),
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Theme.of(context).secondaryHeaderColor),
                      )
                    ],
                  ),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          key: Key("first_name"),
                          initialValue: user!.firstName,
                          decoration: InputDecoration(
                            labelText: LocaleKeys.first_name_text.tr(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LocaleKeys.first_name_mustnot_empty_text
                                  .tr();
                            } else if (value.length < 3) {
                              return LocaleKeys
                                  .first_name_must_greater_than_three_text
                                  .tr();
                            }
                          },
                          onSaved: (value) {
                            setState(() {
                              _userInfo['firstName'] = value;
                            });
                          },
                        ),
                        TextFormField(
                          key: Key('last_name'),
                          initialValue: user!.lastName,
                          decoration: InputDecoration(
                              labelText: LocaleKeys.last_name_text.tr()),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LocaleKeys.last_name_mustnot_empty_text
                                  .tr();
                            } else if (value.length < 3) {
                              return LocaleKeys
                                  .last_name_must_greater_than_threww_text
                                  .tr();
                            }
                          },
                          onSaved: (value) {
                            _userInfo['lastName'] = value;
                          },
                        ),
                        TextFormField(
                          key: Key('email'),
                          initialValue: user!.email,
                          decoration: InputDecoration(
                            labelText: LocaleKeys.email_text.tr(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email must not empty";
                            }
                          },
                          onSaved: (value) {
                            setState(() {
                              _userInfo['email'] = value;
                            });
                          },
                        ),
                        TextFormField(
                          key: Key('password'),
                          readOnly: true,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => UpdatePassword(
                                  user: user!,
                                  token: token!,
                                ),
                              ),
                            );
                          },
                          obscureText: true,
                          initialValue: user!.password,
                          decoration: InputDecoration(
                              labelText: LocaleKeys.Password_text.tr(),
                              suffixIcon: TextButton(
                                child: Text(LocaleKeys.change_text.tr()),
                                onPressed: () {},
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password must not empty";
                            } else if (value.length < 8) {
                              return 'password too shart';
                            }
                          },
                          onSaved: (value) {
                            setState(() {
                              _userInfo['password'] = value;
                            });
                          },
                        ),
                      ],
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          // Container(
          //   padding: EdgeInsets.all(20.0),
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     boxShadow: [
          //       BoxShadow(
          //           color: Colors.grey.withOpacity(0.5),
          //           blurRadius: 7,
          //           offset: Offset(0, 3))
          //     ],
          //   ),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         LocaleKeys.connected_accounts_text.tr(),
          //       ),
          //       SizedBox(
          //         height: 10.0,
          //       ),
          //       Text(
          //         LocaleKeys.connecting_makes_it_easy_text.tr(),
          //         style: Theme.of(context).textTheme.bodyText1,
          //       ),
          //       SizedBox(
          //         height: 30.0,
          //       ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Icon(
          //             FontAwesomeIcons.facebookSquare,
          //             color: Colors.blue[900],
          //             size: 35.0,
          //           ),
          //           Text(
          //             LocaleKeys.facebook_text.tr(),
          //             style: Theme.of(context).textTheme.bodyText1,
          //           ),
          //           SizedBox(
          //             width: 30.0,
          //           ),
          //           TextButton(
          //               style: TextButton.styleFrom(
          //                   shape: RoundedRectangleBorder(
          //                       borderRadius: BorderRadius.circular(8.0)),
          //                   padding: EdgeInsets.symmetric(horizontal: 30.0),
          //                   side: BorderSide(color: Colors.green, width: 1.5)),
          //               onPressed: () {},
          //               child: Text(
          //                 LocaleKeys.connect_button_text.tr(),
          //               ))
          //         ],
          //       )
          //     ],
          //   ),
          // ),
          SizedBox(
            height: 30.0,
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.delete_account_description_text.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(height: 1.8),
                ),
                TextButton(
                  child: Text(
                    LocaleKeys.delete_account_butto_text.tr(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.deepOrangeAccent.shade200),
                  ),
                  onPressed: () async {
                    loadingProgress(context);
                    await context.read<UserModel>().deleteUser(token!);
                    UserPreference userPreference = UserPreference();
                    await userPreference.removeToken();
                    await userPreference.getUserInfromation();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        SigninPage.routeName, (Route<dynamic> route) => false);
                  },
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 0.0)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
