import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/Screens/signin_page.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/services/provider/user.dart';
import 'package:crowd_funding_app/widgets/authdialog.dart';
import 'package:crowd_funding_app/widgets/loading_progress.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_hud/progress_hud.dart';
import 'package:provider/provider.dart';

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
  bool _isObscured = true;

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
          "Account settings",
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

                User newUser = user!.copyWith(
                  firstName: _userInfo['firstName'],
                  lastName: _userInfo['lastName'],
                  email: _userInfo['email'],
                  password: _userInfo['password'],
                );

                await UserPreference().storeUserInformation(newUser);

                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }
            },
            child: Text(
              "SAVE",
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
                        "General settings",
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
                          initialValue: user!.firstName,
                          decoration: InputDecoration(
                            labelText: "First name",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "First name must not empty";
                            } else if (value.length < 3) {
                              return "field must be atleast 3 chars";
                            }
                          },
                          onSaved: (value) {
                            setState(() {
                              _userInfo['firstName'] = value;
                            });
                          },
                        ),
                        TextFormField(
                          initialValue: user!.lastName,
                          decoration: InputDecoration(labelText: "Last name"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Last name must not empty";
                            } else if (value.length < 3) {
                              return "field must be atleast 3 chars";
                            }
                          },
                          onSaved: (value) {
                            _userInfo['lastName'] = value;
                          },
                        ),
                        TextFormField(
                          initialValue: user!.email,
                          decoration: InputDecoration(labelText: "Email"),
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
                          obscureText: _isObscured,
                          initialValue: user!.password,
                          decoration: InputDecoration(
                            labelText: "Password",
                            suffixIcon: IconButton(
                              icon: Icon(_iconData),
                              onPressed: () {
                                setState(() {
                                  _isObscured = !_isObscured;
                                  _iconData = _isObscured
                                      ? Icons.visibility
                                      : Icons.visibility_off;
                                });
                              },
                            ),
                          ),
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
          Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 7,
                    offset: Offset(0, 3))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Connected accounts",
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Connecting makes it easy for you to share",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      FontAwesomeIcons.facebookSquare,
                      color: Colors.blue[900],
                      size: 35.0,
                    ),
                    Text(
                      "Facebook",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            side: BorderSide(color: Colors.green, width: 1.5)),
                        onPressed: () {},
                        child: Text("Connect"))
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Deleting your account will remove all of your activity and campaigns, and you will no longer be able to sign in with this account.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(height: 1.8),
                ),
                TextButton(
                  child: Text(
                    "Delete account",
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
