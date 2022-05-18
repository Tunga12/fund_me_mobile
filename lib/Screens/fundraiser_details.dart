import 'package:crowd_funding_app/Models/category.dart';
import 'package:crowd_funding_app/Models/donation.dart';
import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Models/team_member.dart';
import 'package:crowd_funding_app/Models/total_raised.dart';
import 'package:crowd_funding_app/Models/update.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/Screens/donation_page.dart';
import 'package:crowd_funding_app/Screens/fundraise_donation_page.dart';
import 'package:crowd_funding_app/Screens/loading_screen.dart';
import 'package:crowd_funding_app/Screens/team.dart';
import 'package:crowd_funding_app/Screens/update_view.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/services/provider/currency.dart';
import 'package:crowd_funding_app/services/provider/fundraise.dart';
import 'package:crowd_funding_app/translations/locale_keys.g.dart';
import 'package:crowd_funding_app/widgets/custom_cached_network_image.dart';
import 'package:crowd_funding_app/widgets/custom_raised_button.dart';
import 'package:crowd_funding_app/widgets/expandable_content.dart';
import 'package:crowd_funding_app/widgets/fundraiser_detail_element.dart';
import 'package:crowd_funding_app/widgets/manage_bottom_bar.dart';
import 'package:crowd_funding_app/widgets/response_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

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
  User? user = User();
  String? token;
  double _currencyRate = 0.0;

  getSingleFundraise() async {
    UserPreference userPreference = UserPreference();
    PreferenceData data = await userPreference.getUserInfromation();
    PreferenceData tokenData = await userPreference.getUserToken();
    setState(() {
      user = data.data;
      token = tokenData.data;
    });
    await Future.delayed(
      Duration(milliseconds: 1),
      () =>
          context.read<FundraiseModel>().getSingleFundraise(widget.fundraiseId),
    );

    final _currencyRateResponse = context.read<CurrencyRateModel>().response;
    setState(() {
      _currencyRate = _currencyRateResponse.data ?? 0.0;
    });
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
    print("fundraiser id is ${widget.fundraiseId}");
    final size = MediaQuery.of(context).size;
    final model = context.watch<FundraiseModel>();

    if (model.response.status == ResponseStatus.LOADING) {
      return LoadingScreen();
    } else if (model.response.status == ResponseStatus.CONNECTIONERROR) {
      return ResponseAlert(model.response.message);
    } else if (model.response.status == ResponseStatus.FORMATERROR) {
      return ResponseAlert(model.response.message);
    } else if (model.response.status == ResponseStatus.MISMATCHERROR) {
      return ResponseAlert(model.response.message);
    }

    Fundraise _fundraise = model.fundraise;
    print(_fundraise.withdrwal);

    Location? location = _fundraise.location;
    List<Update> updates = _fundraise.updates ?? [];
    List<TeamMember> teams = _fundraise.teams ?? [];
    teams = teams
        .where((team) => team.member!.userID!.id != _fundraise.organizer!.id)
        .toList();
    List<Donation> donations = _fundraise.donations!;
    Category category = _fundraise.category!;
    // double process = 0.0;
    String title = _fundraise.title!;
    String image = _fundraise.image!;
    User? organizer = _fundraise.organizer;
    // User? beneficiary = _fundraise.beneficiary;

    TotalRaised _totalRaised = _fundraise.totalRaised!;
    double _dollarValue = _currencyRate is double
        ? _currencyRate * _totalRaised.dollar!.toDouble()
        : _totalRaised.dollar!.toDouble();
    double totalRaised = _dollarValue + _totalRaised.birr!.toDouble();
    int goalAmount = _fundraise.goalAmount!;
    String story = _fundraise.story!;

    // String lastUpdate = updates.isNotEmpty
    //     ? Jiffy(_fundraise.updates![0].dateCreated, "yyyy-MM-dd").fromNow()
    //     : "Just Now";
    // String lastDonation = donations.isNotEmpty
    //     ? Jiffy(_fundraise.donations![0].date, "yyyy-MM-dd").fromNow()
    //     : "Just Now";

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
                          child: CustomCachedNetworkImage(
                            isTopBorderd: true,
                            image: image,
                          )),
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
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
                            "${totalRaised.toStringAsFixed(0)} ${LocaleKeys.usd_label_text.tr()} ${LocaleKeys.raised_lable_text.tr()}",
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          Text(
                            " ${LocaleKeys.of_label_text.tr()} $goalAmount ${LocaleKeys.usd_label_text.tr()} ",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      LinearProgressIndicator(
                        value: totalRaised / goalAmount,
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
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DonationPage(
                                  fundraise: _fundraise,
                                ),
                              ),
                            );
                          },
                          child: Text(LocaleKeys.donate_now_button_text.tr()),
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
                          // CustomRaisedButton(
                          //   title: "${location!.latitude}",
                          //   iconData: Icons.location_on_outlined,
                          //   onPressed: () {},
                          // ),
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
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                FundraiserDetailElements(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UpdatesView(
                              loggedInUser: user!,
                              updates: updates,
                              token: token!,
                            )));
                  },
                  title:
                      " ${LocaleKeys.updates_title_text.tr()} (${updates.length})",
                  body: updates.isEmpty
                      ? Text(
                          LocaleKeys.keep_your_donaors_label_text.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(height: 1.8),
                        )
                      : ExpandableContent(updates: updates),
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
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Team(
                            teams: _fundraise.teams!,
                            fundraise: _fundraise,
                            user: user!,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${LocaleKeys.team_title_text.tr()} (${user!.id == organizer!.id ? teams.length + 1 : teams.length + 1})",
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
                              LocaleKeys.fundraising_team_text.tr(),
                              style: titleTextStyle.copyWith(fontSize: 25.0),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            if (user!.id != organizer.id)
                              TeamIcons(
                                user: organizer,
                              ),
                            if (teams.isNotEmpty)
                              TeamIcons(user: teams.first.member!.userID),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              LocaleKeys.you_are_fundraising_as_ateam_label_text
                                  .tr(),
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyText1,
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
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FundraiseDonationPage(
                        donations: donations,
                      ),
                    ));
                  },
                  title:
                      "${LocaleKeys.donations_title_text.tr()} (${donations.length})",
                  body: donations.isEmpty
                      ? Text(
                          LocaleKeys.share_your_campaign_with_your_friends.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(height: 1.8),
                        )
                      : Container(
                          child: Row(
                            children: donations.length <= 3
                                ? donations
                                    .map((donation) =>
                                        TeamIcons(user: donation.userID))
                                    .toList()
                                : donations
                                    .sublist(0, 3)
                                    .map((donation) =>
                                        TeamIcons(user: donation.userID))
                                    .toList(),
                          ),
                        ),
                ),
              ]),
            )
          ],
        ),
        bottomNavigationBar: ManageBottomNavBar(
          fundraise: _fundraise,
          isOrganizer: _fundraise.beneficiary!.id == null
              ? user!.id == _fundraise.organizer!.id
              : user!.id == _fundraise.beneficiary!.id ||
                  user!.id == _fundraise.organizer!.id,
        ));
  }
}

class TeamIcons extends StatelessWidget {
  const TeamIcons({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircleAvatar(
        child: Text(
          "${user!.firstName![0].toUpperCase()}${user!.lastName![0].toUpperCase()}",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        radius: 20.0,
        backgroundColor: Colors.grey[300],
      ),
    );
  }
}
