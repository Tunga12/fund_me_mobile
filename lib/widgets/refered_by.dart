import 'package:crowd_funding_app/Models/team_member.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:crowd_funding_app/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class RefferedBy extends StatefulWidget {
  const RefferedBy({
    Key? key,
    required this.teams,
    required this.memeberCallback,
    required this.anonymousCallback,
  }) : super(key: key);
  final List<TeamMember> teams;
  final Function(String memberId) memeberCallback;
  final Function(bool isAnonymous) anonymousCallback;

  @override
  _RefferedByState createState() => _RefferedByState();
}

class _RefferedByState extends State<RefferedBy> {
  List<TeamMember> teams = [
    TeamMember(
      member: Member(
          userID: User(firstName: "Select Team", lastName: "Member"), id: "0"),
    )
  ];
  @override
  void initState() {
    _setInfo();
    super.initState();
  }

  _setInfo() {
    setState(() {
      teams.addAll(widget.teams);
    });
  }

  String _memberId = "0";
  bool _isAnnonymous = false;
  bool _getNotification = true;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.0,
          ),
          Text(
            LocaleKeys.donation_detail_label_text.tr(),
            style: labelTextStyle.copyWith(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).secondaryHeaderColor,
            ),
          ),
          SizedBox(height: 15.0),
          if (widget.teams.length > 1)
            Text(
              "Reffered by",
              style: labelTextStyle.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).secondaryHeaderColor,
              ),
            ),
          SizedBox(height: 5.0),
          Form(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.teams.length > 1)
                Container(
                  width: size.width * 0.5,
                  child: DropdownButtonFormField<String>(
                    value: _memberId,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                          8.0,
                        ))),
                    onChanged: (value) {
                      setState(() {
                        _memberId = value!;
                        widget.memeberCallback(value);
                      });
                    },
                    items: teams
                        .map(
                          (team) => DropdownMenuItem<String>(
                            value: team.member!.id,
                            child: Row(
                              children: [
                                Text(team.member!.userID!.firstName! +
                                    " " +
                                    team.member!.userID!.lastName!),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _isAnnonymous,
                    onChanged: (value) {
                      setState(() {
                        _isAnnonymous = value!;
                        widget.anonymousCallback(value);
                      });
                    },
                  ),
                  Container(
                    width: size.width * 0.6,
                    child: Text(
                      LocaleKeys.dont_display_my_name_label_text.tr(),
                      style: labelTextStyle.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _getNotification,
                    onChanged: (value) {
                      setState(() {
                        _getNotification = value!;
                      });
                    },
                  ),
                  Container(
                    width: size.width * 0.6,
                    child: Text(
                     LocaleKeys.get_occational_marketing_label_text.tr(),
                      style: labelTextStyle.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                    ),
                  )
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
