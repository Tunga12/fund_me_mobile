import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Screens/withdraw_verify_benefit.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:crowd_funding_app/widgets/continue_button.dart';
import 'package:flutter/material.dart';

class InviteBeneficiary extends StatefulWidget {
  const InviteBeneficiary(this.fundraise, {Key? key}) : super(key: key);
  final Fundraise fundraise;

  @override
  _InviteBeneficiaryState createState() => _InviteBeneficiaryState();
}

class _InviteBeneficiaryState extends State<InviteBeneficiary> {
  String? _token;
  @override
  void initState() {
    super.initState();
    getTokenData();
  }

  getTokenData() async {
    UserPreference _userPreference = UserPreference();
    PreferenceData _preferedData = await _userPreference.getUserToken();
    setState(() {
      _token = _preferedData.data;
    });
  }

  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _formData = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invite beneficiary"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "First name",
                  style: kBodyTextStyle.copyWith(
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "field required";
                    } else if (value.length < 3) {
                      return 'field should atleas 3 chars';
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      _formData['firstName'] = value;
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 5.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7.0),
                      borderSide: BorderSide(width: 7.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "last name",
                  style: kBodyTextStyle.copyWith(
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "field required";
                    } else if (value.length < 3) {
                      return 'field should atleas 3 chars';
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      _formData['lastName'] = value;
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 5.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7.0),
                      borderSide: BorderSide(width: 7.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "email",
                  style: kBodyTextStyle.copyWith(
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "field required";
                    } else if (value.length < 5) {
                      return 'field should atleas 5 chars';
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      _formData['email'] = value;
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 5.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7.0),
                      borderSide: BorderSide(width: 7.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Grant full access ',
                        style: ksbodyTextStyle.copyWith(
                          fontSize: 14.0,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                      ),
                      TextSpan(
                        text:
                            "to this person who will withdraw the money raised. This person will be able to see donor names, send thank-yoy notes. and post campaign updates.",
                        style: ksbodyTextStyle.copyWith(
                          height: 1.5,
                          fontSize: 13.0,
                          color: Theme.of(context)
                              .secondaryHeaderColor
                              .withOpacity(0.5),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                ContinueButton(
                  isValidate: true,
                  onPressed: () {
                    _formKey.currentState!.save();
                    if (_formKey.currentState!.validate()) {
                      debugPrint("Validated");
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => WithdrawVerifyBeneficiary(
                            token: _token!,
                            data: _formData,
                            fundraise: widget.fundraise,
                          ),
                        ),
                      );
                    }
                  },
                  title: "Invite beneficiary",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
