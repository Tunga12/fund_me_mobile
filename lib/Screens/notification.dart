import 'dart:async';

import 'package:crowd_funding_app/Models/notification.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/Screens/home_page.dart';
import 'package:crowd_funding_app/Screens/loading_screen.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/constants/actions.dart';
import 'package:crowd_funding_app/services/provider/notification.dart';
import 'package:crowd_funding_app/services/provider/notification_real_time.dart';
import 'package:crowd_funding_app/widgets/empty_body.dart';
import 'package:crowd_funding_app/widgets/notification_item.dart';
import 'package:crowd_funding_app/widgets/response_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);
  // final List<UserNotification> userNotifications;

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  User? _user;
  String? _token;
  Response _value =
      Response(status: ResponseStatus.LOADING, data: null, message: '');
  List<UserNotification> _userNotification = [];
  NotificationRealTimeModel? _notificationRealTimeModel;

  @override
  void initState() {
    getNotificaions();
    _createConnection();
    super.initState();
  }

  _createConnection() async {
    _notificationRealTimeModel = NotificationRealTimeModel();
    _notificationRealTimeModel!.getNewNotifications.listen((notification) {
      print("listening to notification");
      setState(() {
        _userNotification.add(notification);
      });
    });
  }

  @override
  void dispose() {
    // _notificationRealTimeModel!.closeNotification();
  
    super.dispose();
  }

  getNotificaions() async {
    UserPreference userPreference = UserPreference();
    PreferenceData token = await userPreference.getUserToken();
    PreferenceData user = await userPreference.getUserInfromation();
    await Future.delayed(
      Duration(milliseconds: 1),
      () => Provider.of<UserNotificationModel>(context, listen: false)
          .getAllUserNotifications(token.data),
    );

    if (mounted) {
      Response _valueResponse = context.read<UserNotificationModel>().response;
      setState(() {
        _token = token.data;
        _user = user.data;

        _value = _valueResponse;
        _userNotification = _valueResponse.data;
      });
    }
  }

  Future _refresh() async {
    getNotificaions();
  }

  @override
  Widget build(BuildContext context) {
    if (_value.status == ResponseStatus.LOADING) {
      return LoadingScreen();
    } else if (_value.status == ResponseStatus.CONNECTIONERROR) {
      return ResponseAlert(
        _value.message,
        status: ResponseStatus.CONNECTIONERROR,
        retry: () => getNotificaions(),
      );
    } else if (_value.status == ResponseStatus.MISMATCHERROR) {
      return ResponseAlert(
        _value.message,
        retry: () => getNotificaions(),
        status: ResponseStatus.MISMATCHERROR,
      );
    } else {
      List<UserNotification> userNotificatons = _userNotification;
      userNotificatons =
          filterViewedNotifications(userNotificatons, _user!.id!);
      if (userNotificatons.isEmpty) {
        return EmptyBody(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(HomePage.routeName);
          },
          btnText1: 'Explore home feed',
          isFilled: false,
          text1: 'Nothing to see here yet',
          text2:
              'find stories and cases you care about on your home feed to get relevant updates here.',
        );
      }
      return RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: Container(
          color: Theme.of(context).backgroundColor.withOpacity(0.8),
          child: ListView.builder(
            itemCount: userNotificatons.length,
            itemBuilder: (context, index) {
              return NotficationItem(
                notifyCallback: () {
                  getNotificaions();
                },
                user: _user!,
                token: _token!,
                notification: userNotificatons[index],
              );
            },
          ),
        ),
      );
    }
  }
}
