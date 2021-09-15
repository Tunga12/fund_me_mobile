import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/Screens/edit_page.dart';
import 'package:crowd_funding_app/Screens/share_page.dart';
import 'package:crowd_funding_app/Screens/team.dart';
import 'package:crowd_funding_app/Screens/update_page.dart';
import 'package:crowd_funding_app/Screens/withdraw_page.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ManageBottomNavBar extends StatefulWidget {
  ManageBottomNavBar({
    Key? key,
    required this.fundraise,
    required this.isOrganizer,
  }) : super(key: key);

  final bool isOrganizer;
  final Fundraise fundraise;

  @override
  _ManageBottomNavBarState createState() => _ManageBottomNavBarState();
}

class _ManageBottomNavBarState extends State<ManageBottomNavBar> {
  User? _user;

  getUserInformation() async {
    UserPreference userPreference = UserPreference();
    PreferenceData preferenceData = await userPreference.getUserInfromation();
    setState(() {
      _user = preferenceData.data;
    });
  }

  @override
  void initState() {
    getUserInformation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bottomNavBarAction(int index) {
      switch (index) {
        case 0:
        
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => widget.fundraise.beneficiary!.id == null
                  ? WithdrawPage(
                      fundraise: widget.fundraise,
                      isSetUped: false,
                      isAccepted: false,
                      isWithdawn: false,
                    )
                  : WithdrawPage(
                      fundraise: widget.fundraise,
                      isSetUped: true,
                      beneficiary: widget.fundraise.beneficiary,
                      isAccepted: true,
                      isWithdawn: widget.fundraise.withdrwal!.id == null
                          ? false
                          : widget.fundraise.withdrwal!.status == 'accepted',
                    ),
            ),
          );
          return;
        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditPage(
                widget.fundraise,
              ),
            ),
          );
          return;
        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SharePage(
                fundraise: widget.fundraise,
              ),
            ),
          );
          return;
        case 3:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UpdatePage(widget.fundraise.id!),
            ),
          );
          return;
        case 4:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Team(
                fundraise: widget.fundraise,
                teams: widget.fundraise.teams ?? [],
                user: _user ?? User(),
              ),
            ),
          );
          return;
      }
    }

    bottomNonOrganizerAction(int index) {
      switch (index) {
        case 0:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SharePage(
                fundraise: widget.fundraise,
              ),
            ),
          );
          return;
        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UpdatePage(widget.fundraise.id!),
            ),
          );
          return;
      }
    }

    int index = 0;
    return widget.isOrganizer
        ? Container(
            child: BottomNavigationBar(
              currentIndex: index,
              onTap: bottomNavBarAction,
              elevation: 5.0,
              selectedItemColor:
                  Theme.of(context).secondaryHeaderColor.withOpacity(0.5),
              showUnselectedLabels: true,
              unselectedItemColor:
                  Theme.of(context).secondaryHeaderColor.withOpacity(0.5),
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.money),
                  label:LocaleKeys.withdraw_bottom_bar_button.tr(),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.edit),
                  label: LocaleKeys.edit_bottom_bar_button.tr(),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.ios_share),
                  label: LocaleKeys.share_bottom_bar_button.tr(),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_box_outlined),
                  label: LocaleKeys.update_bottom_bar_button.tr(),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.group_outlined),
                  label: LocaleKeys.team_bottom_bar_button.tr(),
                ),
              ],
            ),
          )
        : Container(
            child: BottomNavigationBar(
              currentIndex: index,
              onTap: bottomNonOrganizerAction,
              elevation: 5.0,
              selectedItemColor:
                  Theme.of(context).secondaryHeaderColor.withOpacity(0.5),
              showUnselectedLabels: true,
              unselectedItemColor:
                  Theme.of(context).secondaryHeaderColor.withOpacity(0.5),
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.ios_share),
                  label:LocaleKeys.share_bottom_bar_button.tr(),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_box_outlined),
                  label: LocaleKeys.update_bottom_bar_button.tr(),
                ),
              ],
            ),
          );
  }
}
