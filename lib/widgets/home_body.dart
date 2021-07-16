import 'package:crowd_funding_app/Models/campaign.dart';
import 'package:crowd_funding_app/Screens/campaign_detail.dart';
import 'package:crowd_funding_app/constants/demmy_data.dart';
import 'package:crowd_funding_app/widgets/campaign_card.dart';
import 'package:crowd_funding_app/widgets/community_card.dart';
import 'package:crowd_funding_app/widgets/fundraiser_card.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatefulWidget {
  HomeBody({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

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
    super.initState();

    fetchMore();
    _campaignScrollController.addListener(() {
      print("pixels ${_campaignScrollController.position.pixels}");
      print("Extent ${_campaignScrollController.position.maxScrollExtent}");
      if (_campaignScrollController.position.pixels ==
          _campaignScrollController.position.maxScrollExtent) {
        print("fetch more");
        fetchMore();
      }
    });
  }

  @override
  void dispose() {
    _campaignScrollController.dispose();
    campaignScrollController.dispose();
    super.dispose();
  }

  void fetchCampaign(int index) {
    setState(() {
      _campaigns.add(campaigns[index]);
    });
  }

  fetchMore() {
    for (int i = counter; i <= counter + 10; i++) {
      fetchCampaign(i);
    }
    print(campaigns.length);

    setState(() {
      counter += 10;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    onPressed: () {},
                    child: Text(
                      "Start a GoFundMe",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).backgroundColor),
                    )),
                SizedBox(
                  height: 50.0,
                ),
                CommunityCard(size: widget.size),
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
                FundraiserCard(size: widget.size),
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
                itemCount: _campaigns.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CampaignDetail(),
                        ),
                      );
                    },
                    child: CampaignCard(
                      image: _campaigns[index].image,
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
