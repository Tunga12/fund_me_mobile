import 'package:crowd_funding_app/Models/team_member.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([http.Client])
main() {
  group("[TeamMember Model]", () {
    TeamMember? _teamMember;
    setUp(() {
      _teamMember = TeamMember(status: "Pending");
    });

    // Testing TeamMember
    test('[Model] check individual values', () async {
      _teamMember = TeamMember(
        status: "Pending",
        member: Member(
          hasRaised: 10,
          id: "123456789p",
          shareCount: 25,
          userID: User(),
        ),
      );
      // BEGIN Test...
      expect(_teamMember!.status, "Pending");
      expect(_teamMember!.member.runtimeType, equals(Member));
    });
  });
}
