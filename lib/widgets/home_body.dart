import 'package:crowd_funding_app/Models/campaign.dart';
import 'package:crowd_funding_app/Models/donation.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Screens/loading_screen.dart';
import 'package:crowd_funding_app/Screens/popular_fundraise_detail.dart';
import 'package:crowd_funding_app/Screens/create_fundraiser_home.dart';
import 'package:crowd_funding_app/services/provider/fundraise.dart';
import 'package:crowd_funding_app/widgets/campaign_card.dart';
import 'package:crowd_funding_app/widgets/community_card.dart';
import 'package:crowd_funding_app/widgets/fundraiser_card.dart';
import 'package:crowd_funding_app/widgets/response_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  int counter = 0;
  List<Campaign> _campaigns = [];
  ScrollController _campaignScrollController = ScrollController();
  ScrollController campaignScrollController = ScrollController();

  @override
  void initState() {
    getPopularFundraises();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getPopularFundraises() async {
    await Future.delayed(
      Duration(milliseconds: 1),
      () => context.read<FundraiseModel>().getPopularFundraises(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // fetchFundraise();
    final value = Provider.of<FundraiseModel>(context);

    if (value.response.status == ResponseStatus.LOADING) {
      return LoadingScreen();
    } else if (value.response.status == ResponseStatus.CONNECTIONERROR) {
      return ResponseAlert(
        value.response.message,
        status: ResponseStatus.CONNECTIONERROR,
        retry: () => getPopularFundraises(),
      );
    } else if (value.response.status == ResponseStatus.FORMATERROR) {
      return ResponseAlert(value.response.message);
    } else {
      final _fundraises = value.homeFundraise.fundraises;
      return Scrollbar(
        controller: _campaignScrollController,
        isAlwaysShown: true,
        child: ListView(
          controller: _campaignScrollController,
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Fundraise for the people and causes you care about.",
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).secondaryHeaderColor)),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          elevation: 2.0,
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 50.0),
                          backgroundColor: Theme.of(context).indicatorColor),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CreateFundraiserHome(),
                          ),
                        );
                      },
                      child: Text(
                        "Start a GoFundMe",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).backgroundColor),
                      )),
                  SizedBox(
                    height: 50.0,
                  ),
                  CommunityCard(),
                  SizedBox(
                    height: 45.0,
                  ),
                  Text(
                    "Nearby Fundraisers",
                    style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  FundraiserCard(),
                  SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    'Popular now',
                    style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.grey,
              child: ListView.builder(
                  primary: true,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: _fundraises!.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        String id = _fundraises[index].id!;
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CampaignDetail(
                              id: id,
                            ),
                          ),
                        );
                      },
                      child: CampaignCard(
                        image: _fundraises[index].image!,
                        donation: _fundraises[index].donations!.length > 0
                            ? _fundraises[index].donations![0]
                            : Donation(),
                        goalAmount: _fundraises[index].goalAmount!,
                        locaion: 'location',
                        title: _fundraises[index].title as String,
                        totalRaised: _fundraises[index].totalRaised!,
                      ),
                    );
                  }),
            ),
          ],
        ),
      );
    }
  }
}
