import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:crowd_funding_app/services/data_provider/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../unit_test.mocks.dart';
import '../const_models/mock_user.dart';

main() {
  group('Testing delete user', () {
    MockClient? client;
    UserDataProvider? userDataProvider;
    setUp(() {
      client = MockClient();
      userDataProvider = UserDataProvider(httpClient: client!);
    });

    // Testing delete user when the http call is completed successfully
    test("Http call return String if completed successfuly", () async {
      when(client!.delete(Uri.parse(EndPoints.singleUser),
              headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response("Successfully deleted", 200));
      expect(await userDataProvider!.deleteUser(mockUserToken),
          "Successfully deleted");
    });

    // Testing delete user when http call is completed with exception
    test("Http call throws exception if completed with exception", () async {
      when(client!.delete(Uri.parse(EndPoints.singleUser),
              headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response("Not Found", 404));
      expect( userDataProvider!.deleteUser(mockUserToken),
          throwsException);
    });

  });

}