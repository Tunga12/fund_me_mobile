import 'package:crowd_funding_app/Models/notification.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([http.Client])
main() {
  group("[UserNotification Model]", () {
    UserNotification? _userNotification;
    setUp(() {
      _userNotification = UserNotification(title: "Mock Notification");
    });

    // Testing UserNotification
    test('[Model] check individual values', () async {
      _userNotification = UserNotification(
        title: "Mock Notification",
        content: "Mock Content",
        date: "2021-09-09",
        fundraiser: "123456789m",
        id: "1234567890m",
        recipients: ['123456789o', '123456789p'],
        type: "Donation",
        viewed: ['123456789o', '123456789p'],
      );

      // BEGIN TEST..
      expect(_userNotification!.title, "Mock Notification");
      expect(_userNotification!.content, startsWith("Mock"));
      expect(_userNotification!.date, startsWith("2021"));
      expect(_userNotification!.fundraiser, isNotEmpty);
      expect(_userNotification!.id, isNotEmpty);
      expect(_userNotification!.recipients, isA<List<String>>());
      expect(_userNotification!.type, startsWith("Don"));
      expect(_userNotification!.viewed, isA<List<String>>());
    });
  });
}
