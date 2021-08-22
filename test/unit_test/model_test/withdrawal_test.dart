import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/Models/withdrawal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([http.Client])
main() {
  group("[Withdrawal Model]", () {
    Withdrwal? _withdrwal;
    setUp(() {
      _withdrwal = Withdrwal(
        bankAccountNo: '123456789',
        bankName: "MOCKCBE",
        isOrganizer: true,
        beneficiary: "1234567890p",
      );
    });

    //Testing Withdrawal model
    test('[Withdrawal] check individual values', () async {
      

      // Begin Test...
      expect(_withdrwal!.bankName, 'MOCKCBE');
      expect(_withdrwal!.bankAccountNo, startsWith("123"));
      expect(_withdrwal!.beneficiary, isNotEmpty);
      expect(_withdrwal!.isOrganizer, isTrue);
    });
  });
}
