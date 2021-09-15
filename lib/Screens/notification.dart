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
import 'package:crowd_funding_app/translations/locale_keys.g.dart';
import 'package:crowd_funding_app/widgets/empty_body.dart';
import 'package:crowd_funding_app/widgets/notification_item.dart';
import 'package:crowd_funding_app/widgets/response_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class Notifications extends StatefulWidget {
  const Notifications(this.notifications, {Key? key}) : super(key: key);
  // final List<UserNotification> userNotifications;
  final Function notifications;

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
  Timer? _timerClock;
  List<UserNotification> _userNotification = [];
  @override
  void initState() {
    _timerClock = Timer.periodic(Duration(seconds: 2), (_) {
      widget.notifications();
      return getNotificaions();
    });
    getNotificaions();
    super.initState();
  }

  @override
  void dispose() {
    _timerClock!.cancel();
    // Provider.of<NotificationRealTimeModel>(context).dispose();
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
      });
      //  Provider.of<NotificationRealTimeModel>(context)
      //   .createConnection(token.data);
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
    // return StreamBuilder(
    //   stream:
    //       Provider.of<NotificationRealTimeModel>(context).getNewNotifications,
    //   builder: (context, snapshots) {
    //     if (!snapshots.hasData) {
    //       return EmptyBody(
    //           onPressed: () {
    //             Navigator.of(context).pushReplacementNamed(HomePage.routeName);
    //           },
    //           btnText1: LocaleKeys.explore_home_feed_text.tr(),
    //           isFilled: false,
    //           text1: LocaleKeys.Nothing_to_see_label_text.tr(),
    //           text2: LocaleKeys.find_stories_and_cases_label_text.tr());
    //     } else if (snapshots.hasData) {
    //       List<UserNotification> _userNotifications =
    //           snapshots.data as List<UserNotification>;
    //       return RefreshIndicator(
    //         key: _refreshIndicatorKey,
    //         onRefresh: _refresh,
    //         child: Container(
    //           color: Theme.of(context).backgroundColor.withOpacity(0.8),
    //           child: ListView.builder(
    //             itemCount: _userNotifications.length,
    //             itemBuilder: (context, index) {
    //               return NotficationItem(
    //                 notifyCallback: () {
    //                   getNotificaions();
    //                 },
    //                 user: _user!,
    //                 token: _token!,
    //                 notification: _userNotifications[index],
    //               );
    //             },
    //           ),
    //         ),
    //       );
    //     } else {
    //       return ResponseAlert(
    //         _value.message,
    //         status: ResponseStatus.CONNECTIONERROR,
    //         retry: () => getNotificaions(),
    //       );
    //     }
    //   },
    // );
    List<UserNotification> userNotificatons = _value.data ?? [];
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

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            