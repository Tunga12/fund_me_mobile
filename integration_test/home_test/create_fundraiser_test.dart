import 'dart:convert';

import 'package:crowd_funding_app/Screens/manage.dart';
import 'package:crowd_funding_app/Screens/notification.dart';
import 'package:crowd_funding_app/Screens/settings.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../common/app.dart';
import '../common/mocks.dart';
import '../unit_test.mocks.dart';

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  group('Testing create fundraiser ', () {
    MockClient? client;
    setUp(() {
      client = MockClient();
    });

    testWidgets('testing create fundraiser', (tester) async {
      when(
        client!.post(Uri.parse(EndPoints.loginUser),
            body: jsonEncode(<String, dynamic>{
              'email': "abex@gmail.com",
              'password': "123456789"
            }),
            headers: anyNamed('headers')),
      ).thenAnswer(
          (_) async => http.Response('', 201, headers: {"headers": mockId}));

      when(
        client!
            .get(Uri.parse(EndPoints.singleUser), headers: anyNamed('headers')),
      ).thenAnswer((_) async => http.Response(
            mockUserJson,
            200,
          ));

      when(client!.get(Uri.parse(EndPoints.notificaions + "user"),
              headers: anyNamed("headers")))
          .thenAnswer((realInvocation) async =>
              http.Response(mockNotificationsJson, 200));

      when(client!.get(Uri.parse(EndPoints.popularFundraisers + "?page=0"),
              headers: anyNamed("headers")))
          .thenAnswer(
              (realInvocation) async => http.Response(mockFundraiseJson, 200));

      when(client!.get(Uri.parse(EndPoints.userFundraisrs + "?page=0"),
              headers: anyNamed("headers")))
          .thenAnswer(
              (realInvocation) async => http.Response(mockFundraiseJson, 200));
      when(client!.get(Uri.parse(EndPoints.benficiaryFundraiserURL + "?page=0"),
              headers: anyNamed("headers")))
          .thenAnswer(
              (realInvocation) async => http.Response(mockFundraiseJson, 200));

      when(client!.get(Uri.parse(EndPoints.teamMemberFundraises + "?page=0"),
              headers: anyNamed("headers")))
          .thenAnswer(
              (realInvocation) async => http.Response(mockFundraiseJson, 200));

      when(client!.get(Uri.parse(EndPoints.categories),
              headers: anyNamed("headers")))
          .thenAnswer(
              (realInvocation) async => http.Response(mockCategoriesJson, 200));

      await tester.pumpWidget(testApp(client!));
      await tester.pumpAndSettle(const Duration(seconds: 3));
      // await tester.pump(const Duration(seconds: 10));
      await tester.tap(
        find.byKey(
          Key("welcome_page_signin_button"),
        ),
      );
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(
            Key("email_formfield"),
          ),
          "abex@gmail.com");
      await tester.enterText(
          find.byKey(Key('password_formfield')), '123456789');
      final signinButton = find.byKey(Key('signinbutton_key'));

      await tester.tap(signinButton);
      await tester.pumpAndSettle();

      // await tester.tap(find.byKey(Key("start_a_legas_button")));
      // await tester.pumpAndSettle();

      // await tester.tap(find.byKey(Key('create_legas_for_yourself')));
      // await tester.pumpAndSettle();

      // await tester.enterText(
      //     find.byKey(Key("goal_amount_mount_field")), "1234");

      // await tester.tap(find.byKey(Key("category_selection_field")));
      // await tester.pump();
      // await tester.pump(const Duration(seconds: 2));

      // await tester.tap(
      //   find.text('mock1'),
      // );

      // await tester.pump();
      // await tester.pump(const Duration(seconds: 2));
      // await tester.tap(find.byKey(Key("choose_location_button")));
      // await tester.pumpAndSettle(const Duration(seconds: 2));
      // await tester.tap(find.byKey(Key("continue_create_button")));
      // await tester.pumpAndSettle();

       await tester.drag(
          find.byKey(Key("home_body_first_list_view")), Offset(0.0, -900));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Key('home_page_notification_button')));
      await tester.pumpAndSettle();
      expect(find.byType(Notifications), findsOneWidget);

      await tester.tap(find.byKey(Key('home_page_manage_button')));
      await tester.pumpAndSettle();
      expect(find.byType(Manage), findsOneWidget);

      await tester.tap(find.byKey(Key('home_page_me_button')));
      await tester.pumpAndSettle();
      expect(find.byType(Settings), findsOneWidget);
    });
  });
}
