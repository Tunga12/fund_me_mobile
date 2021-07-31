import 'package:crowd_funding_app/Models/team_member.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:flutter/material.dart';

class FundraiserTeamMemberPage extends StatelessWidget {
  FundraiserTeamMemberPage({Key? key, required this.teamMembers})
      : super(key: key);
  List<TeamMember> teamMembers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fundraising Team",
          style: appbarTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(20.0),
            child: teamMembers.length > 0
                ? Column(
                    children: teamMembers
                        .map((team) => Teams(
                              teamMember: team,
                            ))
                        .toList(),
                  )
                : Center(
                    child: Text(
                      "No Teams yet",
                      style: labelTextStyle.copyWith(
                          color: Theme.of(context).secondaryHeaderColor),
                    ),
                  )),
      ),
    );
  }
}

class Teams extends StatelessWidget {
  Teams({Key? key, required this.teamMember}) : super(key: key);

  TeamMember teamMember;

  String fullName = "";
  String avatarChild = "";
  getData() {
    fullName =
        teamMember.userID!.firstName! + " " + teamMember.userID!.lastName!;
    avatarChild = teamMember.userID!.firstName![0].toUpperCase() +
        teamMember.userID!.lastName![0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor:
                Theme.of(context).secondaryHeaderColor.withOpacity(0.5),
            child: Text(
              "$avatarChild",
              style: labelTextStyle.copyWith(
                  color: Theme.of(context).backgroundColor),
            ),
          ),
          title: Text("$fullName"),
          subtitle: Text(
            "CampaignOrganizer",
            style: labelTextStyle.copyWith(
                color: Theme.of(context).secondaryHeaderColor.withOpacity(0.5)),
          ),
        ),
        Divider(color: Theme.of(context).secondaryHeaderColor.withOpacity(0.7))
      ],
    );
  }
}
