import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Models/team_member.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/services/provider/team_member.dart';
import 'package:crowd_funding_app/widgets/authdialog.dart';
import 'package:crowd_funding_app/widgets/custom_card.dart';
import 'package:crowd_funding_app/widgets/loading_progress.dart';
import 'package:crowd_funding_app/widgets/team_tile.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Team extends StatefulWidget {
  Team(
      {Key? key,
      required this.fundraise,
      required this.teams,
      required this.user})
      : super(key: key);
  final Fundraise fundraise;
  List<TeamMember> teams = [];
  final User user;

  @override
  _TeamState createState() => _TeamState();
}

class _TeamState extends State<Team> {
  // final String _teamLink =
  //     'https://shrouded-bastion-52038.herokuapp.com/teamadd/';

  List<TeamMember> _teams = [];

  TeamMember? _teamMember;
  int _teamIndex = 0;
  @override
  void initState() {
    _getToken();
    super.initState();
  }

  String? _token;

  _getToken() async {
    UserPreference _userPreference = UserPreference();
    PreferenceData _prefrenceData = await _userPreference.getUserToken();
    setState(() {
      _token = _prefrenceData.data;

      _teams = widget.teams
          .where((team) =>
              team.member!.userID!.id != widget.fundraise.organizer!.id)
          .toList();
    });
  }

  String _userEmail = '';
  final _formKey = GlobalKey<FormState>();

  _chooseSource() {
    return AlertDialog(
      title: Text("Enter the email address of the user below."),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            onSaved: (value) {
              setState(() {
                _userEmail = value!;
              });
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'field required!';
              } else if (value.length < 5) {
                return "invalid email";
              }
            },
            decoration: InputDecoration(
              labelText: "Enter user email",
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).accentColor),
          onPressed: () async {
            _formKey.currentState!.save();
            if (_formKey.currentState!.validate()) {
              loadingProgress(context);
              await context
                  .read<TeamMemberModel>()
                  .createTeamMember(_userEmail, _token!, widget.fundraise.id!);
              Response _response = context.read<TeamMemberModel>().response;
              if (_response.status == ResponseStatus.SUCCESS) {
                Navigator.of(context).pop();
                Fluttertoast.showToast(
                    msg:
                        "Successfully sent request. The user will receive notification",
                    toastLength: Toast.LENGTH_LONG);
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pop();
                authShowDialog(context, Text(_response.message),
                    close: true, error: true);
              }
            }
          },
          child: Text(
            "Send",
            style: TextStyle(color: Theme.of(context).backgroundColor),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (_token == null) {
      return Container();
    }
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
                          widget.fundraise.organizer!.id == widget.user.id
                              ? 'Add member'
                              : "Message member",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () async {
                          if (widget.fundraise.organizer!.id ==
                              widget.user.id) {
                            showDialog(
                                context: context,
                                builder: (context) => _chooseSource());
                          }
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
                      "Team member (${_teams.length + 1})",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TeamTile(
                      firstName: widget.fundraise.organizer!.firstName!,
                      lastName: widget.fundraise.organizer!.lastName!,
                      subTitle: "Organizer",
                    ),
                    _teams.isEmpty
                        ? Text(
                            "Team members you invite will show up here once they  accept your invite",
                            style: Theme.of(context).textTheme.bodyText1,
                          )
                        : Column(
                            children: _teams
                                .map((team) => TeamTile(
                                    deleteCalback: () async {
                                      setState(() {
                                        _teamMember = team;
                                        _teamIndex = _teams.indexWhere(
                                            (memeber) =>
                                                memeber.member!.id ==
                                                team.member!.id);
                                        _teams.removeWhere(
                                          (member) =>
                                              member.member!.id ==
                                              team.member!.id,
                                        );
                                      });
                                      await context
                                          .read<TeamMemberModel>()
                                          .deleteTeamMember(
                                              _token!, team.member!.id!);
                                      Response _response = context
                                          .read<TeamMemberModel>()
                                          .response;
                                      if (_response.status ==
                                          ResponseStatus.SUCCESS) {
                                      } else {
                                        setState(() {
                                          _teams.insert(
                                              _teamIndex, _teamMember!);
                                        });
                                        Fluttertoast.showToast(
                                          msg: _response.message,
                                          toastLength: Toast.LENGTH_LONG,
                                        );
                                      }
                                    },
                                    isOrganizer: widget.user.id ==
                                        widget.fundraise.organizer!.id,
                                    firstName: team.member!.userID!.firstName!,
                                    lastName: team.member!.userID!.lastName!,
                                    subTitle: "Team member"))
                                .toList(),
                          )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
