import 'package:crowd_funding_app/constants/constants.dart';
import 'package:crowd_funding_app/widgets/form_lable.dart';
import 'package:flutter/material.dart';

class WithdrawaluserForm extends StatefulWidget {
  WithdrawaluserForm({
    Key? key,
    required this.saveCallback,
  }) : super(key: key);
  final Function saveCallback;

  @override
  _WithdrawaluserFormState createState() => _WithdrawaluserFormState();
}

class _WithdrawaluserFormState extends State<WithdrawaluserForm> {
  Map<String, dynamic> _formData = {};

  String _month = 'Month';
  String _day = "Day";
  String _year = "Year";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
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
              decoration: inputDecoration.copyWith(hintText: '123-45-6789'),
            ),
            SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}
