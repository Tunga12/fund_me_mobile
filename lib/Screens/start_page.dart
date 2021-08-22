import 'package:crowd_funding_app/Screens/forgot_password.dart';
import 'package:crowd_funding_app/Screens/popular_fundraise_detail.dart';
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
          String data = snapshots.data!;

          if (data.substring(45).startsWith('fundraiser')) {
            String fundraiserId = data.substring(56);
            return CampaignDetail(id: fundraiserId);
          } else if (data.substring(45).startsWith("api/users/verify")) {
            String userId = data.substring(62);
            return ForgotPassword(url: userId);
          } else if (data
              .substring(45)
              .startsWith('api/withdrawal/invitation')) {
            return Container();
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Container(
                child: Center(
                  child: Text("Unknown path"),
                ),
              ),
            );
          }
        }
      },
    );
  }
}
