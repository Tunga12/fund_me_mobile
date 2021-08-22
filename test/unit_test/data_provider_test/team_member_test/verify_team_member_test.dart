import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:crowd_funding_app/services/data_provider/team_member.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../unit_test.mocks.dart';
import '../const_models/mock_user.dart';

@GenerateMocks([http.Client])
main() {
  group('Testing verifyTeamMember', () {
    MockClient? client;
    TeamMemberDataProvider? teamMemberDataProvider;
    setUp(() {
      client = MockClient();
      teamMemberDataProvider = TeamMemberDataProvider(httpClient: client!);
    });

    // Testing verifyTeamMember when completed successfully
    test("verifyTeamMember returns verified String if completed successfully", () async {
      when(client!.put(Uri.parse(EndPoints.verifyInvitaion + mockId),
              headers: anyNamed("headers"), body: anyNamed("body")))
          .thenAnswer((_) async => http.Response("verified", 200));

      expect(
          await teamMemberDataProvider!
              .verifyTeamMember(true, mockUserToken, mockId),
          "verified");
    });

    // Testing verifyTeamMember when completed with error
    test("verifyTeamMember throws Exception if completed with error", () async {
      when(client!.put(Uri.parse(EndPoints.verifyInvitaion + mockId),
              headers: anyNamed("headers"), body: anyNamed("body")))
          .thenAnswer((_) async => http.Response("Not Found", 404));

      expect(
          teamMemberDataProvider!.verifyTeamMember(true, mockUserToken, mockId),
          throwsException);
    });
  });
}
