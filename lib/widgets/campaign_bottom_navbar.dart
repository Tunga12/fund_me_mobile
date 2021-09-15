import 'package:crowd_funding_app/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: must_be_immutable
class CampainBottomNavBar extends StatelessWidget {
  final Function likeAction;
  final Function shareAction;
  final Function donateAction;
  final Function reportAction;
  String likeText;
  String shareCount;
  bool isLiked;

  CampainBottomNavBar({
    required this.likeAction,
    required this.shareAction,
    required this.donateAction,
    required this.reportAction,
    required this.likeText,
    required this.shareCount,
    required this.isLiked,
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
                  Icons.thumb_up_sharp,
                  size: 20.0,
                  color: isLiked ? Colors.blue : Colors.grey,
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
                  "",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
            ],
          ),
          TextButton(
            style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                backgroundColor: Theme.of(context).accentColor),
            onPressed: () {
              reportAction();
            },
            child: Text(
              LocaleKeys.report_button_text.tr(),
              style: TextStyle(color: Theme.of(context).backgroundColor),
            ),
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
                LocaleKeys.donate_now_button_text.tr(),
                style: TextStyle(color: Theme.of(context).backgroundColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
