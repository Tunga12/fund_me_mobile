import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/Screens/create_fundraiser_home.dart';
import 'package:crowd_funding_app/Screens/manage.dart';
import 'package:crowd_funding_app/Screens/notification.dart';
import 'package:crowd_funding_app/Screens/search.dart';
import 'package:crowd_funding_app/Screens/settings.dart';
import 'package:crowd_funding_app/Screens/signin_page.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/widgets/home_body.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/homePage";
  HomePage({Key? key, this.index}) : super(key: key);
  int? index;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? _user;
  List<Widget> _bodyChild = [];
  List<Widget> _appBarChild = [];

  bool textFieldIsFocused = true;
  bool tapped = false;

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
    UserPreference _userPreference = UserPreference();
    PreferenceData preferenceData = await _userPreference.getUserInfromation();
    setState(() {
      _user = preferenceData.data;
    });
  }

  @override
  void initState() {
    _setIndex();
    getUser();
    super.initState();
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
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.0))),
          ),
        ),
      ),
      Text(
        "Notifications",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      Text(
        "Your fundraisers",
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
              ),
              label: "Discover"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications_outlined,
              ),
              label: "Notifications"),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: "Manage",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle_outlined,
              ),
              label: "Me"),
        ],
      ),
    );
  }
}
