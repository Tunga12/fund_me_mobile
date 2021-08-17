import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/Screens/fundraiser_details.dart';
import 'package:crowd_funding_app/Screens/share_page.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:crowd_funding_app/widgets/continue_button.dart';
import 'package:crowd_funding_app/widgets/preview_text_button.dart';
import 'package:crowd_funding_app/widgets/unorderd_list.dart';
import 'package:flutter/material.dart';

class FundraiserPreview extends StatelessWidget {
  final Map<String, dynamic> info;

  FundraiserPreview({required this.info});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        title: Text("Fundraiser preview"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            width: size.width,
            height: 60.0,
            color: Colors.teal[100],
            child: Text(
              'This is a preview. Complete your fundraiser to start collecting donations. you can always edit later. ',
              style: labelTextStyle.copyWith(
                  color:
                      Theme.of(context).secondaryHeaderColor.withOpacity(0.6)),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                width: size.width,
                height: size.height * 0.3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(info['image']), fit: BoxFit.fill)),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${info['title']}',
                      style: titleTextStyle.copyWith(fontSize: 24.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    LinearProgressIndicator(
                      value: 0.3,
                      backgroundColor:
                          Theme.of(context).accentColor.withOpacity(0.3),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Text(
                          '\$${info['goalAmount']}',
                          style: titleTextStyle.copyWith(fontSize: 24.0),
                        ),
                        Text(
                          'goal',
                          style: stepTextStyle.copyWith(
                              color: Theme.of(context)
                                  .secondaryHeaderColor
                                  .withOpacity(0.7)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    PreviewTextButton(
                      title: "Share",
                      backgroundColor:
                          Theme.of(context).buttonColor.withAlpha(100),
                      onPressed: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) =>
                        //         SharePage(fundraise: '123456789')));
                      },
                      leadingChild: Container(
                          padding: EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.0),
                              color: Theme.of(context).secondaryHeaderColor),
                          child: Icon(
                            Icons.ios_share,
                            color: Theme.of(context).backgroundColor,
                          )),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    PreviewTextButton(
                      title: "Donate now",
                      onPressed: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) =>
                        //         SharePage(fundraise: '123456789')));
                      },
                      leadingChild: Container(
                        padding: EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.0),
                            color: Theme.of(context).secondaryHeaderColor),
                        child: Image.asset(
                          'assets/images/favicon.png',
                          width: 27.0,
                        ),
                      ),
                      backgroundColor:
                          Theme.of(context).buttonColor.withAlpha(180),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                      leading: CircleAvatar(
                          child: Icon(
                        Icons.person,
                        color: Theme.of(context).accentColor,
                      )),
                      title: Text(
                          '${info['user'].firstName} ${info['user'].lastName} is organizing this fundraising'),
                    ),
                    Divider(
                      thickness: 1.5,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Text(
                          "Just now",
                          style: bodyTextStyle.copyWith(
                            color: Theme.of(context)
                                .secondaryHeaderColor
                                .withOpacity(0.6),
                          ),
                        ),
                        Divider(
                          height: 20.0,
                          thickness: 2.5,
                        ),
                        SizedBox(
                          width: 50.0,
                          child: Icon(
                            Icons.category,
                            color: Theme.of(context)
                                .secondaryHeaderColor
                                .withOpacity(0.6),
                          ),
                        ),
                        Text(
                          "${info['category']}",
                          style: bodyTextStyle2.copyWith(
                            color: Theme.of(context)
                                .secondaryHeaderColor
                                .withOpacity(0.6),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Divider(thickness: 1.5),
                    SizedBox(
                      height: 50.0,
                    ),
                    Center(
                      child: UnorderedList(
                        text: '${info['story']}',
                      ),
                    ),
                    SizedBox(
                      height: 70.0,
                    ),
                    Divider(
                      thickness: 1.5,
                    ),
                    ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                      minVerticalPadding: 0.0,
                      leading: CircleAvatar(
                        radius: 40.0,
                        backgroundColor:
                            Theme.of(context).accentColor.withAlpha(150),
                        child: Icon(
                          Icons.favorite_outline_rounded,
                          color: Theme.of(context).backgroundColor,
                        ),
                      ),
                      title: Text(
                        "Be the first to help",
                        style: titleTextStyle,
                      ),
                      subtitle: Text(
                        "Your early support will go a long way and help inspire others to donate. ",
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      width: size.width,
                      height: 50.0,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).buttonColor.withAlpha(200),
                        ),
                        child: Text(
                          "Donate now ",
                          style: bodyTextStyle.copyWith(
                            color: Theme.of(context)
                                .secondaryHeaderColor
                                .withOpacity(0.8),
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text("Donations", style: titleTextStyle),
                  ],
                ),
              ),
              Container(
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                      thickness: 1.5,
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        child: Icon(
                          Icons.person_search_sharp,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      title: Text('Become the first supporter'),
                      subtitle: Text("Your donation matters"),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Organizer",
                        style: titleTextStyle,
                      ),
                    ),
                    Divider(
                      thickness: 1.5,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        child: Icon(
                          Icons.person_search_sharp,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      title: Text(
                        '${info['user'].firstName} ${info['user'].lastName}',
                        style: labelTextStyle,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Organizer",
                            style: labelTextStyle,
                          ),
                          Text(
                            "Addis Ababa, 6 killo",
                            style: labelTextStyle,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                              side: BorderSide(
                                  width: 1.5,
                                  color: Theme.of(context).accentColor),
                            )),
                            onPressed: () {},
                            child: Text("Connect"),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50.0,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ContinueButton(
            isValidate: true,
            onPressed: () {},
            title: "Complete fundraiser",
          ),
        ),
      ),
    );
  }
}
