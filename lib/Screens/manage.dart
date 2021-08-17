import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Screens/create_fundraiser_home.dart';
import 'package:crowd_funding_app/Screens/loading_screen.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/services/provider/fundraise.dart';
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
  Response _response =
      Response(data: null, status: ResponseStatus.LOADING, message: '');
  List<Fundraise>? userFundraises = [];
  ScrollController _campaignScrollController = ScrollController();
  int _page = 0;
  List<Fundraise> _fundraises = [];
  @override
  void initState() {
    super.initState();
    getUserFundraises(_page);
    _campaignScrollController.addListener(() async {
      if (_campaignScrollController.position.pixels ==
          _campaignScrollController.position.maxScrollExtent) {
        getUserFundraises(++_page);
      }
    });
  }

  getUserFundraises(int page) async {
    UserPreference userPreference = UserPreference();
    PreferenceData token = await userPreference.getUserToken();
    await Provider.of<FundraiseModel>(context, listen: false)
        .getUserFundaisers(token.data, page);
    List<Fundraise> userFundraisesResponse =
        Provider.of<FundraiseModel>(context, listen: false)
            .homeFundraise
            .fundraises!;
    await Provider.of<FundraiseModel>(context, listen: false)
        .getMemberFundrases(token.data, _page);
    List<Fundraise> memberFundraisesResponse =
        Provider.of<FundraiseModel>(context, listen: false)
            .homeFundraise
            .fundraises!;
    setState(() {
      _response = context.read<FundraiseModel>().response;
      userFundraisesResponse.addAll(memberFundraisesResponse);
      userFundraises!.addAll(userFundraisesResponse);
    });
  }

  @override
  Widget build(BuildContext context) {
    print("user response fundraises $userFundraises");
    if (_response.status == ResponseStatus.LOADING) {
      return LoadingScreen();
    } else if (_response.status == ResponseStatus.CONNECTIONERROR) {
      return ResponseAlert(
        _response.message,
        status: ResponseStatus.CONNECTIONERROR,
        retry: () => getUserFundraises(0),
      );
    } else if (_response.status == ResponseStatus.MISMATCHERROR) {
      return ResponseAlert(
        _response.message,
        retry: () => getUserFundraises(0),
        status: ResponseStatus.MISMATCHERROR,
      );
    } else {
      List<Fundraise>? fundraises = userFundraises;
      if (fundraises == null) {
        return Container();
      }
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
              },
            )
          : Container(
              child: Scrollbar(
                controller: _campaignScrollController,
                isAlwaysShown: true,
                child: ListView.builder(
                    controller: _campaignScrollController,
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
