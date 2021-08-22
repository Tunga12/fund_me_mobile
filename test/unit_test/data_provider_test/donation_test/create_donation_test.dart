import 'package:crowd_funding_app/Models/donation.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:crowd_funding_app/services/data_provider/donation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../unit_test.mocks.dart';
import '../const_models/mock_donation.dart';
import '../const_models/mock_user.dart';

@GenerateMocks([http.Client])
main() {
  group('Testing createDonation Method', () {
    MockClient? client;
    DonationDataProvider? dataProvider;
    setUp(() {
      client = MockClient();
      dataProvider = DonationDataProvider(httpClient: client!);
    });

    // Testing createDonation method when succesfully completed;
    test("CreateDonation returns donation object when completed successfully",
        () async {
      when(client!.post(Uri.parse(EndPoints.createDonation + mockId),
              headers: anyNamed("headers"), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(mockDonationJson, 201));
      expect(
          await dataProvider!
              .createDonation(mockDonation, mockUserToken, mockId),
          isA<Donation>());
    });

    // Testing createDonation method when completed with exception
    test('CreateDonation throws exception when completed with exception', () {
      when(client!.post(
        Uri.parse(EndPoints.createDonation + mockId),
        headers: anyNamed("headers"),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response("Not Found", 404));

      expect(dataProvider!.createDonation(mockDonation, mockUserToken, mockId),
          throwsException);
    });
  });
}
