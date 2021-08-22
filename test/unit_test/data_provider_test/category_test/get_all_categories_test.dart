import 'package:crowd_funding_app/Models/category.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:crowd_funding_app/services/data_provider/category.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../unit_test.mocks.dart';
import '../const_models/mock_category.dart';

@GenerateMocks([http.Client])
main() {
  group('Testing get all categories', () {
    MockClient? client;
    CategoryDataProvider? categoryDataProvider;
    setUp(() {
      client = MockClient();
      categoryDataProvider = CategoryDataProvider(httpClient: client!);
    });

    // test getAllCategories method when the http call completed successfully
    test('getAllCategories return list of categories if completed successfully',
        () async {
      when(client!.get(
        Uri.parse(EndPoints.categories),
      )).thenAnswer(
          (realInvocation) async => http.Response(mockCategoriesJson, 200));

      expect(await categoryDataProvider!.getAllCategories(),
          isA<List<Category>>());
    });
  });
}
