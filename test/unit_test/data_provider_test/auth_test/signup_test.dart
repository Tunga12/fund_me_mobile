// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'package:crowd_funding_app/services/data_provider/auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../unit_test.mocks.dart';
import '../const_models/mock_user.dart';





@GenerateMocks([http.Client])
void main() {
  group("Signup user", () {
    MockClient? client;
    AuthDataProvider? authProvider;
    setUp(() {
      client = MockClient();
      authProvider = AuthDataProvider(httpClient: client!);
    });
    test('returns a token if the http call completes successfully', () async {
      when(client!.post(
              Uri.http('shrouded-bastion-52038.herokuapp.com', '/api/users'),
              headers: anyNamed('headers'),
              body: anyNamed('body')))
          .thenAnswer((_) async => http.Response("", 201,
              headers: {'x-auth-token': mockUserToken}));
      expect(
        await authProvider!.createUser(mockUser),
        startsWith('eyJhbGciOiJIUzI1NiIsInR5cCI6Ikp'),
      );
    });
    test("throws exception if the http call completes with exception",
        () async {
      when(
        client!.post(
          Uri.http('shrouded-bastion-52038.herokuapp.com', '/api/users'),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async => http.Response("Not Found", 404),
      );
      expect(authProvider!.createUser(mockUser), throwsException);
    });
  });
}
