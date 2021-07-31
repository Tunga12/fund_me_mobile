import 'package:crowd_funding_app/Models/notification.dart';
import 'package:crowd_funding_app/services/data_provider/notification.dart';

class UserNotificationRepository {
  final UserNotificationDataProvider dataProvider;
  UserNotificationRepository({required this.dataProvider});

  // Getting all notifications for a single user.
  Future<List<UserNotification>> getUserNotifications(String token) async {
    return await dataProvider.getUserNotifications(token);
  }

  // Delete notification
  Future<void> deleteNotification(String id) async {
    return await dataProvider.deleteNotification(id);
  }
}
