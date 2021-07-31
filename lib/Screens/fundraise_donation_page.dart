import 'package:crowd_funding_app/Models/donation.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class FundraiseDonationPage extends StatelessWidget {
  List<Donation> donations;
  FundraiseDonationPage({Key? key, required this.donations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Donations',
          style: appbarTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(
              20.0,
            ),
            child: donations.length > 0
                ? Column(
                    children: donations
                        .map((donation) => FundraiseDonation(
                              donation: donation,
                            ))
                        .toList(),
                  )
                : Center(
                    child: Text(
                      "No donations 1et!",
                      style: bodyTextStyle.copyWith(
                          color: Theme.of(context).secondaryHeaderColor),
                    ),
                  )),
      ),
    );
  }
}

class FundraiseDonation extends StatelessWidget {
  FundraiseDonation({Key? key, required this.donation}) : super(key: key);

  Donation donation;

  String avatarText = '';
  String fullName = '';
  int donateAmount = 0;
  var dateTime;

  getData() {
    avatarText = donation.userID!.firstName![0].toUpperCase() +
        donation.userID!.lastName![0].toUpperCase();
    fullName = donation.userID!.firstName! + " " + donation.userID!.lastName!;
    donateAmount = donation.amount!;
    dateTime = Jiffy(donation.date, "yyyy-MM-dd").fromNow();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    print("Donatins ${donation.userID}");
    return Container(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor:
                    Theme.of(context).secondaryHeaderColor.withOpacity(0.5),
                child: Text(
                  "$avatarText",
                  style: bodyTextStyle.copyWith(
                      color: Theme.of(context).backgroundColor),
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "$fullName",
                        style: bodyTextStyle.copyWith(
                            fontSize: 18.0,
                            color: Theme.of(context).secondaryHeaderColor),
                      ),
                      Text(
                        " donates \$$donateAmount",
                        style: bodyTextStyle.copyWith(
                            fontWeight: FontWeight.w300,
                            color: Theme.of(context).secondaryHeaderColor),
                      )
                    ],
                  ),
                  Text(
                    "$dateTime",
                    style: bodyTextStyle.copyWith(
                        fontWeight: FontWeight.w300,
                        color: Theme.of(context).secondaryHeaderColor),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.thumb_up_off_alt),
                      ),
                      SizedBox(
                        width: 40.0,
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.ios_share))
                    ],
                  )
                ],
              ),
            ],
          ),
          Divider(
            color: Theme.of(context).secondaryHeaderColor.withOpacity(0.6),
          )
        ],
      ),
    );
  }
}
