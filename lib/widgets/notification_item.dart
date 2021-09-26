import 'package:crowd_funding_app/Models/custom_time.dart';
import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Models/notification.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/Screens/accept_invite_page.dart';
import 'package:crowd_funding_app/Screens/popular_fundraise_detail.dart';
import 'package:crowd_funding_app/Screens/share_page.dart';
import 'package:crowd_funding_app/services/provider/notification.dart';
import 'package:crowd_funding_app/widgets/authdialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class NotficationItem extends StatelessWidget {
  final UserNotification notification;
  final User user;
  final String token;
  final Function notifyCallback;
  NotficationItem({
    required this.notification,
    required this.user,
    required this.token,
    required this.notifyCallback,
  });
  @override
  Widget build(BuildContext context) {
    // String date = Jiffy(notification.date).fromNow();
    String date = CustomTime.displayTimeAgoFromTimestamp(notification.date!,
        numericDates: true);
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () async {
        if (notification.viewed!.contains(user.id)) {
          Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CampaignDetail(
                    id: notification.fundraiser!,
                  ),
                ),
              );
        } else {
          print("notification fundraiser id is");
          print('date is $date');
          print(notification.date);
          print(notification.fundraiser);
          List<String> _views = notification.viewed!;
          print("Viewds $_views");
          _views.removeWhere((userId) => userId == user.id);
          UserNotification _userNotification = UserNotification(
            id: notification.id,
          );

          if (notification.type == 'Team Member') {
            print("team invitation");
            print(_userNotification.content);
            await context
                .read<UserNotificationModel>()
                .updateNotification(_userNotification, token);
            Response response = context.read<UserNotificationModel>().response;
            if (response.status == ResponseStatus.SUCCESS) {
              notifyCallback();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AcceptTeamInvitation(
                    data: notification.fundraiser!,
                  ),
                ),
              );
            } else {
              print("The error message is ");
              print(response.message);
              Fluttertoast.showToast(
                  msg: "unable to see notification",
                  toastLength: Toast.LENGTH_LONG);
            }
          } else {
            await context
                .read<UserNotificationModel>()
                .updateNotification(_userNotification, token);
            Response response = context.read<UserNotificationModel>().response;
            if (response.status == ResponseStatus.SUCCESS) {
              notifyCallback();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CampaignDetail(
                    id: notification.fundraiser!,
                  ),
                ),
              );
            } else {
              Fluttertoast.showToast(
                  msg: "unable to see notification",
                  toastLength: Toast.LENGTH_LONG);
            }
          }
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 1.0),
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: notification.viewed!.contains(user.id)
              ? Colors.white
              : Colors.cyan.withOpacity(0.15),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                offset: Offset(0, 3))
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              thickness: 1.5,
              color: Colors.grey,
            ),
            Image.asset(
              'assets/images/icon_vector.PNG',
              height: size.height * 0.05,
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Html(style: {
                    "body": Style(
                        fontSize: FontSize.larger,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context)
                            .secondaryHeaderColor
                            .withOpacity(0.6))
                  }, data: notification.title),
                  Html(style: {
                    "body": Style(
                        fontSize: FontSize.large,
                        fontWeight: FontWeight.w400,
                        // textOverflow: TextOverflow.ellipsis,
                        color: Theme.of(context)
                            .secondaryHeaderColor
                            .withOpacity(0.6))
                  }, data: notification.content),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SharePage(
                            fundraise: Fundraise(
                                id: notification.fundraiser,
                                title: notification.title),
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Share now",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              "$date",
              style: TextStyle(
                  color: Colors.grey[600], fontWeight: FontWeight.w400),
            ),
            SizedBox(
              width: 10.0,
            ),
            PopupMenuButton(
              child: Icon(
                Icons.more_vert,
                color: Theme.of(context).secondaryHeaderColor,
              ),
              onSelected: (value) async {
                notifyCallback();
                await context
                    .read<UserNotificationModel>()
                    .deleteNotification(notification.id!, token);
                Response response =
                    context.read<UserNotificationModel>().response;
                if (response.status == ResponseStatus.SUCCESS) {
                  print("Successsfully deleted");
                  notifyCallback();
                } else {
                  authShowDialog(context, Text(response.message),
                      error: true, close: true);
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text("delete"),
                  value: 1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
