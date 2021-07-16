import 'package:crowd_funding_app/Screens/edit_page.dart';
import 'package:crowd_funding_app/Screens/share_page.dart';
import 'package:crowd_funding_app/Screens/team.dart';
import 'package:crowd_funding_app/Screens/update_page.dart';
import 'package:crowd_funding_app/Screens/withdraw_page.dart';
import 'package:crowd_funding_app/widgets/custom_raised_button.dart';
import 'package:crowd_funding_app/constants/colors.dart';
import 'package:flutter/material.dart';

const titleTextStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 30.0,
);

class FundraiserDetail extends StatefulWidget {
  @override
  _FundraiserDetailState createState() => _FundraiserDetailState();
}

class _FundraiserDetailState extends State<FundraiserDetail> {
  int index = 0;

  bottomNavBarItemTap(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WithdrawPage(),
          ),
        );
        return;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditPage(),
          ),
        );
        return;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SharePage(),
          ),
        );
        return;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UpdatePage(),
          ),
        );
        return;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Team(),
          ),
        );
        return;
    }
  }

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
                        color: Colors.black.withOpacity(0.7),
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
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          " of \$100",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    LinearProgressIndicator(
                      value: 0.1,
                      backgroundColor: Colors.green[100],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      width: size.width,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(
                                width: 1.5,
                                color: Theme.of(context).accentColor),
                          ),
                        ),
                        onPressed: () {},
                        child: Text("Donate now"),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomRaisedButton(
                          title: "Travel & Adventure",
                          iconData: Icons.wallet_travel,
                          onPressed: () {},
                        ),
                        CustomRaisedButton(
                          title: "Ney York, NY",
                          iconData: Icons.wallet_travel,
                          onPressed: () {},
                        ),
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
              FundraiserDetailElements(
                title: "Update (0)",
                body:
                    "Keep your donor's up-to-date with what's going on with your fundraiser.",
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
                      "Team (1)",
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
                        CircleAvatar(
                          child: Text(
                            "FK",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          radius: 20.0,
                          backgroundColor: Colors.grey[300],
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Row(
                          children: [
                            Text(
                              "You",
                              style: titleTextStyle.copyWith(fontSize: 20.0),
                            ),
                            Text(
                              ' are fundraising as  a team',
                              style: Theme.of(context).textTheme.bodyText1,
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              FundraiserDetailElements(
                title: "Donations (0)",
                body:
                    "Share your compaign with your friends and family to start getting activity.",
              ),
              SizedBox(
                height: 10.0,
              ),
              FundraiserDetailElements(
                  title: "Comments",
                  body:
                      "Share your compaigns with those closest to you to get more comments.")
            ]),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: bottomNavBarItemTap,
        elevation: 5.0,
        selectedItemColor: Theme.of(context).secondaryHeaderColor,
        showUnselectedLabels: true,
        unselectedItemColor: Theme.of(context).secondaryHeaderColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: "withdraw",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: "Edit",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ios_share),
            label: "Share",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: "Update",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_outlined),
            label: "Team",
          ),
        ],
      ),
    );
  }
}

class FundraiserDetailElements extends StatelessWidget {
  String title;
  String body;

  FundraiserDetailElements({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Text("$title", style: titleTextStyle),
          SizedBox(
            height: 20.0,
          ),
          Text(
            '$body',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(height: 1.8),
          )
        ],
      ),
    );
  }
}
