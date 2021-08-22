import 'package:crowd_funding_app/Screens/withdrawal_info_view.dart';
import 'package:crowd_funding_app/constants/constants.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:crowd_funding_app/widgets/continue_button.dart';
import 'package:crowd_funding_app/widgets/form_lable.dart';
import 'package:flutter/material.dart';

class WithdrawalUserInfo extends StatefulWidget {
  const WithdrawalUserInfo({Key? key}) : super(key: key);

  @override
  _WithdrawalUserInfoState createState() => _WithdrawalUserInfoState();
}

class _WithdrawalUserInfoState extends State<WithdrawalUserInfo> {
  final _formKey = GlobalKey<FormState>();

  Map<String, dynamic> _formData = {};

  String _month = 'Month';
  String _day = "Day";
  String _year = "Year";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("user info"),
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
                    FormLabel(
                      'Date of birth',
                    ),
                    DropdownButtonFormField<String>(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      value: _month,
                      validator: (value) {
                        if (value == 'Month') {
                          return 'Required';
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          _month = value!;
                        });
                      },
                      decoration: inputDecoration,
                      items: months
                          .map(
                            (item) => DropdownMenuItem(
                              child: Text(item),
                              value: item,
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    DropdownButtonFormField<String>(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      value: _day,
                      onChanged: (value) {
                        setState(() {
                          _day = value!;
                        });
                      },
                      validator: (value) {
                        if (value == 'Day') {
                          return 'Required';
                        }
                      },
                      decoration: inputDecoration,
                      items: days
                          .map((item) => DropdownMenuItem(
                                child: Text(item),
                                value: item,
                              ))
                          .toList(),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    DropdownButtonFormField<String>(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      value: _year,
                      onChanged: (value) {
                        setState(() {
                          _year = value!;
                        });
                      },
                      validator: (value) {
                        if (value!.startsWith('Year')) {
                          return "Required";
                        }
                      },
                      decoration: inputDecoration,
                      items: years
                          .map((year) => DropdownMenuItem(
                                child: Text(year),
                                value: year,
                              ))
                          .toList(),
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
                    ContinueButton(
                      isValidate: true,
                      onPressed: () {
                        _formKey.currentState!.save();
                        if (_formKey.currentState!.validate()) {
                          Map<String, dynamic> _data = _formData;
                          _data['date'] = _month + "/" + _day + "/" + _year;
                          _data['country'] = "ET";
                          _data['code'] = "ET";
                          print('$_data');
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => WithdrawalUserInfoView(
                                      _data,
                                    )),
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
                              color: Theme.of(context).secondaryHeaderColor,
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

