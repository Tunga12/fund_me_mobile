import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:crowd_funding_app/services/data_provider/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../unit_test.mocks.dart';
import '../const_models/mock_user.dart';

void main() {
  group('Testing update user', () {
    MockClient? client;
    UserDataProvider? userDataProvider;
    setUp(() {
      client = MockClient();
      userDataProvider = UserDataProvider(httpClient: client!);
    });

    // test update user if the http call is completed successfully
    test("Http call return a User Object if completed successfuly", () async {
      when(client!.put(Uri.parse(EndPoints.singleUser),
              headers: anyNamed('headers'), body: anyNamed("body")))
          .thenAnswer((_) async => http.Response(mockUserJson, 200));

      expect(await userDataProvider!.updateUser(mockUser, mockUserToken),
          isA<User>());
    });

    // test update user if the http call is completed with exception
    test("Http call throws eexception if completed with exception", () async {
      when(client!.put(Uri.parse(EndPoints.singleUser),
              headers: anyNamed('headers'), body: anyNamed("body")))
          .thenAnswer((_) async => http.Response("Not Found", 404));

      expect( userDataProvider!.updateUser(mockUser, mockUserToken),
          throwsException);
    });
  });
}
