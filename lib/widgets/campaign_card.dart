import 'package:crowd_funding_app/Models/custom_time.dart';
import 'package:crowd_funding_app/Models/donation.dart';
import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Screens/share_page.dart';
import 'package:crowd_funding_app/widgets/custom_cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CampaignCard extends StatelessWidget {
  String image;
  String locaion;
  String title;
  int totalRaised;
  int goalAmount;
  Donation donation;
  String fundraiseId;

  CampaignCard({
    required this.image,
    required this.locaion,
    required this.title,
    required this.totalRaised,
    required this.goalAmount,
    required this.donation,
    required this.fundraiseId,
  });

  double progress = 0.0;
  var date = "";

  getData() {
    progress = totalRaised / goalAmount;
    date = donation.date == null ? "NON": CustomTime.displayTimeAgoFromTimestamp(donation.date!,
        numericDates: true);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    getData();
    print("donation date is ");
    print(donation.date);
    print('date is');
    return Container(
      color: Theme.of(context).backgroundColor,
      height: MediaQuery.of(context).size.height * 0.6,
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.only(bottom: 0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: size.width,
                  child: CustomCachedNetworkImage(
                    image: image,
                    isTopBorderd: true,
                  ),
                ),
                Positioned(
                  top: 10.0,
                  right: 10.0,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: Icon(
                        Icons.ios_share,
                        size: 20.0,
                        color: Theme.of(context)
                            .secondaryHeaderColor
                            .withOpacity(0.6),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SharePage(
                              fundraise: Fundraise(
                                id: fundraiseId,
                                title: title,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(
                top: 10.0,
              ),
              child: Text(
                "$locaion",
                style: TextStyle(
                  color:
                      Theme.of(context).secondaryHeaderColor.withOpacity(0.4),
                ),
              )),
          Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Text(
                "$title",
                style: TextStyle(
                    color:
                        Theme.of(context).secondaryHeaderColor.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              )),
          Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Text(
                "$totalRaised raised of $goalAmount",
                style: TextStyle(
                    color:
                        Theme.of(context).secondaryHeaderColor.withOpacity(0.6),
                    fontSize: 16.0),
              )),
          Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Text(
               date == "NON" ? "No donations yet":  "Last donation $date",
                style: TextStyle(
                    fontSize: 16.0,
                    color: Theme.of(context)
                        .secondaryHeaderColor
                        .withOpacity(0.4)),
              )),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: LinearProgressIndicator(
              backgroundColor: Theme.of(context).accentColor.withOpacity(0.3),
              value: progress,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
        ],
      ),
    );
  }
}
