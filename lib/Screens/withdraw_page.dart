import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Models/total_raised.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/Screens/withdraw_user_info.dart';
import 'package:crowd_funding_app/Screens/withdrawal_beneficairy_selection.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/services/provider/currency.dart';
import 'package:crowd_funding_app/widgets/custom_card.dart';
import 'package:crowd_funding_app/widgets/withdraw_note.dart';
import 'package:crowd_funding_app/widgets/withdrawal_beneficiary_invited_body.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:jiffy/jiffy.dart';

// ignore: must_be_immutable
class WithdrawPage extends StatefulWidget {
  WithdrawPage(
      {Key? key,
      required this.fundraise,
      this.isSetUped,
      this.beneficiary,
      required this.isAccepted,
      required this.isWithdawn})
      : super(key: key);

  final Fundraise fundraise;
  bool? isSetUped = false;
  User? beneficiary;
  final bool isWithdawn;
  final bool isAccepted;

  @override
  _WithdrawPageState createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  User? _user;
  double totalRaised = 0.0;

  _getUserInformation() async {
    UserPreference userPreference = UserPreference();
    PreferenceData userData = await userPreference.getUserInfromation();
    PreferenceData tokeData = await userPreference.getUserToken();

    setState(() {
      _user = userData.data;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserInformation();
    _getCurrencyExcange();
  }

  String _getTitle() {
    if (widget.fundraise.withdrwal!.id == '') {
      return "Set up withdrawals";
    } else if (widget.fundraise.withdrwal!.status == 'pending') {
      return 'Withdrawal Pending...';
    } else if (widget.fundraise.withdrwal!.status == 'declined') {
      return 'Set up withdrawals';
    } else {
      return 'View previous withdrawals';
    }
  }

  _getCurrencyExcange() {
    Response _response = context.read<CurrencyRateModel>().response;
    double _currencyRate = _response.data is double ? _response.data : 0.0;
    TotalRaised _totalRaised = widget.fundraise.totalRaised!;
    double _dollarValue = _currencyRate * _totalRaised.dollar!.toDouble();
    double _totalRaisedResponse = _dollarValue + _totalRaised.birr!;
    setState(() {
      totalRaised = _totalRaisedResponse;
    });
  }

  _showPreviousWithdrawals() {
    return AlertDialog(
      title: Text('Total withdrawal'),
      content: SingleChildScrollView(
        child: Column(
          children: widget.fundraise.totalWithdrawal!.map((prev) {
            final date = Jiffy(prev.dateCreated).yMMMMd;
            print(widget.fundraise.totalWithdrawal);
            return ListTile(
              title: Text("${prev.amount}"),
              trailing: Text("$date"),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("currency rate");
    print(widget.fundraise.totalWithdrawal);
    final size = MediaQuery.of(context).size;
    if (widget.isSetUped!) {
      if (widget.beneficiary!.id == _user!.id) {
        return WithdrawalUserInfo(widget.fundraise, true);
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Withdraw",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Divider(
                    thickness: 1.5,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Total raised from this fundraiser (after ",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        TextSpan(
                            text: "fees",
                            style: Theme.of(context).textTheme.bodyText2),
                        TextSpan(
                          text: ")",
                          style: Theme.of(context).textTheme.bodyText1,
                        )
                      ],
                    ),
                  ),
                  Text(
                    "${totalRaised.toStringAsFixed(2)} ETB",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 40.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Divider(
                    thickness: 1.5,
                  ),
                  if (widget.isSetUped != null)
                    if (widget.isSetUped == false)
                      Container(
                        child: Column(
                          children: [
                            SizedBox(
                              width: size.width,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).accentColor),
                                onPressed: () {
                                  if (_getTitle() == 'Set up withdrawals')
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            WithdrawalBeneficiarySelection(
                                                widget.fundraise),
                                      ),
                                    );
                                  else if (_getTitle() ==
                                      'View previous withdrawals') {
                                    print('view previous donations...');
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            _showPreviousWithdrawals());
                                  } else if (_getTitle() ==
                                      'Withdrawal Pending...') {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Withdrawal is pending, please wait for approval");
                                  }
                                },
                                child: Text(
                                  _getTitle(),
                                  style: TextStyle(
                                    color: Theme.of(context).backgroundColor,
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 1.5,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Take a minute to review these important details: ",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.check,
                                          size: 20.0,
                                          color: Theme.of(context).accentColor),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Expanded(
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                style: TextStyle(
                                                    color: Colors.grey[700]),
                                                text:
                                                    "If you do not set up withdrawals within 90 days of your first donation,",
                                              ),
                                              TextSpan(
                                                text:
                                                    "all donations will be refunded",
                                                style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  WithdrawNote(
                                    "Settings up withdrawals will not end your campaign. Your Campaing will continue will continue to accept donations",
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  WithdrawNote(
                                    "Withdrawls to a bank account will start arriving in 2-5 business days after setup.",
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  WithdrawNote(
                                    "Need Someone else to withdrawals the money? No problem! You can grant them sole access as part of this process.",
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    else
                      BeneficiaryVinvited(
                        beneficiary: widget.beneficiary!,
                        isAccepted: widget.isAccepted,
                        isWithdrawn: widget.isWithdawn,
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
