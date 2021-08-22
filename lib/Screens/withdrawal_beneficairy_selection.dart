import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Screens/setup_withdrawal.dart';
import 'package:crowd_funding_app/Screens/withdraw_invite_beneficiary.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:crowd_funding_app/widgets/continue_button.dart';
import 'package:flutter/material.dart';

class WithdrawalBeneficiarySelection extends StatefulWidget {
  const WithdrawalBeneficiarySelection(this.fundraise, {Key? key})
      : super(key: key);
  final Fundraise fundraise;

  @override
  _WithdrawalBeneficiarySelectionState createState() =>
      _WithdrawalBeneficiarySelectionState();
}

class _WithdrawalBeneficiarySelectionState
    extends State<WithdrawalBeneficiarySelection> {
  final _formKey = GlobalKey<FormState>();

  final _formData = {
    'beneficiary': '0',
    'type': '0',
  };
  List<DropdownButtonObject> _types = [
    DropdownButtonObject('0', "Select Type"),
    DropdownButtonObject('1', "Personal"),
    DropdownButtonObject('2', "Company"),
    DropdownButtonObject('3', "PartnerShip")
  ];

  List<DropdownButtonObject> _beneficiary = [
    DropdownButtonObject('0', "Select"),
    DropdownButtonObject('1', "Myself"),
    DropdownButtonObject('2', "Someone else"),
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print("beneficiary is ");
    print(_formData['beneficiary']);
    print("type  is ");
    print(_formData['type']);

    return Scaffold(
      appBar: AppBar(
        title: Text("select beneficiary"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'who will withdraw the funds?',
                style: kBodyTextStyle.copyWith(
                  color: Theme.of(context).secondaryHeaderColor,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                onChanged: () => _formKey.currentState!.validate(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<String>(
                      items: _beneficiary
                          .map((item) => DropdownMenuItem(
                                child: Text(item.name),
                                value: item.id,
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == "0") {
                          return "Field required";
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          _formData['beneficiary'] = value!;
                        });
                      },
                      value: '0',
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
                      height: 10.0,
                    ),
                    Text(
                      'Must be 18+ with valid ID',
                      style: kBodyTextStyle.copyWith(
                        color: Theme.of(context)
                            .secondaryHeaderColor
                            .withOpacity(0.5),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      'What type of entity withdrawal is right for you?',
                      style: kBodyTextStyle.copyWith(
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    DropdownButtonFormField<String>(
                      items: _types
                          .map((item) => DropdownMenuItem(
                                child: Text(item.name),
                                value: item.id,
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == "0") {
                          return "Field required";
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          _formData['type'] = value!;
                        });
                      },
                      value: '0',
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 5.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          borderSide: BorderSide(width: 7.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              if (_formData['type'] != "0")
                Container(
                  width: size.width,
                  padding: EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.cyan[100],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.home,
                      color: Theme.of(context)
                          .secondaryHeaderColor
                          .withOpacity(0.6),
                    ),
                    title: Text(
                      "Funds will be withdrawn to a ${_types[int.parse(_formData['type']!)].name} bank account.",
                      style: labelTextStyle.copyWith(
                          fontSize: 20.0,
                          color: Theme.of(context)
                              .secondaryHeaderColor
                              .withOpacity(0.6)),
                    ),
                  ),
                ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'if this is confusing, we want to understand what kind of bank account you are withdrawing to ',
                      style: ksbodyTextStyle.copyWith(
                        fontSize: 12.0,
                        color: Theme.of(context)
                            .secondaryHeaderColor
                            .withOpacity(0.5),
                      ),
                    ),
                    TextSpan(
                      text: 'Read more here',
                      style: ksbodyTextStyle.copyWith(
                        height: 1.5,
                        fontSize: 12.0,
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                'Accounts can belong to a person or organization(501(c)(3).business,trust,etc) For organizations, the individual withdrawingmust be a beneficial owner, someone with significatn responsiblity to control, manage, or direct the organization(e.g. a Chief Executive Officer, Vice President, Treasure, or a controller).',
                style: ksbodyTextStyle.copyWith(
                  height: 1.5,
                  color:
                      Theme.of(context).secondaryHeaderColor.withOpacity(0.5),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              ContinueButton(
                  isValidate: true,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_formData['beneficiary'] == '1') {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => SetupWithdrawal(
                                  fundraise: widget.fundraise)),
                        );
                      } else if (_formData['beneficiary'] == '2') {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              InviteBeneficiary(widget.fundraise),
                        ));
                      }
                    }
                  },
                  title: "Next")
            ],
          ),
        ),
      ),
    );
  }
}

class DropdownButtonObject {
  String id;
  String name;

  DropdownButtonObject(this.id, this.name);
}
