import 'package:crowd_funding_app/Models/team_member.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/Screens/fundraiser_teammember_page.dart';
import 'package:crowd_funding_app/widgets/custom_card.dart';
import 'package:crowd_funding_app/widgets/team_tile.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class Team extends StatelessWidget {
  Team(
      {Key? key,
      required this.fundraiseId,
      required this.teams,
      required this.user})
      : super(key: key);
  final String _teamLink = 'http://gofundme.team.add/';
  final String fundraiseId;
  final List<TeamMember> teams;
  final User user;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Team"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              CustomCard(
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          child: Icon(
                            Icons.group_outlined,
                            color: Theme.of(context).accentColor,
                            size: 40,
                          ),
                          radius: 40.0,
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Fundraising team",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'Edit Team Settings ',
                              style: TextStyle(
                                  color: Theme.of(context).accentColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      width: size.width,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                  color: Theme.of(context).accentColor),
                            )),
                        child: Text(
                          "Add member",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Share.share(_teamLink + "$fundraiseId");
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Message team",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Team member (${teams.length + 1})",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TeamTile(
                          firstName: user.firstName ?? "",
                          lastName: user.lastName ?? "",
                          subTitle: "Organizer"),
                      teams.isEmpty
                          ? Text(
                              "Team members you invite will show up here once they they accept your invite",
                              style: Theme.of(context).textTheme.bodyText1,
                            )
                          : Column(
                              children: teams
                                  .map((team) => TeamTile(
                                      firstName:
                                          team.member!.userID!.firstName!,
                                      lastName: team.member!.userID!.lastName!,
                                      subTitle: "Team member"))
                                  .toList(),
                            )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
