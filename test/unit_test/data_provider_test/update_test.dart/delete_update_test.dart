import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:crowd_funding_app/services/data_provider/update.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../unit_test.mocks.dart';
import '../const_models/mock_user.dart';

@GenerateMocks([http.Client])
main() {
  group('Testing deleteUpdate', () {
    MockClient? client;
    UpdateDataProvider? updateDataProvider;
    setUp(() {
      client = MockClient();
      updateDataProvider = UpdateDataProvider(httpClient: client!);
    });
    // Testing deleteUpdate when completed successfully
    test("deleteUpdate returns true if completed successfully", () async {
      when(client!.delete(
       Uri.parse(EndPoints.createUpdate + mockId),
        headers: anyNamed("headers"),
        body: anyNamed("body")
      )).thenAnswer((_) async => http.Response("deleted", 200));

      expect(
          await updateDataProvider!.deleteUpdate(mockId, mockUserToken),
          "deleted");
    });

     // Testing deleteUpdate when completed with error
    test("deleteUpdate throws Exception if completed with error", () async {
     when(client!.delete(
       Uri.parse(EndPoints.createUpdate + mockId),
        headers: anyNamed("headers"),
        body: anyNamed("body")
      )).thenAnswer((_) async => http.Response("Not Found", 404));

      expect(
           updateDataProvider!.deleteUpdate(mockId, mockUserToken),
          throwsException);
    });
  });
}
