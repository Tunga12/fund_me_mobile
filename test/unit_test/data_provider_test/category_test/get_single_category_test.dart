import 'package:crowd_funding_app/Models/category.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:crowd_funding_app/services/data_provider/category.dart';
import 'package:crowd_funding_app/services/data_provider/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../unit_test.mocks.dart';
import '../const_models/mock_category.dart';
import '../const_models/mock_user.dart';

@GenerateMocks([http.Client],)
main() {
  group('Testing get single category', () {
    MockClient? client;
    CategoryDataProvider? categoryDataProvider;
    setUp(() {
      client = MockClient();
      categoryDataProvider = CategoryDataProvider(httpClient: client!);
    });

    // testing getSingleCategory Method when completed with successfully
    test(
        "getSingleCategory return a category object when completed successfully",
        () async {
      when(client!.get(
        Uri.parse(EndPoints.categories + mockId),
      )).thenAnswer((_) async => http.Response(mockCategoryJson, 200));

      expect(await categoryDataProvider!.getSingleCategory(mockId),
          isA<Category>());
    });

    // testing getSingleCategory Method when completed with exception
    test("getSingleCategory throws exception when completed with exception",
        () async {
      when(client!.get(
        Uri.parse(EndPoints.categories + mockId),
      )).thenAnswer((_) async => http.Response("Not Found", 400));
      expect( categoryDataProvider!.getSingleCategory(mockId),
          throwsException);
    });
  });
}
