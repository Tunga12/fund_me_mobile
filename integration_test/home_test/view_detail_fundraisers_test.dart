import 'dart:convert';

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
        client!.post(
          Uri.parse(EndPoints.loginUser),
          body: jsonEncode(<String, dynamic>{
            'email': "abex@gmail.com",
            'password': "123456789"
          }),
          headers: anyNamed('headers'),
        ),
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
      when(client!.get(
              Uri.parse(
                  "http://178.62.55.81/api/fundraisers/beneficiary/?page=0"),
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

      when(client!.get(Uri.parse(EndPoints.fundraises + mockId),
              headers: anyNamed("headers")))
          .thenAnswer((realInvocation) async =>
              http.Response(mockFundraiserDetailJson, 200));

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

      await tester.tap(find.byKey(Key('home_page_manage_button')));
      await tester.pumpAndSettle();

      Finder listViewFinder = find.byType(ListView);
      ListView listView = tester.widget(listViewFinder) as ListView;

      print(
          "printttrrrrrrrrrrrrrrrrrtrttfgttttttttttttttttttttttttttttttttttttttt");
      print(listView.childrenDelegate);
      // await tester.tap(find.byKey(Key('6139b43808e2b100166d1c1f')));
      // await tester.pumpAndSettle();
      expect(listViewFinder, findsOneWidget);
    });
  });
}
