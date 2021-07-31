import 'package:cached_network_image/cached_network_image.dart';
import 'package:crowd_funding_app/Models/category.dart';
import 'package:crowd_funding_app/Models/donation.dart';
import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Models/methods.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Models/team_member.dart';
import 'package:crowd_funding_app/Models/update.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/Screens/comments.dart';
import 'package:crowd_funding_app/Screens/donation_page.dart';
import 'package:crowd_funding_app/Screens/edit_page.dart';
import 'package:crowd_funding_app/Screens/fundraise_donation_page.dart';
import 'package:crowd_funding_app/Screens/loading_screen.dart';
import 'package:crowd_funding_app/Screens/share_page.dart';
import 'package:crowd_funding_app/Screens/team.dart';
import 'package:crowd_funding_app/Screens/update_page.dart';
import 'package:crowd_funding_app/Screens/withdraw_page.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/services/provider/fundraise.dart';
import 'package:crowd_funding_app/widgets/cached_network_image.dart';
import 'package:crowd_funding_app/widgets/custom_raised_button.dart';
import 'package:crowd_funding_app/widgets/fundraiser_detail_element.dart';
import 'package:crowd_funding_app/widgets/response_alert.dart';
import 'package:crowd_funding_app/widgets/update_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

const titleTextStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 30.0,
);

class FundraiserDetail extends StatefulWidget {
  final String fundraiseId;
  FundraiserDetail(this.fundraiseId);
  @override
  _FundraiserDetailState createState() => _FundraiserDetailState();
}

class _FundraiserDetailState extends State<FundraiserDetail> {
  int index = 0;
  User? user;

  getSingleFundraise() async {
    UserPreference userPreference = UserPreference();
    PreferenceData data = await userPreference.getUserInfromation();
    user = data.data;
    await Future.delayed(
      Duration(milliseconds: 1),
      () =>
          context.read<FundraiseModel>().getSingleFundraise(widget.fundraiseId),
    );
  }

  bottomNavBarItemTap(int index, Fundraise fundraise) {
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
            builder: (context) => EditPage(fundraise),
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
            builder: (context) => UpdatePage(fundraise.id!),
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
    getSingleFundraise();
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
    final model = context.watch<FundraiseModel>();
    if (model.response.status == ResponseStatus.LOADING) {
      return LoadingScreen();
    } else if (model.response.status == ResponseStatus.CONNECTIONERROR) {
      return ResponseAlert(model.response.message);
    } else if (model.response.status == ResponseStatus.FORMATERROR) {
      return ResponseAlert(model.response.message);
    }
    Fundraise _fundraise = model.fundraise;
    var days = Jiffy(_fundraise.dateCreated, "yyyy-MM-dd").fromNow();
    String totalShareCount = Counter.getCounter(_fundraise.totalSharedCount!);
    String totalLikeCount = Counter.getCounter(_fundraise.likeCount!);
    Location? location = _fundraise.location;
    List<Update> updates = _fundraise.updates!;
    List<TeamMember> teams = _fundraise.teams!;
    List<Donation> donations = _fundraise.donations!;
    Category category = _fundraise.category!;
    double process = 0.0;
    String title = _fundraise.title!;
    String image = _fundraise.image!;
    User? organizer = _fundraise.organizer;
    User? beneficiary = _fundraise.beneficiary;
    int totalRaised = _fundraise.totalRaised!;
    int goalAmount = _fundraise.goalAmount!;
    String story = _fundraise.story!;
    String lastUpdate = updates.isNotEmpty
        ? Jiffy(_fundraise.updates![0].dateCreated, "yyyy-MM-dd").fromNow()
        : "Just Now";
    String lastDonation = donations.isNotEmpty
        ? Jiffy(_fundraise.donations![0].date, "yyyy-MM-dd").fromNow()
        : "Just Now";
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
                      '$title',
                      style: TextStyle(color: Colors.black),
                    )
                  : Container(),
              centerTitle: true,
              background: Stack(
                children: [
                  Container(
                    child: Container(
                      width: size.width,
                      child: CachedImage(
                        image:
                            'https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg',
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 30.0,
                    right: 10.0,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 7.0),
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
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
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
                      '$title',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 25.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Text(
                          "$totalRaised\$ raised",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          " of \$$goalAmount",
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
                          title: "${category.categoryName}",
                          iconData: Icons.wallet_travel,
                          onPressed: () {},
                        ),
                        CustomRaisedButton(
                          title: "${location!.latitude}",
                          iconData: Icons.location_on_outlined,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: Text(
                        "$story",
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
                  title: "Update (${updates.length})",
                  body: updates.isEmpty
                      ? Text(
                          "Keep your donor's up-to-date with what's going on with your fundraiser.",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(height: 1.8),
                        )
                      : Container(
                          child: Column(
                            children: updates
                                .map((update) => UpdateBody(
                                      update: update,
                                    ))
                                .toList(),
                          ),
                        )),
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
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Team(),
                    ));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Team (${teams.length})",
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
                              "${user!.firstName![0].toUpperCase()} ${user!.lastName![0].toUpperCase()}",
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
              ),
              SizedBox(
                height: 10.0,
              ),
              FundraiserDetailElements(
                onPressed: () {
                  print('I am tapped');
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FundraiseDonationPage(
                      donations: donations,
                    ),
                  ));
                },
                title: "Donation (${donations.length})",
                body: donations.isEmpty
                    ? Text(
                        "Share your compaign with your friends and family to start getting activity.",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(height: 1.8),
                      )
                    : Container(),
              ),
              SizedBox(
                height: 10.0,
              ),
              FundraiserDetailElements(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CommentsPage()));
                  },
                  title: "Comments",
                  body: Text(
                    "Share your compaigns with those closest to you to get more comments.",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(height: 1.8),
                  ))
            ]),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          bottomNavBarItemTap(value, _fundraise);
        },
        elevation: 5.0,
        selectedItemColor:
            Theme.of(context).secondaryHeaderColor.withOpacity(0.5),
        showUnselectedLabels: true,
        unselectedItemColor:
            Theme.of(context).secondaryHeaderColor.withOpacity(0.5),
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
