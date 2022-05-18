import 'package:crowd_funding_app/Screens/create_fundraiser_page_one.dart';
import 'package:crowd_funding_app/Screens/loading_screen.dart';
import 'package:crowd_funding_app/services/data_provider/category.dart';
import 'package:crowd_funding_app/services/provider/category.dart';
import 'package:crowd_funding_app/services/repository/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../../unit_test.mocks.dart';
import '../common/wrapper.dart';

@GenerateMocks([http.Client])
void main() {
  group('Testing create', () {
    MockClient? client;
    CategoryDataProvider? categoryDataProvider;
    setUp(() {
      client = MockClient();
      categoryDataProvider = CategoryDataProvider(httpClient: client!);
    });

    // test all widgets are renderd
    testWidgets('All widgets are renderd', (tester) async {
      CategoryRepository categoryRepository =
          CategoryRepository(dataProvider: categoryDataProvider!);

      Map<String, dynamic> _fundraiseInfo = {};
      CreateFundraiserPageOne createFundraiserPageOne = CreateFundraiserPageOne(
        fundraiseInfo: _fundraiseInfo,
      );

      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (context) =>
              CategoryModel(categoryRepository: categoryRepository),
          child: buildTestableWidget(createFundraiserPageOne),
        ),
      );

      expect(find.byType(LoadingScreen), findsNWidgets(1));
    });
  });
}
