import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:flutter/material.dart';

class TeamTile extends StatelessWidget {
  const TeamTile(
      {Key? key,
      required this.firstName,
      required this.lastName,
      required this.subTitle})
      : super(key: key);

  final String firstName;
  final String lastName;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          CircleAvatar(
            child: Text(
              "${firstName[0].toUpperCase()}${lastName[0].toUpperCase()}",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$firstName $lastName",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                '$subTitle ',
                style: labelTextStyle.copyWith(
                    color: Theme.of(context).secondaryHeaderColor),
              ),
            ],
          )
        ],
      ),
    );
  }
}
