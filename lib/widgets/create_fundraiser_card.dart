import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:flutter/material.dart';

class CreateFundraiserCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData iconData;
  final Function onPressed;

  CreateFundraiserCard(
      {required this.title,
      required this.subTitle,
      required this.iconData,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Card(
        elevation: 4.0,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 20.0,
          ),
          child: ListTile(
            leading: Icon(
              iconData,
              color: Theme.of(context).accentColor,
              size: 40.0,
            ),
            title: Text(
              "$title",
              style: cardTitleTextStyle,
            ),
            subtitle: Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Text(
                "$subTitle",
                style: cardSubtitleTextStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
