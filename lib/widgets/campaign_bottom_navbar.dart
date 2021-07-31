import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CampainBottomNavBar extends StatelessWidget {
  final Function likeAction;
  final Function shareAction;
  final Function donateAction;
  String likeText;
  String shareCount;

  CampainBottomNavBar({
    required this.likeAction,
    required this.shareAction,
    required this.donateAction,
    required this.likeText,
    required this.shareCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              TextButton.icon(
                onPressed: () {
                  likeAction();
                },
                icon: Icon(
                  FontAwesomeIcons.thumbsUp,
                  size: 20.0,
                  color: Colors.grey,
                ),
                label: Text(
                  "$likeText",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  shareAction();
                },
                icon: Icon(
                  Icons.ios_share,
                  size: 20.0,
                  color: Colors.grey,
                ),
                label: Text(
                  "$shareCount",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(right: 20.0),
            child: TextButton(
              style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  backgroundColor: Theme.of(context).accentColor),
              onPressed: () {
                donateAction();
              },
              child: Text(
                "Donate now",
                style: TextStyle(color: Theme.of(context).backgroundColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
