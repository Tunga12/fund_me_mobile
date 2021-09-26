import 'package:crowd_funding_app/Models/category.dart';
import 'package:crowd_funding_app/Models/donation.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([http.Client])
main() {
  group("[Donation Model]", () {
    Donation? _donationModel;
    setUp(() {
      _donationModel = Donation(amount: 30);
    });

    // Testing Donation model
    test('[Model] check individual values', () async {
      _donationModel = Donation(
        amount: 30,
        comment: "Mock comment",
        date: "",
        id: '123456789v',
        isAnonymous: false,
        isDeleted: false,
        memberID: "123456789a",
        tip: 2.3,
        userID: User(firstName: "MockFirstName", lastName: "MockLastName"),
      );

      // BEGIN TEST...
      expect(_donationModel!.amount, 30);

      expect(_donationModel!.comment.runtimeType, equals(String));

      expect(_donationModel!.date, isNotNull);

      expect(_donationModel!.id, isNotNull);

      expect(_donationModel!.isAnonymous, isFalse);

      expect(_donationModel!.isDeleted, isFalse);

      expect(_donationModel!.memberID, isNotEmpty);

      expect(_donationModel!.tip.runtimeType, equals(double));

      expect(_donationModel!.userID.runtimeType, equals(User));
      
    });
  });
}
