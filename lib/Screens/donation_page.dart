import 'package:crowd_funding_app/Models/donation.dart';
import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/Screens/popular_fundraise_detail.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:crowd_funding_app/services/provider/donation.dart';
import 'package:crowd_funding_app/widgets/bank_info.dart';
import 'package:crowd_funding_app/widgets/continue_button.dart';
import 'package:crowd_funding_app/widgets/loading_progress.dart';
import 'package:crowd_funding_app/widgets/response_alert.dart';
import 'package:crowd_funding_app/widgets/your_donation_detail.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class DonationPage extends StatefulWidget {
  DonationPage({Key? key, required this.fundraise}) : super(key: key);
  final Fundraise fundraise;

  @override
  DonationPageState createState() => DonationPageState();
}

class DonationPageState extends State<DonationPage> {
  Map<String, dynamic> _myData = {};
  getInformation() async {
    UserPreference userPreference = UserPreference();
    PreferenceData _userData = await userPreference.getUserInfromation();
    User _user = _userData.data;
    setState(() {
      _myData['email'] = _user.email;
      _myData['firstName'] = _user.firstName;
      _myData['lastName'] = _user.lastName;
    });
  }

  @override
  void initState() {
    getInformation();
    super.initState();
  }

  bool _bankInfoValidated = false;
  final _formKey = GlobalKey<FormState>();
  double _sliderValue = 10.0;
  int _donation = 0;

  double _tip = 0.0;
  bool _showDoantionInfo = false;

  @override
  Widget build(BuildContext context) {
    print("data is $_myData");
    _tip = _sliderValue * 0.01;

    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "GoFundMe",
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  width: size.width,
                  child: Image.asset(
                    "assets/images/image1.png",
                    fit: BoxFit.fill,
                    height: size.height * 0.25,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "You're supporiting",
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                            TextSpan(
                              text: " ${widget.fundraise.title}",
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Your donation will benefit",
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                            TextSpan(
                              text:
                                  " ${widget.fundraise.beneficiary!.firstName} ${widget.fundraise.beneficiary!.lastName} ",
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Divider(
                        thickness: 1.5,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Enter your donation",
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'the minimum amount is \$5';
                            } else if (int.parse(value) < 5) {
                              return "the minimum amount is \$5";
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              _donation = int.parse(value);
                            });
                          },
                          textAlign: TextAlign.end,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            suffixText: ".00",
                            contentPadding: EdgeInsets.only(
                              top: 10.0,
                              bottom: 10.0,
                              right: 20.0,
                            ),
                            prefixIcon: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "\$",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "USD",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Divider(
                        thickness: 1.5,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Tip GoFundMe Services",
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        child: Text(
                          'GoFundMe has a 0% platform fee for organizers. GoFundMe will continue offering its services thanks to donors who will leave an option.',
                          style: TextStyle(color: Colors.grey, height: 1.5),
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text("10%",
                                  style: labelTextStyle.copyWith(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor))),
                          Expanded(
                            flex: 10,
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                  activeTrackColor: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.6),
                                  trackHeight: 4.0,
                                  tickMarkShape: RoundSliderTickMarkShape(),
                                  thumbColor: Theme.of(context).accentColor,
                                  activeTickMarkColor: Colors.white,
                                  inactiveTickMarkColor: Colors.white,
                                  valueIndicatorColor:
                                      Theme.of(context).backgroundColor),
                              child: Slider.adaptive(
                                label:
                                    "${_donation == 0 ? "" : _tip.toStringAsFixed(1)}  $_sliderValue%",
                                divisions: 10,
                                min: 10.0,
                                max: 25.0,
                                value: _sliderValue,
                                onChanged: (value) {
                                  setState(() {
                                    _sliderValue = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text("25%",
                                style: labelTextStyle.copyWith(
                                    color: Theme.of(context)
                                        .secondaryHeaderColor)),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      if (_showDoantionInfo)
                        BankInformation(
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
                        height: 20.0,
                      ),
                      if (_showDoantionInfo)
                        YourDonationDetail(
                          donation: _donation,
                          tip: _tip,
                        ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ContinueButton(
                          isValidate:
                              _showDoantionInfo ? _bankInfoValidated : true,
                          onPressed: () async {
                            if (_showDoantionInfo) {
                              if (_formKey.currentState!.validate()) {
                                loadingProgress(context);
                                UserPreference userPreference =
                                    UserPreference();
                                PreferenceData tokenData =
                                    await userPreference.getUserToken();
                                PreferenceData userData =
                                    await userPreference.getUserInfromation();
                                Donation donation = Donation(
                                  amount: _donation,
                                  userID: userData.data,
                                  memberID: userData.data.id,
                                  tip: double.parse(
                                      (_tip * _donation).toStringAsFixed(1)),
                                  comment:
                                      'donated \$$_donation amount of money',
                                );

                                print(donation);

                                await context
                                    .read<DonationModel>()
                                    .createDonation(donation, tokenData.data,
                                        widget.fundraise.id!);
                                Response response =
                                    context.read<DonationModel>().response;
                                if (response.status == ResponseStatus.SUCCESS) {
                                  Navigator.of(context).pop();
                                  Fluttertoast.showToast(msg: response.message);
                                } else {
                                  ResponseAlert(response.message);
                                }
                              }
                            } else {
                              setState(() {
                                _showDoantionInfo = true;
                              });
                            }
                          },
                          title: _showDoantionInfo ? "Donate now" : "Continue")
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
