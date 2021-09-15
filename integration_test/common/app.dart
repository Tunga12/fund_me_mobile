import 'package:crowd_funding_app/main.dart';
import 'package:crowd_funding_app/services/data_provider/auth.dart';
import 'package:crowd_funding_app/services/data_provider/category.dart';
import 'package:crowd_funding_app/services/data_provider/donation.dart';
import 'package:crowd_funding_app/services/data_provider/fundraiser.dart';
import 'package:crowd_funding_app/services/data_provider/help.dart';
import 'package:crowd_funding_app/services/data_provider/notification.dart';
import 'package:crowd_funding_app/services/data_provider/report.dart';
import 'package:crowd_funding_app/services/data_provider/team_member.dart';
import 'package:crowd_funding_app/services/data_provider/update.dart';
import 'package:crowd_funding_app/services/data_provider/user.dart';
import 'package:crowd_funding_app/services/data_provider/withdraw.dart';
import 'package:crowd_funding_app/services/repository/auth.dart';
import 'package:crowd_funding_app/services/repository/category.dart';
import 'package:crowd_funding_app/services/repository/donation.dart';
import 'package:crowd_funding_app/services/repository/fundraise.dart';
import 'package:crowd_funding_app/services/repository/help.dart';
import 'package:crowd_funding_app/services/repository/notification.dart';
import 'package:crowd_funding_app/services/repository/report.dart';
import 'package:crowd_funding_app/services/repository/tean_member.dart';
import 'package:crowd_funding_app/services/repository/update.dart';
import 'package:crowd_funding_app/services/repository/user.dart';
import 'package:crowd_funding_app/services/repository/withdrawal.dart';
import 'package:crowd_funding_app/translations/codegen_loader.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../unit_test.mocks.dart';

Widget testApp(MockClient client) {
  final FundraiseRepository fundraiseRepository = FundraiseRepository(
    dataProvider: FundraiseDataProvider(
      httpClient: client,
    ),
  );

  final CategoryRepository categoryRepository = CategoryRepository(
    dataProvider: CategoryDataProvider(
      httpClient: client,
    ),
  );
  final UserNotificationRepository userNotificationRepository =
      UserNotificationRepository(
    dataProvider: UserNotificationDataProvider(
      httpClient: client,
    ),
  );

  final UpdateRepository updateRepository = UpdateRepository(
    updateDataProvider: UpdateDataProvider(httpClient: client),
  );
  final DonationRepository donationReponsitory = DonationRepository(
    dataProvider: DonationDataProvider(
      httpClient: client,
    ),
  );
  final TeamMemberRepository teamMemberRepository = TeamMemberRepository(
    teamMemberDataProvider: TeamMemberDataProvider(
      httpClient: client,
    ),
  );
  final WithdrawalRepository withdrawalRepository = WithdrawalRepository(
    withdrawDataProvider: WithdrawDataProvider(
      httpClient: client,
    ),
  );
  final HelpRepository helpRepository =
      HelpRepository(helpDataProvider: HelpDataProvider(httpClient: client));

  AuthRepository authRepository =
      AuthRepository(dataProvider: AuthDataProvider(httpClient: client));

  UserRepository userRepository =
      UserRepository(dataProvider: UserDataProvider(httpClient: client));
  ReportRepository reportRepository = ReportRepository(
      reportDataProvider: ReportDataProvider(httpClient: client));

  return EasyLocalization(
    supportedLocales: [Locale('en'), Locale('am'), Locale('or'), Locale('tr')],
    assetLoader: CodegenLoader(),
    fallbackLocale: Locale('en'),
    path: 'assets/translations',
    child: CrowdFundingApp(
      reportRepository: reportRepository,
      fundraiseRepository: fundraiseRepository,
      authRepository: authRepository,
      userRepository: userRepository,
      categoryRepository: categoryRepository,
      notificationRepository: userNotificationRepository,
      updateRepository: updateRepository,
      donationRepository: donationReponsitory,
      teamMemberRepository: teamMemberRepository,
      withdrawalRepository: withdrawalRepository,
      helpRepository: helpRepository,
    ),
  );
}
