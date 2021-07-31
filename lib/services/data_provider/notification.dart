import 'dart:convert';

import 'package:crowd_funding_app/Models/notification.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:http/http.dart' as http;

class UserNotificationDataProvider {
  final http.Client httpClient;

  UserNotificationDataProvider({
    required this.httpClient,
  });

  // Getting all notifications for a single user.
  Future<List<UserNotification>> getUserNotifications(String token) async {
    print(token);
    final response = await httpClient.get(
        Uri.parse(
          EndPoints.notificaions + "user",
        ),
        headers: <String, String>{'x-auth-token': token});

    if (response.statusCode == 200) {
      final notifications = jsonDecode(response.body) as List;
      print("notifications http $notifications");

      return notifications
          .map((notification) => UserNotification.fromJson(notification))
          .toList();
    } else {
      throw Exception("Failed to fetch user notifications");
    }
  }

  // Delete notification
  Future<void> deleteNotification(String id) async {
    final response = await httpClient.delete(
      Uri.parse(
        EndPoints.notificaions + id,
      ),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete data');
    }
  }
}
