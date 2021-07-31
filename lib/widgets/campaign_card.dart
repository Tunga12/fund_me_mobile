import 'package:crowd_funding_app/Models/donation.dart';
import 'package:crowd_funding_app/Screens/share_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jiffy/jiffy.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CampaignCard extends StatelessWidget {
  String image;
  String locaion;
  String title;
  int totalRaised;
  int goalAmount;
  Donation donation;

  CampaignCard({
    required this.image,
    required this.locaion,
    required this.title,
    required this.totalRaised,
    required this.goalAmount,
    required this.donation,
  });

  double progress = 0.0;
  var date = "";

  getData() {
    progress = totalRaised / goalAmount;
    date = Jiffy(donation.date).fromNow();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print('image is $image');
    getData();
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
                  child: CachedNetworkImage(
                    imageUrl: image,
                    errorWidget: (context, url, error) => Icon(Icons.image),
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: SpinKitCircle(
                        color: Theme.of(context).accentColor,
                        duration: Duration(
                            seconds: downloadProgress.progress == null
                                ? 2
                                : downloadProgress.progress!.toInt()),
                      ),
                    ),
                    // CircularProgressIndicator(
                    //     value: downloadProgress.progress),
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SharePage()));
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
                "Last donation $date",
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
