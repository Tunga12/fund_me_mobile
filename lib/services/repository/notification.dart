import 'package:crowd_funding_app/Models/notification.dart';
import 'package:crowd_funding_app/services/data_provider/notification.dart';

class UserNotificationRepository {
  final UserNotificationDataProvider dataProvider;
  UserNotificationRepository({required this.dataProvider});

  // Getting all notifications for a single user.
  Future<List<UserNotification>> getUserNotifications(String token) async {
    return await dataProvider.getUserNotifications(token);
  }

  // update notification mark as viewd
  Future<bool> updateNotificationi(
      UserNotification notification, String token) async {
    return await dataProvider.updateNotificaton(notification, token);
  }

  // Delete notification
  Future<bool> deleteNotification(String id, String token) async {
    return await dataProvider.deleteNotification(id, token);
  }
}
