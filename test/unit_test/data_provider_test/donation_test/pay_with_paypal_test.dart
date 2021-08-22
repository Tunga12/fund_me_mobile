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
  group('Testing payWithPaypal Method', () {
    MockClient? client;
    DonationDataProvider? dataProvider;
    setUp(() {
      client = MockClient();
      dataProvider = DonationDataProvider(httpClient: client!);
    });

    // Testing paymentWithpaypal when completed successfully
    test("payWithPayPal return a url string when completed successfully", ()async {
      when(client!.post(
        Uri.parse(EndPoints.paypalUrl + mockId),
        headers: anyNamed("headers"),
        body: anyNamed("body")
      )).thenAnswer((_) async => http.Response("", 302, headers: {"location":'http://'}));

      expect(await dataProvider!.payWithPayPal(mockDonation, mockUserToken, mockId), "http://");
    });

    // Testing paymentWithpaypal when completed with exception
    test("payWithPayPal throws Exception when completed with exception", () {
      when(client!.post(
        Uri.parse(EndPoints.paypalUrl + mockId),
        headers: anyNamed("headers"),
        body: anyNamed("body")
      )).thenAnswer((_) async => http.Response("Not Found", 404));

      expect( dataProvider!.payWithPayPal(mockDonation, mockUserToken, mockId), throwsException);
    });
  });
}
