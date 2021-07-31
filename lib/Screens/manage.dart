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
  @override
  void initState() {
    super.initState();
    getUserFundraises();
  }

  getUserFundraises() async {
    UserPreference userPreference = UserPreference();
    PreferenceData token = await userPreference.getUserToken();
    PreferenceData user = await userPreference.getUserInfromation();

    await Provider.of<FundraiseModel>(context, listen: false)
        .getUserFundaisers(token.data, user.data.id);
  }

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<FundraiseModel>(context);
    if (value.response.status == ResponseStatus.LOADING) {
      return LoadingScreen();
    } else if (value.response.status == ResponseStatus.CONNECTIONERROR) {
      return ResponseAlert(value.response.message);
    } else if (value.response.status == ResponseStatus.FORMATERROR) {
      return ResponseAlert(value.response.message);
    } else {
      return value.homeFundraise.fundraises!.isEmpty
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
                    itemCount: value.homeFundraise.fundraises!.length,
                    itemBuilder: (context, index) {
                      return ManageCard(
                        fundraiseId: value.homeFundraise.fundraises![index].id!,
                        image:
                            "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg",
                        raisedAmount:
                            value.homeFundraise.fundraises![index].totalRaised!,
                        goalAmount:
                            value.homeFundraise.fundraises![index].goalAmount!,
                        title: value.homeFundraise.fundraises![index].title!,
                      );
                    }),
              ),
            );
    }
  }
}
