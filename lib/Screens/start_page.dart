import 'package:crowd_funding_app/Screens/accept_invite_page.dart';
import 'package:crowd_funding_app/Screens/splash_screen.dart';
import 'package:crowd_funding_app/services/provider/team_add_deep_link.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartPage extends StatelessWidget {
  StartPage({Key? key}) : super(key: key);
  static String routeName = '/';

  @override
  Widget build(BuildContext context) {
    final _model = context.read<TeamAddModel>();
    return StreamBuilder<String>(
      stream: _model.state,
      builder: (context, snapshots) {
        print("snapshots ${snapshots.data}");
        if (!snapshots.hasData) {
          return SplashScreen();
        } else {
          return AcceptTeamInvitation(data: snapshots.data!);
        }
      },
    );
  }
}
