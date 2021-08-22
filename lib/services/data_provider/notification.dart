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
    final response = await httpClient.get(
      Uri.parse(
        EndPoints.notificaions + "user",
      ),
      headers: <String, String>{'x-auth-token': token},
    );
 
    if (response.statusCode == 200) {
      final notifications = jsonDecode(response.body) as List;

      return notifications
          .map((notification) => UserNotification.fromJson(notification))
          .toList();
    } else {
      throw Exception("Failed to fetch user notifications");
    }
  }

  // update Notification mark as viewed
  Future<String> updateNotificaton(
      UserNotification notification, String token) async {
    final response = await httpClient.put(
      Uri.parse(EndPoints.notificaions + notification.id!),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token
      },
    );
    if (response.statusCode == 200) {
      return "updated";
    } else {
      throw Exception(response.body);
    }
  }

  // Delete notification
  Future<String> deleteNotification(String id, String token) async {
    final response = await httpClient.delete(
        Uri.parse(
          EndPoints.notificaions + id,
        ),
        headers: <String, String>{'x-auth-token': token});
    if (response.statusCode == 200) {
      return 'deleted';
    } else {
      throw Exception(response.body);
    }
  }
}
