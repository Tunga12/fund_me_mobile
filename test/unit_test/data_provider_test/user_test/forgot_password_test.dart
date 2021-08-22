import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:crowd_funding_app/services/data_provider/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../unit_test.mocks.dart';
import '../const_models/mock_user.dart';

@GenerateMocks([http.Client])
main() {
  group('Testing forgot password', () {
    MockClient? client;
    UserDataProvider? userDataProvider;
    setUp(() {
      client = MockClient();
      userDataProvider = UserDataProvider(httpClient: client!);
    });

    // testing forgot password when http call completed successfully
    test("http call returns true if completed successfully", () async {
      when(client!.post(Uri.parse(EndPoints.forgotPasswordURL),
              headers: anyNamed("headers"), body: anyNamed("body")))
          .thenAnswer((_) async => http.Response('deleted', 200));
      expect(
          await userDataProvider!.forgetPassword(mockUser.email!), 'deleted');
    });

    // testing forgot password when http call completed with exception
    test('http call throws exception if completed with exception ', () {
      when(client!.post(Uri.parse(EndPoints.forgotPasswordURL),
              headers: anyNamed("headers"), body: anyNamed("body")))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      expect(
          userDataProvider!.forgetPassword(mockUser.email!), throwsException);
    });
  });
}
