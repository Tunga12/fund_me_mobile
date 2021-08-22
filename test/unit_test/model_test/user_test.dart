import 'package:crowd_funding_app/Models/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([http.Client])
main() {
  group("[User Model]", () {
    User? _user;
    setUp(() {
      _user = User(firstName: "MockFirstName");
    });

    //Testing Update
    test('[User] check individual values', () async {
      _user = User(
        firstName: "MockFirstName",
        lastName: "MockLastName",
        email: "mock@example.com",
        emailNotification: false,
        id: "123456789p",
        isAdmin: false,
        isDeactivated: false,
        password: "wxercvty",
        paymentMethods: "",
        phoneNumber: '+251911223344',
      );

      //Begin Test...
      expect(_user!.firstName, "MockFirstName");
      expect(_user!.lastName, "MockLastName");
      expect(_user!.email, endsWith('.com'));
      expect(_user!.emailNotification, isFalse);
      expect(_user!.id, endsWith('89p'));
      expect(_user!.isAdmin, isFalse);
      expect(_user!.isDeactivated, isFalse);
      expect(_user!.password, 'wxercvty');
      expect(_user!.phoneNumber, '+251911223344');
    });
  });
}
