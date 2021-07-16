import 'package:crowd_funding_app/Models/campaign.dart';
import 'package:crowd_funding_app/Screens/manage.dart';
import 'package:crowd_funding_app/Screens/notification.dart';
import 'package:crowd_funding_app/Screens/search.dart';
import 'package:crowd_funding_app/Screens/settings.dart';
import 'package:crowd_funding_app/widgets/home_body.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Campaign> campaines = [];
  List<Widget> _bodyChild = [];
  List<Widget> _appBarChild = [];

  bool textFieldIsFocused = true;
  bool tapped = false;

  void toggleWidget() {}

  void toggleFocused() {}

  getCampaign() {}

  int _selectedIndex = 0;

  void _onTappedTapped(int index) {
    if (index == 3) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Settings()));
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _bodyChild = [
      HomeBody(size: size),
      Notifications(),
      Manage(),
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
              onPressed: () {})
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
              icon: Icon(Icons.home_outlined), label: "Discover"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_outlined), label: "Notifications"),
          BottomNavigationBarItem(
              icon: Icon(Icons.description), label: "Manage"),
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
