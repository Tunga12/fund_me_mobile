import 'dart:async';

import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/Screens/create_fundraiser_home.dart';
import 'package:crowd_funding_app/Screens/manage.dart';
import 'package:crowd_funding_app/Screens/notification.dart';
import 'package:crowd_funding_app/Screens/search.dart';
import 'package:crowd_funding_app/Screens/settings.dart';
import 'package:crowd_funding_app/Screens/signin_page.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/constants/actions.dart';
import 'package:crowd_funding_app/services/provider/notification.dart';
import 'package:crowd_funding_app/services/provider/notification_real_time.dart';
import 'package:crowd_funding_app/translations/locale_keys.g.dart';
import 'package:crowd_funding_app/widgets/home_body.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/homePage";
  HomePage({Key? key, this.index}) : super(key: key);
  int? index;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? _user;
  String? _token;
  List<Widget> _bodyChild = [];
  List<Widget> _appBarChild = [];

  bool textFieldIsFocused = true;
  bool tapped = false;
  NotificationRealTimeModel? _notificationRealTimeModel;

  void toggleWidget() {}

  void toggleFocused() {}

  getCampaign() {}

  int _selectedIndex = 0;

  void _onTappedTapped(int index) {
    if (index == 1 || index == 2) {
      if (_user == null) {
        Navigator.of(context).pushNamed(SigninPage.routeName);
        return;
      }
    }
    if (index == 3) {
      if (_user != null) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Settings()));
        return;
      } else {
        Navigator.of(context).pushNamed(SigninPage.routeName);
        return;
      }
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  _setIndex() {
    if (widget.index != null) {
      setState(() {
        _selectedIndex = widget.index!;
      });
    }
  }

  getUser() async {
    _notificationRealTimeModel = NotificationRealTimeModel();
    UserPreference _userPreference = UserPreference();
    PreferenceData preferenceData = await _userPreference.getUserInfromation();
    PreferenceData _tokenPreferenceData = await _userPreference.getUserToken();
    _notificationRealTimeModel!.createConnection(_tokenPreferenceData.data);
    setState(() {
      _user = preferenceData.data;
      _token = _tokenPreferenceData.data;
    });
  }

  @override
  void initState() {
    _setIndex();
    getUser();
    super.initState();
  }

  @override
  void dispose() {
    // _notificationRealTimeModel!.closeCountConnection();
    // _notificationRealTimeModel!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _bodyChild = [
      HomeBody(),
      _user != null ? Notifications() : SigninPage(),
      _user != null ? Manage() : SigninPage(),
      Container(),
    ];
    _appBarChild = [
      GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SearchPage()));
        },
        child: Container(
          height: 30.0,
          child: TextField(
            autofocus: false,
            enabled: false,
            onTap: () {},
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5.0),
                hintText: LocaleKeys.home_body_search_label_text.tr(),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.0))),
          ),
        ),
      ),
      Text(
        LocaleKeys.notifications_label_text.tr(),
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      Text(
        LocaleKeys.your_fundraisers_text.tr(),
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: _selectedIndex > 0 ? 4.0 : 0.0,
          centerTitle: true,
          actions: _selectedIndex == 1
              ? [
                  Container(
                    margin: EdgeInsets.only(right: 20.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.green)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () {
                          print("I am tapped");
                        },
                        child: Icon(
                          Icons.settings,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  )
                ]
              : [],
          title: _appBarChild[_selectedIndex]),
      body: _bodyChild[_selectedIndex],
      floatingActionButton: _selectedIndex == 2
          ? FloatingActionButton(
              child: Icon(
                Icons.add,
                color: Theme.of(context).backgroundColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateFundraiserHome(),
                  ),
                );
              },
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        enableFeedback: false,
        currentIndex: _selectedIndex,
        onTap: _onTappedTapped,
        backgroundColor: Theme.of(context).backgroundColor,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(color: Theme.of(context).primaryColor),
        unselectedItemColor:
            Theme.of(context).secondaryHeaderColor.withOpacity(0.3),
        selectedItemColor: Theme.of(context).accentColor,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                key: Key("home_page_discover_button"),
              ),
              label: LocaleKeys.discover_label_text.tr()),
          BottomNavigationBarItem(
              icon: StreamBuilder(
                  key: Key("home_page_notification_button"),
                  stream:
                      _notificationRealTimeModel!.getUnreadNotificationsCount,
                  builder: (context, snapshots) {
                    print("snapshots data is ");
                    print(snapshots.data);
                    if (!snapshots.hasData) {
                      return Container(
                        child: Icon(
                          Icons.notifications_outlined,
                        ),
                      );
                    }
                    int number = snapshots.data as int;
                    return number == 0
                        ? Container(
                            child: Icon(
                              Icons.notifications_outlined,
                            ),
                          )
                        : Badge(
                            badgeContent: Text(
                              "$number",
                              style: TextStyle(
                                  color: Theme.of(context).backgroundColor),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(
                              Icons.notifications_outlined,
                            ),
                          );
                  }),
              label: LocaleKeys.notifications_label_text.tr()),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.description,
              key: Key("home_page_manage_button"),
            ),
            label: LocaleKeys.manage_label_text.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_outlined,
              key: Key("home_page_me_button"),
            ),
            label: LocaleKeys.me_label_text.tr(),
          ),
        ],
      ),
    );
  }
}
