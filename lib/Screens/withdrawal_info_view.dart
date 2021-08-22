import 'package:crowd_funding_app/Screens/withdrawal_bank_info.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:crowd_funding_app/widgets/continue_button.dart';
import 'package:flutter/material.dart';

class WithdrawalUserInfoView extends StatelessWidget {
  const WithdrawalUserInfoView(this.data, {Key? key}) : super(key: key);
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("user info"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 30.0,
            horizontal: 20.0,
          ),
          child: Column(
            children: [
              Text(
                'Please review the following information to be sure the details match your legal information as it appears on your government issued ID or support',
                style: kBodyTextStyle.copyWith(
                  color: Theme.of(context).secondaryHeaderColor,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'As a reminder, GoFundMe is required to collect this informaton in order to process withdrawals to your count. It will only be used to verify your identity. If we cannot verify your identity with the information,there is a chance that you will be required to supply documentation. To learn more about what is required, please refer to our support guide on withdrawal requirements.',
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
                height: 10.0,
              ),
              UserInfoList(
                trailingTitle: data['firstName'],
                leadingTitle: "First name",
              ),
              UserInfoList(
                trailingTitle: data['lastName'],
                leadingTitle: "Last name",
              ),
              UserInfoList(
                trailingTitle: data['streetAddress'],
                leadingTitle: "Street address",
              ),
              UserInfoList(
                trailingTitle: data['city'],
                leadingTitle: "City",
              ),
              UserInfoList(
                trailingTitle: data['code'],
                leadingTitle: "Zip code",
              ),
              UserInfoList(
                trailingTitle: data['country'],
                leadingTitle: "country",
              ),
              UserInfoList(
                trailingTitle: data['phoneNumber'],
                leadingTitle: "Phone Number",
              ),
              UserInfoList(
                trailingTitle: data['ssn'],
                leadingTitle: "Social security number",
              ),
              UserInfoList(
                trailingTitle: data['date'],
                leadingTitle: "Date of birth",
              ),
              SizedBox(
                height: 30.0,
              ),
              ContinueButton(
                isValidate: true,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => WithdrawalBankInfo(data),
                    ),
                  );
                },
                title: 'Confirm your information',
              ),
              SizedBox(
                height: 20.0,
              ),
              Divider(
                thickness: 1.5,
              ),
              SizedBox(
                height: 10.0,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Edit your information',
                  style: kBodyTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UserInfoList extends StatelessWidget {
  const UserInfoList({
    Key? key,
    required this.leadingTitle,
    required this.trailingTitle,
  }) : super(key: key);

  final String leadingTitle;
  final String trailingTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20.0,
        ),
        Row(
          children: [
            Text(
              "$leadingTitle:",
              style: kBodyTextStyle.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).secondaryHeaderColor,
              ),
            ),
            Text(
              '$trailingTitle',
              style: kBodyTextStyle.copyWith(
                color: Theme.of(context).secondaryHeaderColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
