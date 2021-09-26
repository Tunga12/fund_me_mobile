import 'dart:async';

import 'package:crowd_funding_app/Models/notification.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:rxdart/rxdart.dart';

abstract class NotificationProvider {
  void dispose();
}

class NotificationRealTimeModel extends NotificationProvider {
  NotificationRealTimeModel._privateConstructor();
  static final NotificationRealTimeModel _instance =
      NotificationRealTimeModel._privateConstructor();
  factory NotificationRealTimeModel() {
    return _instance;
  }

  StreamController<UserNotification> _newNotifications = BehaviorSubject();
  StreamController<int> _unreadNotificationCount = BehaviorSubject();

  // add new notifications
  void Function(UserNotification notification) get addNewNotification =>
      _newNotifications.sink.add;

  // get new notifications
  Stream<UserNotification> get getNewNotifications => _newNotifications.stream;

  // add unread notifications count
  void Function(int unreadNotificationsCount) get addUnreadNotificationCount =>
      _unreadNotificationCount.sink.add;

  // get unread notificatons count
  Stream<int> get getUnreadNotificationsCount =>
      _unreadNotificationCount.stream;

  IO.Socket? socket;

  createConnection(String token) {
    final url = EndPoints.baseURL + ':5000?token=$token';
    print("url is $url");
    socket = IO.io(
      url,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableForceNew()
          .enableForceNewConnection()
          .build(),
    );

    print("connecting");
    socket!.onConnect((_) {
      print('connect');
      print("It connected");
    });

    // viewed notifications
    socket!.on('viewed notification', (data) {
      print("viewd notification is listend");
      print(data);

      UserNotification _notification = UserNotification.fromJson(data);
      // if (!_newNotifications.isClosed) addNewNotification(_notification);
    });

    // new notifications
    socket!.on('new notification', (data) {
      print('new notification is listened');
      print(data);
      // final responseData = jsonDecode(data);
      UserNotification _notification = UserNotification.fromJson(data);

      if (!_newNotifications.isClosed) addNewNotification(_notification);
    });

    // viewed
    socket!.on('unread notification count', (data) {
      print("unread count is about");
      print(data);
      if (!_unreadNotificationCount.isClosed) addUnreadNotificationCount(data);
    });
    socket!.onError((data) => print("Error happend error"));
  }

  @override
  void dispose() {
    _unreadNotificationCount.close();
    socket!.destroy();
    socket!.disconnect();
    socket!.clearListeners();
    socket!.close();
    socket!.dispose();

    print("connection disposed2");
    // _viewedNotifications.close();
  }

  void closeCountConnection() {
    _unreadNotificationCount.close();
  }

  void closeNotification() {
    _newNotifications.close();
  }
}
