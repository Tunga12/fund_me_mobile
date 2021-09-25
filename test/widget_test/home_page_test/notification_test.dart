import 'package:crowd_funding_app/Screens/loading_screen.dart';
import 'package:crowd_funding_app/Screens/notification.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:crowd_funding_app/services/data_provider/notification.dart';
import 'package:crowd_funding_app/services/provider/notification.dart';
import 'package:crowd_funding_app/services/repository/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../unit_test.mocks.dart';
import '../common/mock_fundraise.dart';
import '../common/wrapper.dart';

@GenerateMocks([http.Client])
void main() {
  group("Testing Notification page", () {
    MockClient? client;
    UserNotificationDataProvider? notificationDataProvider;
    setUp(() {
      client = MockClient();
      notificationDataProvider =
          UserNotificationDataProvider(httpClient: client!);
    });

    testWidgets('[Provider] is provider successsfull', (tester) async {
      final _providerKey = GlobalKey();
      final _childKey = GlobalKey();
      BuildContext? buildContext;

      UserNotificationRepository _userNotificationRepository =
          UserNotificationRepository(dataProvider: notificationDataProvider!);
      when(
        client!.get(Uri.parse(EndPoints.notificaions),
            headers: anyNamed('headers')),
      ).thenAnswer((_) async => http.Response(mockUserNotifications, 200));
      await tester.pumpWidget(
        ChangeNotifierProvider<UserNotificationModel>(
          key: _providerKey,
          create: (context) {
            buildContext = context;
            return UserNotificationModel(
              notificationRepository: _userNotificationRepository,
            );
          },
          child: buildTestableWidget(
            Notifications(
              key: _childKey,
            ),
          ),
        ),
      );
      // await tester.pumpAndSettle(const Duration(seconds: 60));
      await tester.pump(const Duration(seconds: 60));
      expect(find.byType(LoadingScreen), findsOneWidget);
      expect(
          Provider.of<UserNotificationModel>(_childKey.currentContext!,
              listen: false),
          isNotNull);
      // expect(
      //     Provider.of<UserNotificationModel>(_childKey.currentContext!,
      //         listen: false).response.status,
      //     ResponseStatus.SUCCESS);
    });

    // Testing if listview has child
    testWidgets('[Provider] Listview has child', (tester) async {
      final _providerKey = GlobalKey();
      final _childKey = GlobalKey();
      BuildContext? buildContext;
      UserNotificationRepository _userNotificationRepository =
          UserNotificationRepository(dataProvider: notificationDataProvider!);
      when(
        client!.get(Uri.parse(EndPoints.notificaions),
            headers: anyNamed('headers')),
      ).thenAnswer((_) async => http.Response(mockUserNotifications, 200));
      await tester.pumpWidget(
        ChangeNotifierProvider<UserNotificationModel>(
          key: _providerKey,
          create: (context) {
            buildContext = context;
            return UserNotificationModel(
              notificationRepository: _userNotificationRepository,
            );
          },
          child: buildTestableWidget(
            Notifications(
              key: _childKey,
            ),
          ),
        ),
      );
      await tester.pump(const Duration(seconds: 10));
      // expect(find.byType(ListView), findsOneWidget);
      // await tester.drag(find.byType(ListView), Offset(0.0, -500));
      // expect(find.byType(NotficationItem), findsOneWidget);
    });
  });
}
