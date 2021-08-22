import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/Screens/home_page.dart';
import 'package:crowd_funding_app/Screens/signup_page.dart';
import 'package:crowd_funding_app/services/provider/auth.dart';
import 'package:crowd_funding_app/services/provider/user.dart';
import 'package:crowd_funding_app/widgets/authdialog.dart';
import 'package:crowd_funding_app/widgets/forgot_password_invitation.dart';
import 'package:crowd_funding_app/widgets/loading_progress.dart';
import 'package:crowd_funding_app/widgets/or.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SigninPage extends StatefulWidget {
  static const routeName = '/signinPage';
  SigninPage({Key? key, this.url}) : super(key: key);
  String? url;

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _userInfo = {};
  bool isValidated = false;
  bool _isObscured = true;
  IconData iconData = Icons.visibility;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // AuthModel userModel = Provider.of<AuthModel>(context);
    return Consumer<AuthModel>(
      builder: (_, model, child) {
       
        return Scaffold(
          appBar: AppBar(
            title: Text("Sign in"),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Image.asset(
                    "assets/images/gofundme.png",
                    height: size.height * 0.07,
                    width: size.width * 0.01,
                  ),
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
                        key: Key("email_formfield"),
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (value) {
                          this._userInfo['email'] = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Incorect email or password!";
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
                        key: Key('password_formfield'),
                        obscureText: _isObscured,
                        onSaved: (value) {
                          this._userInfo['password'] = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Incorect Email or Password!";
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
                      SizedBox(
                        height: 18.0,
                      ),
                      SizedBox(
                        width: size.width,
                        height: size.height * 0.08,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: isValidated
                                ? Theme.of(context).accentColor
                                : Theme.of(context)
                                    .secondaryHeaderColor
                                    .withAlpha(180),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              User user = User(
                                email: _userInfo['email'],
                                password: _userInfo['password'],
                              );
                              loadingProgress(context);
                              await context.read<AuthModel>().signinUser(user);

                              if (model.signinStatus == AuthStatus.LOGGEDIN) {
                               

                                await context.read<UserModel>().getUser(
                                    model.response.data, user.password!);
                                Response response =
                                    context.read<UserModel>().response;
                                print("sigin reponse ${response.data}");
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
                            "SIGN IN",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: Theme.of(context).backgroundColor),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                TextButton(
                  key: Key('signinbutton_key'),
                  onPressed: () {
                    _formKey.currentState!.save();
                    print('User email is ');
                    print(
                      _userInfo['email'],
                    );
                    showDialog(
                        context: context,
                        builder: (context) => ForgotPasswordInvitaion(
                              email: _userInfo['email'],
                            ));
                  },
                  child: Text(
                    'Forgot your password?',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                OrDivider(),
                SizedBox(
                  width: size.width * 0.7,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue[800],
                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.facebook,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          "Continue with Facebook",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 17.0, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextButton(
                    onPressed: () {
                      widget.url != null
                          ? Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => SignupPage(
                                  url: widget.url,
                                ),
                              ),
                            )
                          : Navigator.of(context)
                              .pushReplacementNamed(SignupPage.routeName);
                    },
                    child: Text(
                      "Don't have an account? Sign up.",
                      style: TextStyle(fontSize: 18.0),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
