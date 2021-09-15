import 'package:crowd_funding_app/Models/user.dart';

final mockUser = User(
  email: "mock@example.com",
  firstName: "Mock",
  lastName: "Mock",
  password: "123456789",
  phoneNumber: "09111223344",
);

final mockUserToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6Ikp";

final mocksignInuser = User(
  email: "mock@example.com",
  password: "123456789",
);

final mockUserJson = '''{"email": "mock@example.com",
    "firstName": "Mock",
    "lastName": "Mock",
    "password": "123456789",
    "phoneNumber": "09111223344",
    "_id":"eyJhbGciOiJIUzI1NiIsInR5cCI6Ikp",
    "paymentMethods": "",
    "emailNotification":false,
    "isDeactivated": false,
    "isAdmin": false}
    ''';

final mockId = '6107eb047aed78001585293d';

final mockCompleteUser = User(
  email: "mock@example.com",
  firstName: "Mock",
  lastName: "Mock",
  password: "123456789",
  phoneNumber: "09111223344",
  emailNotification: false,
  id: '6107eb047aed78001585293d',
  isAdmin: false,
  isDeactivated: false,
  paymentMethods: 'none',
  
);
