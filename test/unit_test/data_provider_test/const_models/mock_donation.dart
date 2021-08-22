import 'package:crowd_funding_app/Models/donation.dart';

import 'mock_user.dart';

final mockDonationJson =
    '{"_id": "123456789","userId": "1234567", "memberId": "123456789", "amount": 30,"comment": "Mock comment", "date": "2021-01-26","isDeleted": false,"isAnonymous":false}';

final mockDonation = Donation(
  id: "1234567",
  amount: 30,
  comment: "mock comment",
  date: DateTime.now(),
  isAnonymous: false,
  isDeleted: false,
  memberID: "123456789",
  tip: 0.3,
  userID: mockUser
);
