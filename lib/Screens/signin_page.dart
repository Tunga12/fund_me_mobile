import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/Screens/home_page.dart';
import 'package:crowd_funding_app/Screens/signup_page.dart';
import 'package:crowd_funding_app/services/provider/auth.dart';
import 'package:crowd_funding_app/services/provider/fundraise.dart';
import 'package:crowd_funding_app/services/provider/user.dart';
import 'package:crowd_funding_app/translations/locale_keys.g.dart';
import 'package:crowd_funding_app/widgets/authdialog.dart';
import 'package:crowd_funding_app/widgets/forgot_password_invitation.dart';
import 'package:crowd_funding_app/widgets/loading_progress.dart';
import 'package:crowd_funding_app/widgets/or.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

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
            title: Text(LocaleKeys.login_appbar_title.tr()),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Image(
                    image: AssetImage(
                      "assets/images/logo_image.PNG",
                    ),
                    width: size.width * 0.1,
                    height: size.height * 0.1,
                  ),
                ),
                Form(
                  key: _formKey,
                  // onChanged: () {
                  //   setState(() {
                  //     isValidated = _formKey.currentState!.validate();
                  //   });
                  // },
                  child: Column(
                    children: [
                      TextFormField(
                        key: Key("email_formfield"),
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (value) {
                          this._userInfo['email'] = value;
                        },
                        onChanged: (value) {
                          setState(() {
                            this._userInfo['email'] = value;
                            isValidated =
                                this._userInfo['email'].toString().length > 5 &&
                                    this
                                            ._userInfo['password']
                                            .toString()
                                            .length >
                                        5;
                          });
                          print(this._userInfo['password']);
                          print(this._userInfo['email']);
                        },
                        validator: (value) {
                          if (value!.length < 5) {
                            return "Incorrect Email or Password!";
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
                        key: Key('password_formfield'),
                        obscureText: _isObscured,
                        onSaved: (value) {
                          this._userInfo['password'] = value;
                        },
                        onChanged: (value) {
                          setState(() {
                            this._userInfo['password'] = value;
                            isValidated = this
                                        ._userInfo['password']
                                        .toString()
                                        .length >
                                    5 &&
                                this._userInfo['email'].toString().length > 5;
                          });
                          print(this._userInfo['password']);
                          print(this._userInfo['email']);
                        },
                        validator: (value) {
                          if (value!.length < 5) {
                            return "Incorrect Email or Password!";
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
                      SizedBox(
                        height: 18.0,
                      ),
                      SizedBox(
                        width: size.width,
                        height: size.height * 0.08,
                        child: TextButton(
                          key: Key('signinbutton_key'),
                          style: TextButton.styleFrom(
                            backgroundColor: isValidated
                                ? Theme.of(context).accentColor
                                : Theme.of(context)
                                    .secondaryHeaderColor
                                    .withAlpha(180),
                          ),
                          onPressed: () async {
                            _formKey.currentState!.save();
                            if (_formKey.currentState!.validate()) {
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
                                            "err: you are not invited this fundraiser",
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
                            LocaleKeys.login_button_text.tr(),
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
                    LocaleKeys.forgot_password_or_text.tr(),
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                OrDivider(),
                SizedBox(
                  width: size.width * 0.7,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/googleIcon.png',
                                ),
                              )),
                        ),
                        // Image(
                        //   image: AssetImage(
                        //     'assets/images/googleIcon.png',

                        //   ),
                        //   width: 40.0,
                        // ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          LocaleKeys.continue_with_google_text.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  fontSize: 17.0,
                                  color: Theme.of(context).backgroundColor),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextButton(
                  key: Key("signup_button_text"),
                  onPressed: () {
                    widget.url != null
                        ? Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => SignupPage(
                                url: widget.url,
                              ),
                            ),
                          )
                        : Navigator.of(context).pushReplacementNamed(
                            SignupPage.routeName
                          );
                  },
                  child: Text(
                    LocaleKeys.dont_have_account_text.tr(),
                    style: TextStyle(fontSize: 18.0),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
