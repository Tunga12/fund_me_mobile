import 'package:crowd_funding_app/Models/donation.dart';
import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/Screens/home_page.dart';
import 'package:crowd_funding_app/Screens/payment_button.dart';
import 'package:crowd_funding_app/Screens/web_view.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:crowd_funding_app/services/provider/donation.dart';
import 'package:crowd_funding_app/widgets/authdialog.dart';
import 'package:crowd_funding_app/widgets/bank_info.dart';
import 'package:crowd_funding_app/widgets/comment_box.dart';
import 'package:crowd_funding_app/widgets/continue_button.dart';
import 'package:crowd_funding_app/widgets/custom_cached_network_image.dart';
import 'package:crowd_funding_app/widgets/loading_progress.dart';
import 'package:crowd_funding_app/widgets/refered_by.dart';
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
  String _memberId = '';
  getInformation() async {
    UserPreference userPreference = UserPreference();
    PreferenceData _userData = await userPreference.getUserInfromation();
    User _user = _userData.data;
    setState(() {
      _memberId = widget.fundraise.teams!.isNotEmpty
          ? widget.fundraise.teams!.first.member!.id!
          : '0';
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
  String _comment = 'New donation';

  bool _isAnonymous = false;

  @override
  Widget build(BuildContext context) {
    print(_isAnonymous);
    print('MemberId');
    print(_memberId);
    print("data is $_myData");
    print(_comment);
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
                    height: size.height * 0.35,
                    child: CustomCachedNetworkImage(
                      isTopBorderd: false,
                      image: widget.fundraise.image!,
                    )),
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
                                  " ${widget.fundraise.organizer!.firstName} ${widget.fundraise.organizer!.lastName} ",
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
                      if (_showDoantionInfo)
                        DonationCommentBox(commentCallback: (value) {
                          setState(() {
                            _comment = value;
                          });
                        }),
                      if (_showDoantionInfo)
                        RefferedBy(
                          teams: widget.fundraise.teams!,
                          memeberCallback: (value) {
                            setState(() {
                              _memberId = value;
                            });
                          },
                          anonymousCallback: (value) {
                            setState(() {
                              _isAnonymous = value;
                            });
                          },
                        ),
                      if (_showDoantionInfo)
                        YourDonationDetail(
                          donation: _donation,
                          tip: _tip,
                        ),
                      SizedBox(
                        height: 20.0,
                      ),
                      if (_showDoantionInfo)
                        Text(
                          'Paywith',
                          style: labelTextStyle.copyWith(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                        ),
                      SizedBox(
                        height: 20.0,
                      ),
                      if (_showDoantionInfo)
                        PaymentButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              loadingProgress(context);
                              UserPreference userPreference = UserPreference();
                              PreferenceData tokenData =
                                  await userPreference.getUserToken();
                              PreferenceData userData =
                                  await userPreference.getUserInfromation();
                              Donation donation =
                                  _memberId != '' && _memberId != "0"
                                      ? Donation(
                                          isAnonymous: _isAnonymous,
                                          amount: _donation,
                                          userID: userData.data,
                                          memberID: _memberId,
                                          tip: double.parse((_tip * _donation)
                                              .toStringAsFixed(1)),
                                          comment: _comment,
                                        )
                                      : Donation(
                                          isAnonymous: _isAnonymous,
                                          amount: _donation,
                                          userID: userData.data,
                                          tip: double.parse((_tip * _donation)
                                              .toStringAsFixed(1)),
                                          comment: _comment,
                                        );
                              await context.read<DonationModel>().payWithPayPal(
                                    donation,
                                    tokenData.data,
                                    widget.fundraise.id!,
                                  );
                              Response response =
                                  context.read<DonationModel>().response;
                              if (response.status == ResponseStatus.SUCCESS) {
                                Navigator.of(context).pop();
                                print("Url is ");
                                print(response.data);
                                String url = response.data;
                                final successDonation =
                                    await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => WebBrowser(
                                      url,
                                    ),
                                  ),
                                );
                                print('isSuccessFully donated');
                                print(successDonation);
                                if (successDonation) {
                                  loadingProgress(context);
                                  await context
                                      .read<DonationModel>()
                                      .createDonation(donation, tokenData.data,
                                          widget.fundraise.id!);
                                  Response _createResponse =
                                      context.read<DonationModel>().response;
                                  print("donation status is");
                                  print(_createResponse.status);

                                  if (_createResponse.status ==
                                      ResponseStatus.SUCCESS) {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Successfully donated $_donation\$");
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                      HomePage.routeName,
                                      (route) => false,
                                    );
                                  } else {
                                    Navigator.of(context).pop();
                                    print(_createResponse.message);
                                    authShowDialog(
                                      context,
                                      Text(response.message),
                                      close: true,
                                      error: true,
                                    );
                                    Fluttertoast.showToast(
                                        msg:
                                            "Unable to donate please try again");
                                  }
                                }
                              } else {
                                authShowDialog(context, Text(response.message));
                              }
                            }
                          },
                          title: "PayPal",
                        ),
                      if (!_showDoantionInfo)
                        ContinueButton(
                            isValidate:
                                _showDoantionInfo ? _bankInfoValidated : true,
                            onPressed: () {
                              setState(() {
                                _showDoantionInfo = true;
                              });
                            },
                            title: "Continue")
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
