import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:crowd_funding_app/services/data_provider/auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../unit_test.mocks.dart';
import '../const_models/mock_user.dart';

@GenerateMocks([http.Client])
main() {
  group("Signin test", () {
    MockClient? client;
    AuthDataProvider? authProvider;
    setUp(() {
      client = MockClient();
      authProvider = AuthDataProvider(httpClient: client!);
    });
    test('returns a token if the http call completes successfully', () async {
      when(client!.post(
        Uri.parse(EndPoints.loginUser),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response("", 201, headers: {
            'x-auth-token': mockUserToken,
          }));

      expect(await authProvider!.signinUser(mocksignInuser),

          startsWith('eyJhbGciOiJIUzI1NiIsInR5cCI6Ikp'));
    });

    test('throws exception if the http call completes with exception',
        () async {
      when(client!.post(
        Uri.parse(EndPoints.loginUser),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response("Not Found", 404));
      expect( authProvider!.signinUser(mocksignInuser), throwsException);
    });
  });
}
