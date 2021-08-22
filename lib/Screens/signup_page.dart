import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/Screens/home_page.dart';
import 'package:crowd_funding_app/Screens/signin_page.dart';
import 'package:crowd_funding_app/services/provider/auth.dart';
import 'package:crowd_funding_app/services/provider/user.dart';
import 'package:crowd_funding_app/widgets/authdialog.dart';
import 'package:crowd_funding_app/widgets/loading_progress.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  static String routeName = "/signupPage";
  SignupPage({Key? key, this.url}) : super(key: key);

  String? url;

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  bool isValidated = false;
  bool _isObscured = true;
  String _password = '';
  IconData iconData = Icons.visibility;
  Map<String, dynamic> _userInfo = {};
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<AuthModel>(
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Sign up"),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Image.asset(
                    "assets/images/gofundme.png",
                    height: size.height * 0.07,
                    width: size.width * 0.01,
                  ),
                ),
                Text(
                  "Great job!",
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  "Now create an account to preview and launch your fundraiser.",
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Form(
                  key: _formKey,
                  onChanged: () {
                    setState(() {
                      isValidated = _formKey.currentState!.validate();
                    });
                  },
                  child: Column(
                    children: [
                      TextFormField(
                        key: Key("signup_firstname"),
                        onSaved: (value) {
                          setState(() {
                            _userInfo['firstName'] = value;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "First name is required!";
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "First name",
                        ),
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                      TextFormField(
                        key: Key('signup_lastname'),
                        onSaved: (value) {
                          setState(() {
                            _userInfo['lastName'] = value;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Last name is required!";
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Last name",
                        ),
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                      TextFormField(
                        key: Key('signup_email'),
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (value) {
                          _userInfo['email'] = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email is required!";
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Email",
                        ),
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                      TextFormField(
                        key: Key('signup_phonenumber'),
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                        onSaved: (value) {
                          _userInfo['phoneNumber'] = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Phone number is required!";
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Phone number",
                        ),
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                      TextFormField(
                        key: Key('signup_password'),
                        obscureText: _isObscured,
                        onSaved: (value) {
                          setState(() {
                            _userInfo['password'] = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            _userInfo['password'] = value;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password is required!";
                          } else if (value.length < 8) {
                            return "password too short!";
                          }
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(iconData),
                            onPressed: () {
                              setState(() {
                                _isObscured = !_isObscured;
                                iconData = _isObscured
                                    ? Icons.visibility
                                    : Icons.visibility_off;
                              });
                            },
                          ),
                          labelText: "Password",
                        ),
                      ),
                      TextFormField(
                        key: Key('signup_confirmpassword'),
                        obscureText: _isObscured,
                        onSaved: (value) {
                          setState(() {
                            _userInfo['password'] = value;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "password don't match";
                          } else if (value != _userInfo['password']) {
                            return "password don't match!";
                          }
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(iconData),
                            onPressed: () {
                              setState(() {
                                _isObscured = !_isObscured;
                                iconData = _isObscured
                                    ? Icons.visibility
                                    : Icons.visibility_off;
                              });
                            },
                          ),
                          labelText: "confirm password",
                        ),
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                      SizedBox(
                        width: size.width,
                        height: size.height * 0.08,
                        child: TextButton(
                          key: Key("signup_button"),
                          style: TextButton.styleFrom(
                            backgroundColor: isValidated
                                ? Theme.of(context).accentColor
                                : Theme.of(context)
                                    .secondaryHeaderColor
                                    .withOpacity(0.2),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              print("Logging...");
                              User user = User(
                                firstName: _userInfo['firstName'],
                                lastName: _userInfo['lastName'],
                                email: _userInfo['email'],
                                phoneNumber: _userInfo['phoneNumber'],
                                password: _userInfo['password'],
                              );
                              print("Signup user $user");
                              print(_userInfo);
                              loadingProgress(context);
                              await context.read<AuthModel>().signupUser(user);
                              if (model.signupStatus == AuthStatus.REGISTERED) {
                                await context.read<UserModel>().getUser(
                                    model.response.data, user.password!);
                                Response response =
                                    context.read<UserModel>().response;
                                if (response.data != null) {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      HomePage.routeName,
                                      (Route<dynamic> route) => false);
                                } else {
                                  Navigator.of(context).pop();
                                  authShowDialog(
                                      context, Text(response.message),
                                      error: true, close: true);
                                }
                              } else {
                                if (model.response.status ==
                                    ResponseStatus.CONNECTIONERROR) {
                                  Navigator.of(context).pop();
                                  authShowDialog(
                                      context, Text(model.response.message),
                                      error: true, close: true);
                                } else if (model.response.status ==
                                    ResponseStatus.MISMATCHERROR) {
                                  Navigator.of(context).pop();
                                  authShowDialog(
                                      context, Text(model.response.message),
                                      error: true, close: true);
                                } else if (model.response.status ==
                                    ResponseStatus.FORMATERROR) {
                                  Navigator.of(context).pop();
                                  authShowDialog(
                                      context, Text(model.response.message),
                                      error: true, close: true);
                                } else {
                                  Navigator.of(context).pop();
                                  authShowDialog(
                                      context, Text(model.response.message),
                                      error: true, close: true);
                                }
                              }
                            }
                          },
                          child: Text(
                            "SIGN UP",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: isValidated
                                        ? Theme.of(context).backgroundColor
                                        : Theme.of(context)
                                            .secondaryHeaderColor
                                            .withOpacity(0.7)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 18.0),
                  child: Center(
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                          text: "Sign in",
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              widget.url != null
                                  ? Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => SignupPage(
                                          url: widget.url,
                                        ),
                                      ),
                                    )
                                  : Navigator.of(context).pushReplacementNamed(
                                      SigninPage.routeName);
                            })
                    ])),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
