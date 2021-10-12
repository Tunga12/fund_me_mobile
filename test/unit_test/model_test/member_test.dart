import 'package:crowd_funding_app/Models/team_member.dart';
import 'package:crowd_funding_app/Models/total_raised.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([http.Client])
main() {
  group("[Member Model]", () {
    Member? _member;
    setUp(() {
      _member = Member(id: "1234567890m");
    });

    test('[Model] check individual values', () async {
      _member = Member(
        hasRaised: TotalRaised(birr: 0, dollar: 0),
        id: "1234567890m",
        shareCount: 52,
        userID: User(),
      );

      //Begin Test...
      expect(_member!.id, '1234567890m');
      expect(_member!.hasRaised, 30);
      expect(_member!.shareCount, 52);
      expect(_member!.userID.runtimeType, equals(User));
      

    });
  });
}
