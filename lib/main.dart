import 'dart:io';

import 'package:crowd_funding_app/config/utils/routes.dart';
import 'package:crowd_funding_app/constants/colors.dart';
import 'package:crowd_funding_app/services/data_provider/category.dart';
import 'package:crowd_funding_app/services/data_provider/donation.dart';
import 'package:crowd_funding_app/services/data_provider/fundraiser.dart';
import 'package:crowd_funding_app/services/data_provider/auth.dart';
import 'package:crowd_funding_app/services/data_provider/notification.dart';
import 'package:crowd_funding_app/services/data_provider/team_member.dart';
import 'package:crowd_funding_app/services/data_provider/update.dart';
import 'package:crowd_funding_app/services/data_provider/user.dart';
import 'package:crowd_funding_app/services/data_provider/withdraw.dart';
import 'package:crowd_funding_app/services/provider/auth.dart';
import 'package:crowd_funding_app/services/provider/category.dart';
import 'package:crowd_funding_app/services/provider/donation.dart';
import 'package:crowd_funding_app/services/provider/fundraise.dart';
import 'package:crowd_funding_app/services/provider/notification.dart';
import 'package:crowd_funding_app/services/provider/team_add_deep_link.dart';
import 'package:crowd_funding_app/services/provider/team_member.dart';
import 'package:crowd_funding_app/services/provider/update.dart';
import 'package:crowd_funding_app/services/provider/user.dart';
import 'package:crowd_funding_app/services/provider/withdrawal.dart';
import 'package:crowd_funding_app/services/repository/category.dart';
import 'package:crowd_funding_app/services/repository/donation.dart';
import 'package:crowd_funding_app/services/repository/fundraise.dart';
import 'package:crowd_funding_app/services/repository/auth.dart';
import 'package:crowd_funding_app/services/repository/notification.dart';
import 'package:crowd_funding_app/services/repository/tean_member.dart';
import 'package:crowd_funding_app/services/repository/update.dart';
import 'package:crowd_funding_app/services/repository/user.dart';
import 'package:crowd_funding_app/services/repository/withdrawal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  final FundraiseRepository fundraiseRepository = FundraiseRepository(
    dataProvider: FundraiseDataProvider(
      httpClient: http.Client(),
    ),
  );
  final AuthRepository authRepository = AuthRepository(
    dataProvider: AuthDataProvider(
      httpClient: http.Client(),
    ),
  );
  final UserRepository userRepository = UserRepository(
    dataProvider: UserDataProvider(
      httpClient: http.Client(),
    ),
  );
  final CategoryRepository categoryRepository = CategoryRepository(
    dataProvider: CategoryDataProvider(
      httpClient: http.Client(),
    ),
  );
  final UserNotificationRepository userNotificationRepository =
      UserNotificationRepository(
    dataProvider: UserNotificationDataProvider(
      httpClient: http.Client(),
    ),
  );

  final UpdateRepository updateRepository = UpdateRepository(
    updateDataProvider: UpdateDataProvider(
      httpClient: http.Client(),
    ),
  );
  final DonationRepository donationReponsitory = DonationRepository(
    dataProvider: DonationDataProvider(
      httpClient: http.Client(),
    ),
  );
  final TeamMemberRepository teamMemberRepository = TeamMemberRepository(
    teamMemberDataProvider: TeamMemberDataProvider(
      httpClient: http.Client(),
    ),
  );
  final WithdrawalRepository withdrawalRepository = WithdrawalRepository(
    withdrawDataProvider: WithdrawDataProvider(
      httpClient: http.Client(),
    ),
  );
  runApp(
    CrowdFundingApp(
      fundraiseRepository: fundraiseRepository,
      authRepository: authRepository,
      userRepository: userRepository,
      categoryRepository: categoryRepository,
      notificationRepository: userNotificationRepository,
      updateRepository: updateRepository,
      donationRepository: donationReponsitory,
      teamMemberRepository: teamMemberRepository,
      withdrawalRepository: withdrawalRepository,
    ),
  );
}

class CrowdFundingApp extends StatelessWidget {
  CrowdFundingApp({
    Key? key,
    required this.fundraiseRepository,
    required this.authRepository,
    required this.userRepository,
    required this.categoryRepository,
    required this.notificationRepository,
    required this.updateRepository,
    required this.donationRepository,
    required this.teamMemberRepository,
    required this.withdrawalRepository,
  }) : super(key: key);

  final FundraiseRepository fundraiseRepository;
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final CategoryRepository categoryRepository;
  final UserNotificationRepository notificationRepository;
  final UpdateRepository updateRepository;
  final DonationRepository donationRepository;
  final TeamMemberRepository teamMemberRepository;
  final WithdrawalRepository withdrawalRepository;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));
    final _teamAddModel = TeamAddModel();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FundraiseModel>(
          create: (context) =>
              FundraiseModel(fundraiseRepository: fundraiseRepository),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthModel(authRepository: authRepository),
        ),
        ChangeNotifierProvider<UserModel>(
          create: (context) => UserModel(userRepository: userRepository),
        ),
        ChangeNotifierProvider<CategoryModel>(
          create: (context) =>
              CategoryModel(categoryRepository: categoryRepository)
                ..getAllCategories(),
        ),
        ChangeNotifierProvider<UserNotificationModel>(
            create: (context) => UserNotificationModel(
                notificationRepository: notificationRepository)),
        ChangeNotifierProvider<UpdateModel>(
            create: (context) =>
                UpdateModel(updateRepository: updateRepository)),
        ChangeNotifierProvider<DonationModel>(
            create: (context) =>
                DonationModel(donationRepository: donationRepository)),
        Provider<TeamAddModel>(
          create: (context) => _teamAddModel,
          dispose: (context, data) => data.dispose(),
        ),
        ChangeNotifierProvider<TeamMemberModel>(
          create: (context) =>
              TeamMemberModel(teamMemberRepository: teamMemberRepository),
        ),
        ChangeNotifierProvider<WithdrawalModel>(
            create: (context) => WithdrawalModel(
                  withdrawalRepository: withdrawalRepository,
                ))
      ],
      child: MaterialApp(
        onGenerateRoute: AppRoute.generateRoute,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: MaterialColor(0xFF00B860, color),
            primaryColor: MaterialColor(0xFF00B860, color),
            accentColor: MaterialColor(0xFF08B868, color_two),
            backgroundColor: Colors.white,
            secondaryHeaderColor: Colors.grey[800],
            buttonColor: Colors.amber[800],
            appBarTheme: AppBarTheme(color: Colors.white),
            textTheme: TextTheme(
                bodyText1: TextStyle(color: Colors.grey, fontSize: 16.0),
                bodyText2: TextStyle(
                    color: MaterialColor(0xFF08B868, color_two),
                    fontWeight: FontWeight.bold))),
      ),
    );
  }
}
