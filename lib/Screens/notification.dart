import 'package:crowd_funding_app/Models/notification.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Screens/home_page.dart';
import 'package:crowd_funding_app/Screens/loading_screen.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/services/provider/notification.dart';
import 'package:crowd_funding_app/widgets/empty_body.dart';
import 'package:crowd_funding_app/widgets/empty_payment.dart';
import 'package:crowd_funding_app/widgets/notification_item.dart';
import 'package:crowd_funding_app/widgets/response_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    getNotificaions();
    super.initState();
  }

  getNotificaions() async {
    UserPreference userPreference = UserPreference();
    PreferenceData token = await userPreference.getUserToken();
    await context
        .read<UserNotificationModel>()
        .getAllUserNotifications(token.data);
  }

  Future _refresh() async {
    getNotificaions();
  }

  @override
  Widget build(BuildContext context) {
    // getNotificaions();
    Response value = context.watch<UserNotificationModel>().response;
    print("screen data ${value.status}");

    if (value.status == ResponseStatus.LOADING) {
      return LoadingScreen();
    } else if (value.status == ResponseStatus.CONNECTIONERROR) {
      return ResponseAlert(
        value.message,
        status: ResponseStatus.CONNECTIONERROR,
        retry: () => getNotificaions(),
      );
    } else if (value.status == ResponseStatus.FORMATERROR) {
      return ResponseAlert(value.message);
    } else {
      print("Notification ${value.data}");
      List<UserNotification> userNotificatons = value.data ?? [];
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
        child: ListView.builder(
          itemCount: userNotificatons.length,
          itemBuilder: (context, index) {
            return NotficationItem(
              content: userNotificatons[index].content);
          },
        ),
      );
    }
  }
}
