import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:crowd_funding_app/services/data_provider/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import '../../../unit_test.mocks.dart';
import '../const_models/mock_user.dart';

void main() {
  group("Get user test", () {
    MockClient? client;
    UserDataProvider? userDataProvider;
    setUp(() {
      client = MockClient();
      userDataProvider = UserDataProvider(httpClient: client!);
    });

    // test the result when the http call is successful
    test("Returns a user object if the http call is succesfully completed",
        () async {
      when(client!.get(Uri.parse(EndPoints.singleUser),
              headers: anyNamed("headers")))
          .thenAnswer((_) async => http.Response(mockUserJson, 200));

      expect(
        await userDataProvider!.getUser(mockUserToken, ''),
        isA<User>(),
      );
    });

    // testing the result when the http call completed with Exception.
    test("Throws Exception if the http call completed with Exception",
        () async {
      when(client!.get(Uri.parse(EndPoints.singleUser),
              headers: anyNamed("headers")))
          .thenAnswer((_) async => http.Response("NotFound", 404));

      expect(userDataProvider!.getUser(mockUserToken, ''), throwsException);
    });
  });
}
