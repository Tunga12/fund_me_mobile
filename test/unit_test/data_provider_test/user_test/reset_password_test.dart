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
  group('Testing reset password', () {
    MockClient? client;
    UserDataProvider? userDataProvider;
    setUp(() {
      client = MockClient();
      userDataProvider = UserDataProvider(httpClient: client!);
    });

    // testing reset password when http call completed successfully
    test('http call return User object when comleted successfully', () async {
      when(client!.put(Uri.parse(EndPoints.resetPasswordURL + mockId),
              headers: anyNamed("headers"), body: anyNamed("body")))
          .thenAnswer((_) async => http.Response(mockUserJson, 200));

      expect(
        await userDataProvider!.resetPassword(mockUser.password!, mockId),
        isA<User>(),
      );
    });

    // testing reset password when http call is completed with exception
    test('http call throws exception when completed with exception', () {
      when(client!.put(Uri.parse(EndPoints.resetPasswordURL + mockId),
              headers: anyNamed("headers"), body: anyNamed("body")))
          .thenAnswer((_) async => http.Response("Not Found", 404));
      expect(userDataProvider!.resetPassword(mockUser.password!, mockId),
          throwsException);
    });
  });
}
