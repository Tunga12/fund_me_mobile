import 'dart:convert';

import 'package:crowd_funding_app/Screens/home_page.dart';
import 'package:crowd_funding_app/Screens/manage.dart';
import 'package:crowd_funding_app/Screens/notification.dart';
import 'package:crowd_funding_app/Screens/settings.dart';
import 'package:crowd_funding_app/Screens/signin_page.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:crowd_funding_app/services/data_provider/auth.dart';
import 'package:crowd_funding_app/services/provider/auth.dart';
import 'package:crowd_funding_app/services/repository/auth.dart';
import 'package:crowd_funding_app/widgets/home_body.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../common/app.dart';
import '../common/mocks.dart';
import '../common/wrapper.dart';
import '../unit_test.mocks.dart';

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  group('Testing signin page', () {
    MockClient? client;
    setUp(() {
      client = MockClient();
    });

    // testing with entering a user credential
    testWidgets('we can login after entering the correct user credential',
        (WidgetTester tester) async {
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

      when(client!.get(Uri.parse(EndPoints.popularFundraisers + '?page=0'),
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

      await tester.pumpWidget(testApp(client!));
      await tester.pumpAndSettle(const Duration(seconds: 3));
      // await tester.pump(const Duration(seconds: 10));
      await tester.tap(
        find.byKey(
          Key("welcome_page_signin_button"),
        ),
      );
      await tester.pumpAndSettle();

      final textFormField = find.byType(TextFormField);
      final signinButton = find.byKey(Key('signinbutton_key'));
      expect(textFormField, findsNWidgets(2));
      expect(signinButton, findsOneWidget);

      await tester.tap(signinButton);
      await tester.pumpAndSettle();
      // incorrect email and  password
      await tester.enterText(
          find.byKey(
            Key("email_formfield"),
          ),
          "abex@gmal.com");
      await tester.enterText(
          find.byKey(Key('password_formfield')), '12345678910');

      await tester.tap(signinButton);
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);
      await tester.tap(find.byKey(Key('dialog_close_button')));
      await tester.pumpAndSettle();

      // correct email and password
      await tester.enterText(
          find.byKey(
            Key("email_formfield"),
          ),
          "abex@gmail.com");
      await tester.enterText(
          find.byKey(Key('password_formfield')), '123456789');

      await tester.tap(signinButton);
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(HomeBody), findsOneWidget);
    });
  });
}
