import 'package:crowd_funding_app/Screens/edit_page.dart';
import 'package:crowd_funding_app/Screens/share_page.dart';
import 'package:crowd_funding_app/Screens/team.dart';
import 'package:crowd_funding_app/Screens/update_page.dart';
import 'package:crowd_funding_app/Screens/withdraw_page.dart';
import 'package:crowd_funding_app/widgets/custom_raised_button.dart';
import 'package:crowd_funding_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const titleTextStyle = TextStyle(fontSize: 25.0, color: Colors.black);

class CampaignDetail extends StatefulWidget {
  @override
  _CampaignDetailState createState() => _CampaignDetailState();
}

class _CampaignDetailState extends State<CampaignDetail> {
  int index = 0;

  ScrollController _scrollController = ScrollController();
  Color _theme = Colors.white;
  bool _visible = false;

  @override
  void initState() {
    _scrollController.addListener(
      () => _getIsAppbarCollapsed
          ? {
              _theme != Colors.white
                  ? setState(
                      () {
                        _visible = false;
                        _theme = Colors.white;
                        // print('setState is called');
                      },
                    )
                  : {},
            }
          : _theme != Colors.black
              ? setState(() {
                  // print('setState is called');
                  _visible = true;
                  _theme = Colors.black;
                })
              : {},
    );
    super.initState();
  }

  bool get _getIsAppbarCollapsed {
    return _scrollController.hasClients &&
        _scrollController.offset < (200 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: _theme,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            pinned: true,
            floating: true,
            expandedHeight: size.height * 0.35,
            flexibleSpace: FlexibleSpaceBar(
                title: _visible
                    ? Text(
                        'Help Dave fishish his journey',
                        style: TextStyle(color: Colors.black),
                      )
                    : Container(),
                centerTitle: true,
                background: Stack(
                  children: [
                    Container(
                      child: Image.asset(
                        'assets/images/image1.png',
                        fit: BoxFit.cover,
                        width: size.width,
                      ),
                    ),
                    Positioned(
                      bottom: 30.0,
                      right: 10.0,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 7.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.black.withOpacity(0.5)),
                        child: Row(
                          children: [
                            Icon(Icons.image, color: Colors.white),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              '1',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 1.0,
                        blurRadius: 1.0,
                        offset: Offset(0, 3))
                  ],
                ),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Help Dave fishish his journey',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.9),
                        fontSize: 25.0,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Text(
                          "0\$ raised",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                        Text(
                          " of \$100 goal",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    LinearProgressIndicator(
                      value: 0.1,
                      backgroundColor: Colors.green[100],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          child: Text("DV"),
                          radius: 30.0,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Dawit Alex",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                            ),
                            Text(
                              "Neptun Beach,FL",
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, ",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              CustomCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleRow(
                      leadingTitle: "Updates",
                      trailingTitle: "1",
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Last updated 2d ago",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: Text(
                        "THANK YOU ALL.! THIS IS REAL AND FEEL THE LOVE",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              CustomCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleRow(
                      leadingTitle: "Donations",
                      trailingTitle: "4.7k",
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Last updated 2d ago",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        CustomCircleAvatar("WB"),
                        SizedBox(
                          width: 10.0,
                        ),
                        CustomCircleAvatar("WB"),
                        SizedBox(
                          width: 10.0,
                        ),
                        CustomCircleAvatar("WB"),
                        SizedBox(
                          width: 10.0,
                        ),
                        CustomCircleAvatar("WB"),
                        SizedBox(
                          width: 10.0,
                        ),
                        CustomCircleAvatar("WB"),
                        SizedBox(
                          width: 10.0,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 1.0,
                        blurRadius: 1.0,
                        offset: Offset(0, 3))
                  ],
                ),
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Team ",
                      style: titleTextStyle,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          child: Icon(
                            Icons.group_outlined,
                            color: Colors.grey,
                          ),
                          radius: 40.0,
                          backgroundColor: Colors.grey[300],
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          "Fundraising Team",
                          style: titleTextStyle.copyWith(fontSize: 25.0),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        CustomCircleAvatar("UL"),
                        SizedBox(
                          width: 10.0,
                        ),
                        CustomCircleAvatar("UL"),
                        SizedBox(
                          width: 10.0,
                        ),
                        CustomCircleAvatar("UL"),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                height: 10.0,
              ),
            ]),
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(0.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.thumbsUp,
                    size: 20.0,
                    color: Colors.grey,
                  ),
                  label: Text(
                    "4.7k",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.ios_share,
                    size: 20.0,
                    color: Colors.grey,
                  ),
                  label: Text(
                    "26k",
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
                onPressed: () {},
                child: Text(
                  "Donate now",
                  style: TextStyle(color: Theme.of(context).backgroundColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomCircleAvatar extends StatelessWidget {
  String title;
  CustomCircleAvatar(this.title);
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).secondaryHeaderColor.withOpacity(0.8),
      child: Text(
        "WB",
        style: TextStyle(
          color: Theme.of(context).backgroundColor,
        ),
      ),
    );
  }
}

class TitleRow extends StatelessWidget {
  String leadingTitle;
  String trailingTitle;
  TitleRow({required this.leadingTitle, required this.trailingTitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$leadingTitle",
          style: titleTextStyle,
        ),
        Container(
          padding: EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            "$trailingTitle",
            style: TextStyle(
              color: Colors.grey.shade700,
            ),
          ),
        )
      ],
    );
  }
}
