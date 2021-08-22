import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:crowd_funding_app/services/data_provider/notification.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../unit_test.mocks.dart';
import '../const_models/mock_user.dart';

@GenerateMocks([http.Client])
main() {
  group('Testing deleteNotification', () {
    MockClient? client;
    UserNotificationDataProvider? userNotificationDataProvider;
    setUp(() {
      client = MockClient();
      userNotificationDataProvider =
          UserNotificationDataProvider(httpClient: client!);
    });

    // Testing deleteNotification when completed successfully
    test("DeleteNotifcation returns true if completed successfully", () async {
      when(client!.delete(Uri.parse(EndPoints.notificaions + mockId),
              headers: anyNamed("headers")))
          .thenAnswer((_) async => http.Response('deleted', 200));

      expect(
          await userNotificationDataProvider!
              .deleteNotification(mockId, mockUserToken),
          "deleted");
    });

    // Testing deleteNotification when completed with error
    test("DeleteNotifcation throws exception when completed with error",
        () async {
      when(client!.delete(Uri.parse(EndPoints.notificaions + mockId),
              headers: anyNamed("headers"), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(
          userNotificationDataProvider!
              .deleteNotification(mockId, mockUserToken),
          throwsException);
    });
  });
}
