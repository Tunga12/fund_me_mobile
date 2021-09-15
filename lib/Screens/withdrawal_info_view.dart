import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/Models/withdrawal.dart';
import 'package:crowd_funding_app/Screens/home_page.dart';
import 'package:crowd_funding_app/Screens/withdrawal_bank_info.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:crowd_funding_app/services/provider/withdrawal.dart';
import 'package:crowd_funding_app/widgets/continue_button.dart';
import 'package:crowd_funding_app/widgets/loading_progress.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class WithdrawalUserInfoView extends StatefulWidget {
  WithdrawalUserInfoView(this.data, this.fundraise,
      {Key? key, required this.isBeneficiary})
      : super(key: key);
  final Map<String, dynamic> data;
  final bool isBeneficiary;
  final Fundraise fundraise;

  @override
  _WithdrawalUserInfoViewState createState() => _WithdrawalUserInfoViewState();
}

class _WithdrawalUserInfoViewState extends State<WithdrawalUserInfoView> {
  User? _user;
  String? _token;

  _getUserInformation() async {
    UserPreference userPreference = UserPreference();
    PreferenceData _userPreferenceData =
        await userPreference.getUserInfromation();
    PreferenceData _tokenPreferenceData = await userPreference.getUserToken();

    setState(() {
      _user = _userPreferenceData.data;
      _token = _tokenPreferenceData.data;
    });
  }

  @override
  void initState() {
    _getUserInformation();
    super.initState();
  }

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
                trailingTitle: widget.data['firstName'],
                leadingTitle: "First name",
              ),
              UserInfoList(
                trailingTitle: widget.data['lastName'],
                leadingTitle: "Last name",
              ),
              UserInfoList(
                trailingTitle: widget.data['email'],
                leadingTitle: "Email",
              ),
              SizedBox(
                height: 10.0,
              ),
              Divider(
                thickness: 1.5,
              ),
              SizedBox(height: 10.0),
              UserInfoList(
                trailingTitle: widget.data['bankName'],
                leadingTitle: "Bank Name",
              ),
              UserInfoList(
                trailingTitle: widget.data['accountNumber'],
                leadingTitle: "Account Number",
              ),
              SizedBox(
                height: 30.0,
              ),
              ContinueButton(
                isValidate: true,
                onPressed: () async {
                  loadingProgress(context);
                  Withdrwal _withdrawal = Withdrwal(
                    bankName: widget.data['bankName'],
                    bankAccountNo: widget.data['accountNumber'],
                    isOrganizer: !widget.isBeneficiary,
                  
                  );

                  await context.read<WithdrawalModel>().createWithdrawal(
                      _withdrawal, _token!, widget.fundraise.id!);
                  Response response = context.read<WithdrawalModel>().response;
                  if (response.status == ResponseStatus.SUCCESS) {
                    Fluttertoast.showToast(
                        msg: "Withdraw pending",
                        toastLength: Toast.LENGTH_LONG);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        HomePage.routeName, (route) => false,
                        arguments: 2);
                  } else {
                    Navigator.of(context).pop();

                    Fluttertoast.showToast(
                        msg: response.message, toastLength: Toast.LENGTH_LONG);
                  }
                },
                title: 'Confirm withdrawal',
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
