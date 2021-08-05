import 'package:cached_network_image/cached_network_image.dart';
import 'package:crowd_funding_app/Models/methods.dart';
import 'package:crowd_funding_app/Models/donation.dart';
import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Models/team_member.dart';
import 'package:crowd_funding_app/Models/update.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/Screens/donation_page.dart';
import 'package:crowd_funding_app/Screens/fundraise_donation_page.dart';
import 'package:crowd_funding_app/Screens/fundraiser_teammember_page.dart';
import 'package:crowd_funding_app/Screens/loading_screen.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/services/provider/fundraise.dart';
import 'package:crowd_funding_app/widgets/campaign_bottom_navbar.dart';
import 'package:crowd_funding_app/widgets/custom_card.dart';
import 'package:crowd_funding_app/widgets/custom_circle_avatar.dart';
import 'package:crowd_funding_app/widgets/response_alert.dart';
import 'package:crowd_funding_app/widgets/title_row.dart';
import 'package:crowd_funding_app/widgets/update_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

const titleTextStyle = TextStyle(fontSize: 25.0, color: Colors.black);

class CampaignDetail extends StatefulWidget {
  final String id;
  CampaignDetail({required this.id});
  @override
  _CampaignDetailState createState() => _CampaignDetailState();
}

class _CampaignDetailState extends State<CampaignDetail> {
  int index = 0;

  ScrollController _scrollController = ScrollController();
  Color _theme = Colors.white;
  bool _visible = false;
  bool _isLiked = false;
  User _user = User();
  String _token = '';
  int _likeCount = 0;

  @override
  void initState() {
    getSingleFundraise();
    getUserInformaion();
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

  getUserInformaion() async {
    UserPreference userPreference = UserPreference();
    PreferenceData userData = await userPreference.getUserInfromation();
    PreferenceData tokeData = await userPreference.getUserToken();
    final model = context.read<FundraiseModel>().fundraise;
    print(model.likeCount);
    print(model.likedBy);
    print(model.id);
    setState(() {
      _user = userData.data;
      _token = tokeData.data;

      _isLiked = model.likedBy!.contains(userData.data.id);
      _likeCount = model.likedBy!.length;
    });
  }

  getSingleFundraise() async {
    await Future.delayed(
      Duration(milliseconds: 1),
      () => context.read<FundraiseModel>().getSingleFundraise(widget.id),
    );
  }

  _likeAction(Fundraise _fundraise) async {
    print("is liked $_isLiked");
    if (!_isLiked)
      _likeCount++;
    else
      _likeCount--;
    List<String> _likedBy = _fundraise.likedBy as List<String>;

    if (!_isLiked)
      _likedBy.add(_user.id!);
    else
      _likedBy.remove(_user.id);

    setState(() {
      _isLiked = !_isLiked;
    });

    Fundraise _fundraiseUpdated = _fundraise.copyWith(
      likeCount: _likeCount,
      likedBy: _likedBy,
    );

    await context
        .read<FundraiseModel>()
        .updateFundraise(_fundraiseUpdated, _token);
    Response response = context.read<FundraiseModel>().response;
    if (response.status != ResponseStatus.SUCCESS) {
      ResponseAlert(response.message);
    }
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
    Location? location = _fundraise.location;
    List<Update> updates = _fundraise.updates!;
    List<TeamMember> teams = _fundraise.teams!;
    List<Donation> donations = _fundraise.donations!;
    double process = 0.0;
    String title = _fundraise.title!;
    String image = _fundraise.image!;
    User? organizer = _fundraise.organizer;
    User? beneficiary = _fundraise.beneficiary;
    int totalRaised = _fundraise.goalAmount!;
    int goalAmount = _fundraise.goalAmount!;
    String story = _fundraise.story!;

    String lastUpdate = updates.isNotEmpty
        ? Jiffy(_fundraise.updates![0].dateCreated, "yyyy-MM-dd").fromNow()
        : "Just Now";
    String lastDonation = donations.isNotEmpty
        ? Jiffy(_fundraise.donations![0].date, "yyyy-MM-dd").fromNow()
        : "Just Now";
    List<Donation> avatarDonations =
        donations.length >= 3 ? donations.sublist(0, 3) : donations;
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
                      width: size.width,
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg',
                        errorWidget: (context, url, error) => Icon(Icons.image),
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
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
                            ),
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
                      '$title',
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
                          "$totalRaised\$ raised",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                        Text(
                          " of \$$goalAmount goal",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    LinearProgressIndicator(
                      value: ((_fundraise.totalRaised as int) /
                          (_fundraise.goalAmount as int)),
                      backgroundColor: Colors.green[100],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          child: Text(
                              "${organizer!.firstName![0].toUpperCase()} ${organizer.lastName![0].toUpperCase()}"),
                          radius: 30.0,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${organizer.firstName} ${organizer.lastName}",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                            ),
                            Text(
                              "${location!.latitude}",
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
                      child: Html(
                        data: story,
                        style: {
                          "body": Style(
                              fontSize: FontSize.larger,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context)
                                  .secondaryHeaderColor
                                  .withOpacity(0.6))
                        },
                      ),
                    ),
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
                      trailingTitle: updates.length > 0
                          ? updates.length.toString()
                          : "No updates",
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    updates.isEmpty
                        ? Text(
                            "No updates yet",
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
                          ),
                    SizedBox(
                      height: 10.0,
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
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FundraiseDonationPage(
                      donations: donations,
                    ),
                  ));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleRow(
                      leadingTitle: "Donations",
                      trailingTitle: donations.length > 0
                          ? donations.length.toString()
                          : "No doantions",
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Last donation $lastDonation",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    donations.isEmpty
                        ? Text(
                            "Share your compaign with your friends and family to start getting activity.",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(height: 1.8),
                          )
                        : Row(
                            children: avatarDonations
                                .map((donation) => CustomCircleAvatar(donation
                                        .userID!.firstName![0]
                                        .toUpperCase() +
                                    donation.userID!.lastName![0]
                                        .toUpperCase()))
                                .toList())
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              CustomCard(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FundraiserTeamMemberPage(
                        teamMembers: teams,
                      ),
                    ),
                  );
                },
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
                      children: teams
                          .map((team) => CustomCircleAvatar(team
                                  .member!.userID!.firstName![0]
                                  .toUpperCase() +
                              team.member!.userID!.lastName![0].toUpperCase()))
                          .toList(),
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
      bottomNavigationBar: CampainBottomNavBar(
        isLiked: _isLiked,
        likeText: Counter.getCounter(_likeCount),
        shareCount: totalShareCount,
        likeAction: () {
          _likeAction(_fundraise);
        },
        shareAction: () {},
        donateAction: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DonationPage(
                fundraise: _fundraise,
              ),
            ),
          );
        },
      ),
    );
  }
}
