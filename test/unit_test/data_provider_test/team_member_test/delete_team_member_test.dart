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
  group('Testing deleteTeamMember', () {
    MockClient? client;
    TeamMemberDataProvider? teamMemberDataProvider;

    setUp(() {
      client = MockClient();
      teamMemberDataProvider = TeamMemberDataProvider(httpClient: client!);
    });

    // Testing deleteTeamMember when completed successfully
    test("deleteTeamMember returns true if completed successfully", () async {
      when(client!.delete(Uri.parse(EndPoints.teamMember + mockId),
              headers: anyNamed("headers"), body: anyNamed("body")))
          .thenAnswer((_) async => http.Response('deleted', 200));

      expect(await teamMemberDataProvider!.deleteMember(mockUserToken, mockId),
          'deleted');
    });

    // Testing deleteTeamMember when completed with error
    test("deleteTeamMember throws Exception if completed with error", () async {
      when(client!.delete(Uri.parse(EndPoints.teamMember + mockId),
              headers: anyNamed("headers"), body: anyNamed("body")))
          .thenAnswer((_) async => http.Response("Not Found",404));
      expect(teamMemberDataProvider!.deleteMember(mockUserToken, mockId),
          throwsException);
    });
  });
}
