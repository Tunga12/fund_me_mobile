import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Screens/withdraw_page.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:crowd_funding_app/services/provider/withdrawal.dart';
import 'package:crowd_funding_app/widgets/continue_button.dart';
import 'package:crowd_funding_app/widgets/loading_progress.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class WithdrawVerifyBeneficiary extends StatelessWidget {
  const WithdrawVerifyBeneficiary(
      {Key? key,
      required this.data,
      required this.fundraise,
      required this.token})
      : super(key: key);
  final Map<String, dynamic> data;
  final Fundraise fundraise;
  final String token;

  @override
  Widget build(BuildContext context) {
    print('Token data');
    print(token);
    return Scaffold(
      appBar: AppBar(
        title: Text('verify beneficiary'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
        child: Column(
          children: [
            Text(
              "You are about to give away access to All of the campaign's money to:",
              style: kBodyTextStyle.copyWith(
                color: Theme.of(context).secondaryHeaderColor,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              data['firstName'] + " " + data['lastName'],
              style: kBodyTextStyle.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).secondaryHeaderColor,
              ),
            ),
            Text(
              data['email'],
              style: kBodyTextStyle.copyWith(
                color: Theme.of(context).secondaryHeaderColor.withOpacity(0.5),
              ),
            ),
            Divider(
              thickness: 1.2,
              color: Theme.of(context).secondaryHeaderColor.withOpacity(0.5),
            ),
            SizedBox(
              height: 10.0,
            ),
            ContinueButton(
                isValidate: true,
                onPressed: () async {
                  loadingProgress(context);
                  await context
                      .read<WithdrawalModel>()
                      .inviteBeneficiary(data['email'], token, fundraise.id!);
                  Response _response = context.read<WithdrawalModel>().response;
                  if (_response.status == ResponseStatus.SUCCESS) {
                    Navigator.of(context).pop();
                    print(_response.data);
                    Fluttertoast.showToast(
                      msg:
                          'Successfully invited you will get notification when the user accept ',
                      toastLength: Toast.LENGTH_LONG,
                    );
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => WithdrawPage(
                          fundraise: Fundraise(totalRaised: 0),
                          isSetUped: true,
                        ),
                      ),
                    );
                  }
                },
                title: "Invite beneficiary")
          ],
        ),
      ),
    );
  }
}
