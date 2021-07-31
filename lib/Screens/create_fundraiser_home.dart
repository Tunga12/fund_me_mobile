import 'package:crowd_funding_app/Screens/create_fundraiser_page_one.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:crowd_funding_app/widgets/create_fundraiser_card.dart';
import 'package:flutter/material.dart';

class CreateFundraiserHome extends StatelessWidget {
  const CreateFundraiserHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create fundraiser",
          style: appbarTextStyle,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Who are you fundraising for?",
              style: bodyHeaderTextStyle.copyWith(
                color: Theme.of(context).secondaryHeaderColor.withAlpha(250),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            CreateFundraiserCard(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CreateFundraiserPageOne(),
                  ),
                );
              },
              iconData: Icons.manage_accounts,
              title: "Yourself or someone else",
              subTitle:
                  'Donations will be deposited into a person or business bank account.',
            ),
            SizedBox(
              height: 10.0,
            ),
            CreateFundraiserCard(
              onPressed: () {},
              iconData: Icons.room_preferences_outlined,
              title: "A nonprofit or charity",
              subTitle:
                  'Donations will be automatically deliverd to your chosen nonprofit.',
            ),
          ],
        ),
      ),
    );
  }
}
