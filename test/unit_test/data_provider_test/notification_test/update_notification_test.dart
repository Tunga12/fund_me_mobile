import 'package:crowd_funding_app/services/data_provider/notification.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

import '../../../unit_test.mocks.dart';

@GenerateMocks([http.Client])
main() async {
  group('Testing getAllUserNotifications', () {
    MockClient? client;
    UserNotificationDataProvider? userNotificationDataProvider;
    setUp(() {
      client = MockClient();
      userNotificationDataProvider =
          UserNotificationDataProvider(httpClient: client!);
    });

    //Testing updateNotification when completed successfully
    // test('updateNotification return true when completed succefully', () async {
    //   when(client!.put(
    //     Uri.parse(EndPoints.notificaions + mockId),
    //     headers: anyNamed('headers'),
    //     body: anyNamed("body")
    //   )).thenAnswer((_) async => http.Response('updated', 200));

    //   expect(
    //       await userNotificationDataProvider!
    //           .updateNotificaton(mockNotication, mockUserToken),
    //       "updated");
    // });

    // Testing updateNotification when completed with error
    // test('updateNotification throws Exception completed with error', ()  {
    //   when(client!.put(
    //     Uri.parse(EndPoints.notificaions + mockId),
    //     headers: anyNamed('headers'),
    //     body: anyNamed("body")
    //   )).thenAnswer((_) async => http.Response('Not Found', 404));

    //   expect(
    //        userNotificationDataProvider!
    //           .updateNotificaton(mockNotication, mockUserToken),
    //       throwsException);
    // });
  });
}
