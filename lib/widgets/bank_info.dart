import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:flutter/material.dart';

enum Method {
  CREDITCARD,
  NONCREDIT,
}

class BankInformation extends StatefulWidget {
  final Fundraise fundraise;
  Map<String, dynamic> data;

  BankInformation({
    required this.callBack,
    required this.data,
    required this.validate,
    required this.fundraise,
  });
  final Function(bool value) validate;

  final Function(Map<String, dynamic> data) callBack;

  @override
  _BankInformationState createState() => _BankInformationState();
}

class _BankInformationState extends State<BankInformation> {
  Map<String, dynamic> _bankInfo = {};

  @override
  void initState() {
    super.initState();
    setState(() {
      _bankInfo = widget.data;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Method _method = Method.CREDITCARD;

  bool _useAsBilling = false;

  @override
  Widget build(BuildContext context) {
    print('bank info $_bankInfo');
    // print(widget.fundraise.withdraw.id.bankAccountNo);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            "Payment Method",
            style: labelTextStyle.copyWith(
                color: Theme.of(context).secondaryHeaderColor),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).secondaryHeaderColor.withOpacity(0.6),
              ),
              borderRadius: BorderRadius.circular(7.0)),
          child: Column(
            children: [
              Row(
                children: [
                  Radio<Method>(
                      value: Method.CREDITCARD,
                      groupValue: _method,
                      onChanged: (Method? value) {
                        _method = value!;
                      }),
                  Text(
                    "Use Credit or Debit Card",
                    style: labelTextStyle.copyWith(
                        color: Theme.of(context)
                            .secondaryHeaderColor
                            .withOpacity(0.5)),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 50.0, right: 20.0, top: 5.0, bottom: 5.0),
                child: Form(
                  key: _formKey,
                  onChanged: () {
                    widget.validate(_formKey.currentState!.validate());
                  },
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: _bankInfo['email'],
                        onChanged: (value) {
                          setState(() {
                            _bankInfo['email'] = value;
                          });
                          widget.callBack(_bankInfo);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Field required";
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "Email Address",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0))),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        initialValue: _bankInfo['firstName'],
                        onChanged: (value) {
                          setState(() {
                            _bankInfo['firstName'] = value;
                          });
                          widget.callBack(_bankInfo);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Field required";
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "First Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0))),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        initialValue: _bankInfo["lastName"],
                        onChanged: (value) {
                          setState(() {
                            _bankInfo['lastName'] = value;
                          });
                          widget.callBack(_bankInfo);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Field required";
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "Last Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0))),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: _useAsBilling,
                              onChanged: (value) {
                                _useAsBilling = value!;
                              }),
                          Text(
                            'Use as billing name',
                            style: labelTextStyle.copyWith(
                                color: Theme.of(context)
                                    .secondaryHeaderColor
                                    .withOpacity(0.7)),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        initialValue: widget.fundraise.withdrwal != null
                            ? widget.fundraise.withdrwal!.bankName
                            : null,
                        onChanged: (value) {
                          setState(() {
                            _bankInfo['bankName'] = value;
                          });
                          widget.callBack(_bankInfo);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Field required";
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "Bank Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0))),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        initialValue: widget.fundraise.withdrwal != null
                            ? widget.fundraise.withdrwal!.bankAccountNo
                            : null,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _bankInfo['accountNumber'] = value;
                          });
                          widget.callBack(_bankInfo);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Field required";
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "Bank account number",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0))),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
