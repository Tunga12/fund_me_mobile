import 'package:cached_network_image/cached_network_image.dart';
import 'package:crowd_funding_app/Screens/fundraiser_details.dart';
import 'package:crowd_funding_app/Screens/share_page.dart';
import 'package:crowd_funding_app/widgets/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ManageCard extends StatelessWidget {
  String image;
  String title;
  int goalAmount;
  int raisedAmount;
  String fundraiseId;
  ManageCard(
      {required this.fundraiseId,
      required this.image,
      required this.title,
      required this.goalAmount,
      required this.raisedAmount});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        print("I am tapped");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FundraiserDetail(fundraiseId),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            color: Theme.of(context).backgroundColor,
            height: size.height * 0.55,
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.only(bottom: 0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: size.height * 0.33,
                  child: Stack(
                    children: [
                      Container(
                          child: CustomCachedNetworkImage(
                        isTopBorderd: true,
                        image: image,
                      )),
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
                                    fundraise: fundraiseId,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 10.0,
                          left: 10.0,
                          child: SizedBox(
                            height: 30.0,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).backgroundColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              child: Text("Published"),
                              onPressed: () {},
                            ),
                          ))
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "$title",
                      style: TextStyle(
                          color: Theme.of(context)
                              .secondaryHeaderColor
                              .withOpacity(0.8),
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    )),
                Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "\$$raisedAmount raised of \$$goalAmount",
                      style: TextStyle(
                          color: Theme.of(context)
                              .secondaryHeaderColor
                              .withOpacity(0.6),
                          fontSize: 16.0),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: LinearProgressIndicator(
                    value: goalAmount == 0
                        ? 0.0
                        : double.parse(
                            (raisedAmount / goalAmount).toStringAsFixed(2)),
                    backgroundColor:
                        Theme.of(context).accentColor.withOpacity(0.2),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 0.5,
            color: Theme.of(context).secondaryHeaderColor,
          )
        ],
      ),
    );
  }
}
