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
  group('Testing createTeamMember', () {
    MockClient? client;
    TeamMemberDataProvider? teamMemberDataProvider;
    setUp(() {
      client = MockClient();
      teamMemberDataProvider = TeamMemberDataProvider(httpClient: client!);
    });

    // Testing createTeamMember when completed successfully
    test("createTeamMember returns true if completed successfully", () async {
      when(client!.post(
        Uri.parse(EndPoints.createTeamMember + mockId),
        headers: anyNamed("headers"),
        body: anyNamed("body")
      )).thenAnswer((_) async => http.Response("created", 201));

      expect(
          await teamMemberDataProvider!
              .createTeamMember(mockUser.email!, mockUserToken, mockId),
          "created");
    });

     // Testing createTeamMember when completed with error
    test("createTeamMember throws Exception if completed with error", () async {
      when(client!.post(
        Uri.parse(EndPoints.createTeamMember + mockId),
        headers: anyNamed("headers"),
        body: anyNamed("body")
      )).thenAnswer((_) async => http.Response("Not Found", 404));

      expect(
           teamMemberDataProvider!
              .createTeamMember(mockUser.email!, mockUserToken, mockId),
          throwsException);
    });
  });
}
