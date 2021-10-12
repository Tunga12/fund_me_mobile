import 'package:crowd_funding_app/Models/custom_time.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Models/update.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/Screens/home_page.dart';
import 'package:crowd_funding_app/services/provider/update.dart';
import 'package:crowd_funding_app/widgets/authdialog.dart';
import 'package:crowd_funding_app/widgets/cached_network_image.dart';
import 'package:crowd_funding_app/widgets/loading_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class UpdatesView extends StatelessWidget {
  const UpdatesView({
    Key? key,
    required this.loggedInUser,
    required this.updates,
    required this.token,
  }) : super(key: key);
  final List<Update> updates;
  final User loggedInUser;
  final String token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Updates"),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: updates.length,
            itemBuilder: (context, idx) {
              String date = CustomTime.displayTimeAgoFromTimestamp(
                  updates[0].dateCreated!,context,
                  numericDates: true);
              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Text(
                          "${updates[idx].userID!.firstName![0].toUpperCase()} ${updates[idx].userID!.lastName![0].toUpperCase()}"),
                    ),
                    title: Text(
                      "${updates[idx].userID!.firstName} ${updates[idx].userID!.lastName}",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    subtitle: Text("$date"),
                    trailing: loggedInUser.id == updates[idx].userID!.id
                        ? PopupMenuButton(
                            child: Icon(
                              Icons.more_vert,
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                            onSelected: (value) async {
                              await context
                                  .read<UpdateModel>()
                                  .deleteUpdate(updates[idx].id!, token);
                              Response response =
                                  context.read<UpdateModel>().response;

                              if (response.status == ResponseStatus.LOADING) {
                                loadingProgress(context);
                              } else if (response.status ==
                                  ResponseStatus.SUCCESS) {
                                Fluttertoast.showToast(
                                    msg: "Successfully deleted");
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    HomePage.routeName, (route) => false,
                                    arguments: 2);
                              } else {
                                Navigator.of(context).pop();
                                authShowDialog(
                                    context,
                                    Text(
                                      response.message,
                                    ),
                                    error: true,
                                    close: true);
                              }
                              print(token);
                            },
                            itemBuilder: (context) => [
                                  PopupMenuItem(
                                    child: Text("delete"),
                                    value: 1,
                                  ),
                                ])
                        : null,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 75.0, right: 20.0),
                    child: Column(
                      children: [
                        Html(
                          data: updates[idx].content,
                          style: {
                            "body": Style(
                                fontSize: FontSize.larger,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context)
                                    .secondaryHeaderColor
                                    .withOpacity(0.6))
                          },
                        ),
                      ],
                    ),
                  ),
                  if (updates[idx].image != null)
                    Container(
                      child: CachedImage(
                        image: updates[idx].image!,
                      ),
                    )
                ],
              );
            }),
      ),
    );
  }
}
