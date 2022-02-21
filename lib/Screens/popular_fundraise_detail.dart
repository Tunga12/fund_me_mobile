import 'package:crowd_funding_app/Models/custom_time.dart';
import 'package:crowd_funding_app/Models/methods.dart';
import 'package:crowd_funding_app/Models/donation.dart';
import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Models/reason.dart';
import 'package:crowd_funding_app/Models/report.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Models/team_member.dart';
import 'package:crowd_funding_app/Models/total_raised.dart';
import 'package:crowd_funding_app/Models/update.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/Screens/donation_page.dart';
import 'package:crowd_funding_app/Screens/fundraise_donation_page.dart';
import 'package:crowd_funding_app/Screens/fundraiser_teammember_page.dart';
import 'package:crowd_funding_app/Screens/loading_screen.dart';
import 'package:crowd_funding_app/Screens/share_page.dart';
import 'package:crowd_funding_app/Screens/signin_page.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/services/provider/currency.dart';
import 'package:crowd_funding_app/services/provider/fundraise.dart';
import 'package:crowd_funding_app/services/provider/report.dart';
import 'package:crowd_funding_app/translations/locale_keys.g.dart';
import 'package:crowd_funding_app/widgets/campaign_bottom_navbar.dart';
import 'package:crowd_funding_app/widgets/custom_cached_network_image.dart';
import 'package:crowd_funding_app/widgets/custom_card.dart';
import 'package:crowd_funding_app/widgets/custom_circle_avatar.dart';
import 'package:crowd_funding_app/widgets/expandable_content.dart';
import 'package:crowd_funding_app/widgets/report_dialog.dart';
import 'package:crowd_funding_app/widgets/response_alert.dart';
import 'package:crowd_funding_app/widgets/title_row.dart';
import 'package:crowd_funding_app/widgets/verified.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

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
  User? _user;
  String _token = '';
  int _likeCount = 0;
  double _currencyRate = 0;

  @override
  void initState() {
    getSingleFundraise().whenComplete(() => getUserInformaion());

    _scrollController.addListener(
      () => _getIsAppbarCollapsed
          ? {
              _theme != Colors.white
                  ? setState(
                      () {
                        _visible = false;
                        _theme = Colors.white;
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

  Fundraise? _fundraise;
  Response _response =
      Response(data: '', status: ResponseStatus.LOADING, message: "");
  List<ReportReason> _reportReasons = [];

  getUserInformaion() async {
    UserPreference userPreference = UserPreference();
    PreferenceData userData = await userPreference.getUserInfromation();
    PreferenceData tokeData = await userPreference.getUserToken();
    final model = context.read<FundraiseModel>().fundraise;
    setState(() {
      _user = userData.data;
      _token = tokeData.data;

      _isLiked =
          _user != null ? model.likedBy!.contains(userData.data.id) : false;
      _likeCount = model.likedBy!.length;
    });
  }

  Future getSingleFundraise() async {
    await Future.delayed(
      Duration(milliseconds: 1),
      () => context.read<FundraiseModel>().getSingleFundraise(widget.id),
    );

    await Future.delayed(
      Duration(milliseconds: 1),
      () => context.read<ReportModel>().getReportReasons(),
    );
    
   
 

    final _currencyRateResponse = context.read<CurrencyRateModel>().response;

    final model = context.read<FundraiseModel>();
    Response _responseModel = context.read<ReportModel>().response;
    print("The fundraiser reasons are status are as follows ");
    print(_responseModel.status);

    setState(() {
      _fundraise = model.fundraise;
      _response = model.response;
      _reportReasons = _responseModel.data;
      _currencyRate = _currencyRateResponse.data ?? 0;
    });
  }

  _likeAction(Fundraise _fundraise) async {
    print("is liked $_isLiked");
    if (!_isLiked)
      _likeCount++;
    else
      _likeCount--;
    List<String> _likedBy = _fundraise.likedBy as List<String>;

    if (!_isLiked)
      _likedBy.add(_user!.id!);
    else
      _likedBy.remove(_user!.id);

    setState(() {
      _isLiked = !_isLiked;
    });

    Fundraise _fundraiseUpdated = _fundraise.copyWith(
      likeCount: _likeCount,
      likedBy: _likedBy,
    );

    await Provider.of<FundraiseModel>(context, listen: false)
        .updateFundraise(_fundraiseUpdated, _token);
    Response response = context.read<FundraiseModel>().response;
    if (response.status != ResponseStatus.SUCCESS) {
      ResponseAlert(response.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (_response.status == ResponseStatus.LOADING) {
      return LoadingScreen();
    } else if (_response.status == ResponseStatus.CONNECTIONERROR) {
      return ResponseAlert(
        'no internet connection',
        retry: () {
          getSingleFundraise();
        },
        status: ResponseStatus.CONNECTIONERROR,
      );
    } else if (_response.status == ResponseStatus.FORMATERROR) {
      return ResponseAlert(
        _response.message,
        retry: () => getSingleFundraise(),
        status: ResponseStatus.MISMATCHERROR,
      );
    } else if (_response.status == ResponseStatus.SUCCESS) {
      print("Report reasons");
      print(_reportReasons);
      if (_fundraise == null) return Container();
      // var days = Jiffy(_fundraise!.dateCreated, "yyyy-MM-dd").fromNow();
      String totalShareCount =
          Counter.getCounter(_fundraise!.totalSharedCount!);
      Location? location = _fundraise!.location;
      List<Update> updates = _fundraise!.updates!;
      List<TeamMember> teams = _fundraise!.teams!;
      List<Donation> donations = _fundraise!.donations!;
      // double process = 0.0;
      String title = _fundraise!.title!;
      String image = _fundraise!.image!;
      User? organizer = _fundraise!.organizer;
      // User? beneficiary = _fundraise!.beneficiary;
      TotalRaised _totalRaised = _fundraise!.totalRaised!;

      double _dollarValue = _currencyRate is double
          ? _currencyRate * _totalRaised.dollar!.toDouble()
          : _totalRaised.dollar!.toDouble();
      double totalRaised = _dollarValue + _totalRaised.birr!.toDouble();

      int goalAmount = _fundraise!.goalAmount!;
      String story = _fundraise!.story!;

      String lastDonation = donations.isNotEmpty
          ? CustomTime.displayTimeAgoFromTimestamp(
              _fundraise!.donations![0].date!, context,numericDates: true)
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
                        child: CustomCachedNetworkImage(
                          image: image,
                          isTopBorderd: false,
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
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
                            "${totalRaised.toStringAsFixed(0)} ETB ${LocaleKeys.raised_lable_text.tr()}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                          ),
                          Text(
                            " ${LocaleKeys.of_label_text.tr()} ${goalAmount.toStringAsFixed(0)} ETB ${LocaleKeys.goal_label_text.tr()}",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      LinearProgressIndicator(
                        value: _fundraise!.totalRaised!.dollar! *
                            _currencyRate /
                            _fundraise!.goalAmount!.toInt(),
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
                              Row(
                                children: [
                                  Text(
                                    "${organizer.firstName} ${organizer.lastName}",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20.0),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  if (organizer.isVerified!) Verfied(),
                                ],
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
                        leadingTitle: LocaleKeys.updates_title_text.tr(),
                        trailingTitle: updates.length > 0
                            ? updates.length.toString()
                            : LocaleKeys.no_update_text.tr(),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      updates.isEmpty
                          ? Text(
                              LocaleKeys.no_updates_yet_text.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(height: 1.8),
                            )
                          : ExpandableContent(updates: updates),
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
                        leadingTitle: LocaleKeys.donations_title_text.tr(),
                        trailingTitle: donations.length > 0
                            ? donations.length.toString()
                            : LocaleKeys.no_donation_label_text.tr(),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "${LocaleKeys.last_donation_label_text.tr()} $lastDonation",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      donations.isEmpty
                          ? Text(
                              LocaleKeys.share_your_campaign_with_your_friends
                                  .tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    height: 1.8,
                                  ),
                            )
                          : Row(
                              children: avatarDonations
                                  .map((donation) => CustomCircleAvatar(
                                      donation.isAnonymous!
                                          ? "A"
                                          : donation.userID!.firstName![0]
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
                          organizer: organizer,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.team_title_text.tr(),
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
                        children: teams
                            .map((team) => CustomCircleAvatar(team
                                    .member!.userID!.firstName![0]
                                    .toUpperCase() +
                                team.member!.userID!.lastName![0]
                                    .toUpperCase()))
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
            if (_user != null) {
              _likeAction(_fundraise!);
            } else {
              Navigator.of(context).pushNamed(SigninPage.routeName);
            }
          },
          shareAction: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SharePage(
                  fundraise: _fundraise!,
                ),
              ),
            );
          },
          reportAction: () {
            showDialog(
              context: context,
              builder: (context) => ReportDialog(_fundraise!, _reportReasons),
            );
          },
          donateAction: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DonationPage(
                  fundraise: _fundraise!,
                ),
              ),
            );
          },
        ),
      );
    } else {
      return ResponseAlert(
        _response.message,
      );
    }
  }
}
