import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Screens/fundraiser_details.dart';
import 'package:crowd_funding_app/Screens/share_page.dart';
import 'package:crowd_funding_app/translations/locale_keys.g.dart';
import 'package:crowd_funding_app/widgets/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: must_be_immutable
class ManageCard extends StatelessWidget {
  String image;
  String title;
  int goalAmount;
  double raisedAmount;
  String fundraiseId;
  ManageCard(
      {required this.fundraiseId,
      required this.image,
      required this.title,
      required this.goalAmount,
      required this.raisedAmount,
      Key? key})
      : super(key: key);

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
                                    fundraise: Fundraise(
                                        title: title, id: fundraiseId),
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
                      "${raisedAmount.toStringAsFixed(0)} ${LocaleKeys.usd_label_text.tr()} ${LocaleKeys.raised_lable_text.tr()} ${LocaleKeys.of_label_text.tr()} $goalAmount ${LocaleKeys.usd_label_text.tr()}",
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
