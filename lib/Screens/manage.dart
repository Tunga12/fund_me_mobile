import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Screens/create_fundraiser_home.dart';
import 'package:crowd_funding_app/Screens/loading_screen.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/services/provider/fundraise.dart';
import 'package:crowd_funding_app/services/provider/notification.dart';
import 'package:crowd_funding_app/widgets/empty_body.dart';
import 'package:crowd_funding_app/widgets/manage_card.dart';
import 'package:crowd_funding_app/widgets/response_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Manage extends StatefulWidget {
  const Manage({Key? key}) : super(key: key);

  @override
  _ManageState createState() => _ManageState();
}

class _ManageState extends State<Manage> {
  List<Fundraise>? userFundraises;
  @override
  void initState() {
    super.initState();
    getUserFundraises();
  }

  getUserFundraises() async {
    UserPreference userPreference = UserPreference();
    PreferenceData token = await userPreference.getUserToken();
    await Provider.of<FundraiseModel>(context, listen: false)
        .getUserFundaisers(token.data);
    List<Fundraise> userFundraisesResponse =
        Provider.of<FundraiseModel>(context, listen: false)
            .homeFundraise
            .fundraises!;
    await Provider.of<FundraiseModel>(context, listen: false)
        .getMemberFundrases(token.data);
    List<Fundraise> memberFundraisesResponse =
        Provider.of<FundraiseModel>(context, listen: false)
            .homeFundraise
            .fundraises!;
    setState(() {
      userFundraisesResponse.addAll(memberFundraisesResponse);
      userFundraises = userFundraisesResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("user response fundraises $userFundraises");
    final value = Provider.of<FundraiseModel>(context);
    if (value.response.status == ResponseStatus.LOADING) {
      return LoadingScreen();
    } else if (value.response.status == ResponseStatus.CONNECTIONERROR) {
      return ResponseAlert(
        value.response.message,
        status: ResponseStatus.CONNECTIONERROR,
        retry: () => getUserFundraises(),
      );
    } else if (value.response.status == ResponseStatus.FORMATERROR) {
      return ResponseAlert(value.response.message);
    } else {
      List<Fundraise> fundraises = userFundraises ?? [];
      return fundraises.isEmpty
          ? EmptyBody(
              text1: "Ready to fundraise?",
              text2:
                  'You can always start a GoFundMe for yourself, a charity, or others in need.',
              btnText1: "Start a GoFundMe",
              isFilled: true,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateFundraiserHome(),
                  ),
                );
              })
          : Container(
              color: Colors.grey,
              child: Scrollbar(
                child: ListView.builder(
                    itemCount: fundraises.length,
                    itemBuilder: (context, index) {
                      return ManageCard(
                        fundraiseId: fundraises[index].id!,
                        image: fundraises[index].image!,
                        raisedAmount: fundraises[index].totalRaised!,
                        goalAmount: fundraises[index].goalAmount!,
                        title: fundraises[index].title!,
                      );
                    }),
              ),
            );
    }
  }
}
