import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/Models/withdrawal.dart';
import 'package:crowd_funding_app/Screens/home_page.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/services/provider/withdrawal.dart';
import 'package:crowd_funding_app/widgets/authdialog.dart';
import 'package:crowd_funding_app/widgets/bank_info.dart';
import 'package:crowd_funding_app/widgets/continue_button.dart';
import 'package:crowd_funding_app/widgets/loading_progress.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SetupWithdrawal extends StatefulWidget {
  const SetupWithdrawal({Key? key, required this.fundraise}) : super(key: key);
  final Fundraise fundraise;

  @override
  _SetupWithdrawalState createState() => _SetupWithdrawalState();
}

class _SetupWithdrawalState extends State<SetupWithdrawal> {
  Map<String, dynamic> _myData = {};
  String _token = "";
  getInformation() async {
    UserPreference userPreference = UserPreference();
    PreferenceData _userData = await userPreference.getUserInfromation();
    PreferenceData _tokenData = await userPreference.getUserToken();
    User _user = _userData.data;
    setState(() {
      _myData['email'] = _user.email;
      _myData['firstName'] = _user.firstName;
      _myData['lastName'] = _user.lastName;
      _token = _tokenData.data;
    });
  }

  @override
  void initState() {
    super.initState();
    getInformation();
  }

  bool _bankInfoValidated = false;

  @override
  Widget build(BuildContext context) {
    print("setup withdrawl $_myData");
    return _myData.isEmpty && _token.isEmpty
        ? Container()
        : Scaffold(
            appBar: AppBar(
              title: Text("Setup withdrawal"),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 20.0,
                ),
                child: Column(
                  children: [
                    BankInformation(
                      fundraise: widget.fundraise,
                      data: _myData,
                      validate: (value) {
                        setState(() {
                          _bankInfoValidated = value;
                        });
                      },
                      callBack: (data) {
                        setState(() {
                          _myData = data;
                        });
                      },
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    ContinueButton(
                      isValidate: _bankInfoValidated ||
                          widget.fundraise.withdrwal != null,
                      onPressed: () async {
                        if (_bankInfoValidated) {
                          loadingProgress(context);
                          Withdrwal _withdrawal = Withdrwal(
                            bankName: _myData['bankName'],
                            bankAccountNo: _myData['accountNumber'],
                            isOrganizer: true,
                          );
                          await context
                              .read<WithdrawalModel>()
                              .createWithdrawal(
                                  _withdrawal, _token, widget.fundraise.id!);
                          Response response =
                              context.read<WithdrawalModel>().response;
                          if (response.status == ResponseStatus.SUCCESS) {
                            Fluttertoast.showToast(
                                msg: "Withdraw pending",
                                toastLength: Toast.LENGTH_LONG);
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                HomePage.routeName, (route) => false);
                          } else {
                            Navigator.of(context).pop();

                            authShowDialog(context, Text(response.message),
                                error: true, close: true);
                          }
                        }
                      },
                      title: "Withdraw",
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
