import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/Screens/home_page.dart';
import 'package:crowd_funding_app/Screens/signin_page.dart';
import 'package:crowd_funding_app/services/provider/auth.dart';
import 'package:crowd_funding_app/services/provider/fundraise.dart';
import 'package:crowd_funding_app/services/provider/user.dart';
import 'package:crowd_funding_app/translations/locale_keys.g.dart';
import 'package:crowd_funding_app/widgets/authdialog.dart';
import 'package:crowd_funding_app/widgets/loading_progress.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

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
            title: Text(LocaleKeys.register_appbar_title_text.tr()),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView(
              key: Key("signup_page_listview"),
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Image(
                    image: AssetImage(
                      "assets/images/logo_image.PNG",
                    ),
                    width: size.width * 0.2,
                    height: size.height * 0.1,
                  ),
                ),
                Text(
                  LocaleKeys.great_job_text.tr(),
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  LocaleKeys.now_create_an_account.tr(),
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
                            return LocaleKeys.first_name_required_text.tr();
                          }
                        },
                        decoration: InputDecoration(
                          labelText: LocaleKeys.first_name_text.tr(),
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
                            return LocaleKeys.last_name_required_text.tr();
                          }
                        },
                        decoration: InputDecoration(
                          labelText: LocaleKeys.last_name_text.tr(),
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
                            return LocaleKeys.email_required_text.tr();
                          }
                        },
                        decoration: InputDecoration(
                          labelText: LocaleKeys.email_text.tr(),
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
                            return LocaleKeys.phone_number_required.tr();
                          }
                        },
                        decoration: InputDecoration(
                          labelText: LocaleKeys.phone_number_text.tr(),
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
                            return LocaleKeys.password_required_text.tr();
                          } else if (value.length < 8) {
                            return LocaleKeys.password_too_short_text.tr();
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
                          labelText: LocaleKeys.Password_text.tr(),
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
                            return LocaleKeys.password_dont_match_text.tr();
                          } else if (value != _userInfo['password']) {
                            return LocaleKeys.password_dont_match_text.tr();
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
                          labelText: LocaleKeys.confirm_password_text.tr(),
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
                                  if (widget.url != null) {
                                    User _user = response.data;
                                    List<String> datas = widget.url!.split(':');
                                    if (_user.id == datas[1]) {
                                      await Provider.of<FundraiseModel>(context,
                                              listen: false)
                                          .getSingleFundraise(datas[0]);
                                      Response _responseSingleFundraise =
                                          Provider.of<FundraiseModel>(context,
                                                  listen: false)
                                              .response;
                                      if (_responseSingleFundraise.status ==
                                          ResponseStatus.SUCCESS) {
                                        Fundraise _fundraise =
                                            _responseSingleFundraise.data;
                                        _fundraise.beneficiary =
                                            User(id: datas[1]);
                                        await Provider.of<FundraiseModel>(
                                                context,
                                                listen: false)
                                            .updateFundraise(_fundraise,
                                                model.response.data);
                                        Response _responseUpdateFundraise =
                                            Provider.of<FundraiseModel>(context,
                                                    listen: false)
                                                .response;
                                        if (_responseUpdateFundraise.status ==
                                            ResponseStatus.SUCCESS) {
                                          Navigator.of(context).pop();
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  HomePage.routeName,
                                                  (route) => false,
                                                  arguments: 2);
                                        } else {
                                          Navigator.of(context).pop();
                                          Fluttertoast.showToast(
                                              msg: "Something went wrong",
                                              toastLength: Toast.LENGTH_LONG);
                                        }
                                      }
                                    } else {
                                      Fluttertoast.showToast(
                                        msg:
                                            "err: err: you are not invited this fundraiser",
                                        toastLength: Toast.LENGTH_LONG,
                                      );
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              HomePage.routeName,
                                              (Route<dynamic> route) => false);
                                    }
                                  } else
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
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
                            LocaleKeys.register_button_text.tr(),
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
                    child: GestureDetector(
                      key: Key("login_text_button"),
                      onTap: () {
                        widget.url != null
                            ? Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => SignupPage(
                                    url: widget.url,
                                  ),
                                ),
                              )
                            : Navigator.of(context)
                                .pushReplacementNamed(SigninPage.routeName);
                      },
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: LocaleKeys.already_have_account_text.tr(),
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                          text: LocaleKeys.login_appbar_title.tr(),
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                        )
                      ])),
                    ),
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
