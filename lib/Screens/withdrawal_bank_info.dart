import 'package:crowd_funding_app/Screens/withdraw_user_info.dart';
import 'package:crowd_funding_app/constants/constants.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:crowd_funding_app/widgets/form_lable.dart';
import 'package:flutter/material.dart';

class WithdrawalBankInfo extends StatefulWidget {
  const WithdrawalBankInfo(this.data, {Key? key}) : super(key: key);
  final Map<String, dynamic> data;

  @override
  _WithdrawalBankInfoState createState() => _WithdrawalBankInfoState();
}

class _WithdrawalBankInfoState extends State<WithdrawalBankInfo> {
  final _formKey = GlobalKey<FormState>();

  Map<String, dynamic> _bankFormData = {};

  List<String> _accountType = ['Checking', 'Saving'];

  Map<String, dynamic> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bank info'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 30.0,
            horizontal: 20.0,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Bank Information",
              style: kBodyTextStyle.copyWith(
                color: Theme.of(context).secondaryHeaderColor,
              ),
            ),
            Divider(
              thickness: 1.5,
            ),
            FormLabel("Routing number"),
            TextFormField(
              onSaved: (value) {},
              validator: inputValidator,
              decoration: inputDecoration,
            ),
            FormLabel("Account number"),
            TextFormField(
              keyboardType: TextInputType.number,
              onSaved: (value) {},
              validator: inputValidator,
              decoration: inputDecoration,
            ),
            FormLabel('Bank name'),
            TextFormField(
              onSaved: (value) {},
              validator: inputValidator,
              decoration: inputDecoration,
            ),
            FormLabel("Account type"),
            DropdownButtonFormField(
              value: _bankFormData['accountType'] ?? "Checking",
              onChanged: (value) {
                setState(() {
                  _bankFormData['accountType'] = value;
                });
              },
              decoration: inputDecoration,
              items: _accountType
                  .map((account) => DropdownMenuItem(
                        child: Text(account),
                        value: account,
                      ))
                  .toList(),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Bank Location",
              style: kBodyTextStyle.copyWith(
                color: Theme.of(context).secondaryHeaderColor,
              ),
            ),
            Divider(
              thickness: 1.5,
            ),
            FormLabel('City'),
            TextFormField(
              onSaved: (value) {
                setState(() {
                  _bankFormData['city'] = value;
                });
              },
              validator: inputValidator,
              decoration: inputDecoration,
            ),
            FormLabel("Country"),
            DropdownButtonFormField(
              onChanged: null,
              value: "1",
              decoration: inputDecoration,
              items: [
                DropdownMenuItem(
                  child: Text("Ethiopia"),
                  value: '1',
                )
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Account Owner Information",
              style: kBodyTextStyle.copyWith(
                color: Theme.of(context).secondaryHeaderColor,
              ),
            ),
            Divider(
              thickness: 1.5,
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormLabel('First name'),
                  TextFormField(
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
                    onSaved: (value) {
                      setState(() {
                        _formData['lastName'] = value;
                      });
                    },
                    validator: inputValidator,
                    decoration: inputDecoration,
                  ),
                  FormLabel('Street address'),
                  TextFormField(
                    onSaved: (value) {
                      setState(() {
                        _formData['streetAddress'] = value;
                      });
                    },
                    validator: inputValidator,
                    decoration: inputDecoration,
                  ),
                  FormLabel('City'),
                  TextFormField(
                    onSaved: (value) {
                      setState(() {
                        _formData['city'] = value;
                      });
                    },
                    validator: inputValidator,
                    decoration: inputDecoration,
                  ),
                  FormLabel('State'),
                  TextFormField(
                    onSaved: (value) {
                      setState(() {
                        _formData['state'] = value;
                      });
                    },
                    validator: inputValidator,
                    decoration: inputDecoration,
                  ),
                  FormLabel(
                    'Zip Code',
                  ),
                  TextFormField(
                    onSaved: (value) {
                      setState(() {
                        _formData['zipCode'] = value;
                      });
                    },
                    validator: inputValidator,
                    decoration: inputDecoration,
                  ),
                  FormLabel("Country"),
                  DropdownButtonFormField(
                    onChanged: null,
                    value: "1",
                    decoration: inputDecoration,
                    items: [
                      DropdownMenuItem(
                        child: Text("Ethiopia"),
                        value: '1',
                      )
                    ],
                  ),
                  FormLabel("Country code"),
                  DropdownButtonFormField(
                    onChanged: (value) {
                      setState(() {
                        _formData['countryCode'] = value;
                      });
                    },
                    onSaved: (value) {
                      setState(() {
                        _formData['countryCode'] = value;
                      });
                    },
                    value: _formData['countryCode'] ?? '1',
                    decoration: inputDecoration,
                    items: [
                      DropdownMenuItem(
                        child: Text("ET"),
                        value: '1',
                      )
                    ],
                  ),
                  FormLabel(
                    'Phone number',
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    onSaved: (value) {
                      setState(() {
                        _formData['phoneNumber'] = value;
                      });
                    },
                    validator: inputValidator,
                    decoration: inputDecoration,
                  ),
                  FormLabel('Full Social Security number'),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      setState(() {
                        _formData['ssn'] = value;
                      });
                    },
                    validator: inputValidator,
                    decoration:
                        inputDecoration.copyWith(hintText: '123-45-6789'),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
