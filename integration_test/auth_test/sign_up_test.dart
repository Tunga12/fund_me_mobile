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

  group('Testing signup page', () {
    MockClient? client;
    setUp(() {
      client = MockClient();
    });

    testWidgets('empty user credentials don not call signup ',
        (WidgetTester tester) async {
      when(
        client!.post(
          Uri.parse(EndPoints.registerUser),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer((_) async =>
          http.Response('', 201, headers: {"x-auth-token": mockId}));

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
      

      await tester.pumpWidget(testApp(client!));
      await tester.pumpAndSettle(const Duration(seconds: 3));
      await tester.tap(
        find.byKey(
          Key("welcome_page_signin_button"),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Key("signup_button_text")));
      await tester.pumpAndSettle();
      expect(find.byType(TextFormField), findsNWidgets(6));

      await tester.drag(
          find.byKey(Key("signup_page_listview")), Offset(0.0, -300));
      await tester.tap(find.byKey(Key('signup_button')));
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(Key("signup_firstname")), "test");
      await tester.enterText(find.byKey(Key("signup_lastname")), "test");
      await tester.enterText(find.byKey(Key("signup_email")), "test@gmail.com");
      await tester.enterText(
          find.byKey(Key("signup_phonenumber")), "0911223344");
      await tester.enterText(find.byKey(Key("signup_password")), "123456789");
      await tester.enterText(
          find.byKey(Key("signup_confirmpassword")), "123456789");
      await tester.tap(find.byKey(Key('signup_button')));
      await tester.pumpAndSettle();
    });
  });
}
