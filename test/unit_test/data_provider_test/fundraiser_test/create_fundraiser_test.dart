import 'package:crowd_funding_app/Models/donation.dart';
import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:crowd_funding_app/services/data_provider/donation.dart';
import 'package:crowd_funding_app/services/data_provider/fundraiser.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../unit_test.mocks.dart';
import '../const_models/mock_donation.dart';
import '../const_models/mock_user.dart';

@GenerateMocks([http.Client])
main() {
  group('Testing createFundraiser Method', () {
    MockClient? client;
    FundraiseDataProvider? fundraiseDataProvider;
    setUp(() {
      client = MockClient();
      fundraiseDataProvider = FundraiseDataProvider(httpClient: client!);
    });

    // Testing createFundraiser method when completed completely
    // test("createFundraiser return Fundraise object when completed successfully", () async{

    //   when(client.post(url))
    // })
  });
}
