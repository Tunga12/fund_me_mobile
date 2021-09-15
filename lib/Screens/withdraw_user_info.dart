import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/Screens/loading_screen.dart';
import 'package:crowd_funding_app/Screens/withdrawal_info_view.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/constants/constants.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:crowd_funding_app/widgets/continue_button.dart';
import 'package:crowd_funding_app/widgets/form_lable.dart';
import 'package:flutter/material.dart';

class WithdrawalUserInfo extends StatefulWidget {
  const WithdrawalUserInfo(this.fundraise, this.isBeneficiary, {Key? key})
      : super(key: key);
  final Fundraise fundraise;
  final bool isBeneficiary;

  @override
  _WithdrawalUserInfoState createState() => _WithdrawalUserInfoState();
}

class _WithdrawalUserInfoState extends State<WithdrawalUserInfo> {
  final _formKey = GlobalKey<FormState>();

  Map<String, dynamic> _formData = {};
  User? _user;

  _getUserInformation() async {
    UserPreference _userPreference = UserPreference();
    PreferenceData _preferenceData = await _userPreference.getUserInfromation();
    if (mounted) {
      setState(() {
        _user = _preferenceData.data;
      });
    }
  }

  @override
  void initState() {
    _getUserInformation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _user == null
        ? LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              title: Text("User info"),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 40.0,
                  horizontal: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "GoFundMe is required to collect this information, it will only be used to verify your identify.",
                      style: kBodyTextStyle.copyWith(
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "You will need to be 18 or older and have a social security number to continue. If your information cannot be verified, there is a chance that you will later be asked to supply supporting documentation. To read more about what is required, please click here.",
                      style: kBodyTextStyle.copyWith(
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'If you would like someone else to withdraw funds, please add them as beneficiary. ',
                      style: kBodyTextStyle.copyWith(
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "User Information",
                            style: kBodyTextStyle.copyWith(
                              fontSize: 20.0,
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                          ),
                          Divider(
                            thickness: 1.5,
                          ),
                          FormLabel('First name'),
                          TextFormField(
                            initialValue: _user!.firstName,
                            onSaved: (value) {
                              setState(() {
                                _formData['firstName'] = value;
                              });
                            },
                            validator: inputValidator,
                            decoration: inputDecoration,
                          ),
                          FormLabel('Last name'),
                          TextFormField(
                            initialValue: _user!.lastName,
                            onSaved: (value) {
                              setState(() {
                                _formData['lastName'] = value;
                              });
                            },
                            validator: inputValidator,
                            decoration: inputDecoration,
                          ),
                          FormLabel('email'),
                          TextFormField(
                            initialValue: _user!.email,
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (value) {
                              setState(() {
                                _formData['email'] = value;
                              });
                            },
                            validator: inputValidator,
                            decoration: inputDecoration,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Bank Information",
                            style: kBodyTextStyle.copyWith(
                              fontSize: 20.0,
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                          ),
                          Divider(
                            thickness: 1.5,
                          ),
                          FormLabel('Bank Name'),
                          TextFormField(
                            onSaved: (value) {
                              setState(() {
                                _formData['bankName'] = value;
                              });
                            },
                            validator: inputValidator,
                            decoration: inputDecoration,
                          ),
                          FormLabel('Account Number'),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            maxLength: 20,
                            onSaved: (value) {
                              setState(() {
                                _formData['accountNumber'] = value;
                              });
                            },
                            validator: inputValidator,
                            decoration: inputDecoration,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ContinueButton(
                            isValidate: true,
                            onPressed: () {
                              _formKey.currentState!.save();
                              if (_formKey.currentState!.validate()) {
                                Map<String, dynamic> _data = _formData;

                                print('$_data');
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        WithdrawalUserInfoView(
                                      _data,
                                      widget.fundraise,
                                      isBeneficiary: widget.isBeneficiary,
                                    ),
                                  ),
                                );
                              }
                            },
                            title: "Save your info",
                          ),
                          SizedBox(height: 40.0),
                          Divider(thickness: 1.5),
                          Center(
                            child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Go back",
                                  style: kBodyTextStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                  ),
                                )),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
