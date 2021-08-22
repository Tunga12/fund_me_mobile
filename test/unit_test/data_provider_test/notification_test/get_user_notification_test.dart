import 'package:crowd_funding_app/Models/notification.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:crowd_funding_app/services/data_provider/notification.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../unit_test.mocks.dart';
import '../const_models/mock_notification.dart';
import '../const_models/mock_user.dart';

@GenerateMocks([http.Client])
main() {
  group('Testing getAllUserNotifications', () {
    MockClient? client;
    UserNotificationDataProvider? userNotificationDataProvider;
    setUp(() {
      client = MockClient();
      userNotificationDataProvider =
          UserNotificationDataProvider(httpClient: client!);
    });

    // Testing getAllUserNotifications when the user completed successfully
    test("getUserNotificatons return List of UserNotificaion object completed succsfully", () async {
      when(client!.get(Uri.parse(EndPoints.notificaions + "user"),
              headers: anyNamed("headers")))
          .thenAnswer((realInvocation) async =>
              http.Response(mockNotificationsJson, 200));
      expect(
          await userNotificationDataProvider!
              .getUserNotifications(mockUserToken),
          isA<List<UserNotification>>());
    });

    // Testing getAllUserNotifications when the user completed with exception
    test("getUserNotificatons throws exception when completed with error", ()  {
      when(client!.get(Uri.parse(EndPoints.notificaions + "user"),
              headers: anyNamed("headers")))
          .thenAnswer((realInvocation) async =>
              http.Response("Not Found", 404));
      expect(
           userNotificationDataProvider!
              .getUserNotifications(mockUserToken),
          throwsException);
    });

  });
}
