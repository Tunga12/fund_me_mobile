import 'package:crowd_funding_app/Screens/home_page.dart';
import 'package:crowd_funding_app/services/data_provider/fundraiser.dart';
import 'package:crowd_funding_app/services/provider/fundraise.dart';
import 'package:crowd_funding_app/services/repository/fundraise.dart';
import 'package:crowd_funding_app/widgets/home_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import '../unit_test.mocks.dart';
import 'common/wrapper.dart';

void main() {
  group("Testing hom_page", () {
    MockClient? client;
    setUp(() {
      client = MockClient();
    });
    testWidgets('homepage has a body', (WidgetTester tester) async {
      // HomePage homePage = HomePage();
      // final _providerKey = GlobalKey();
      // final _childKey = GlobalKey();
      // BuildContext? context;
      // FundraiseRepository fundraiseRepository = FundraiseRepository(
      //     dataProvider: FundraiseDataProvider(httpClient: client!));

      // await tester.pumpWidget(
      //   ChangeNotifierProvider(
      //     key: _providerKey,
      //     create: (context) => FundraiseModel(
      //       fundraiseRepository: fundraiseRepository,
      //     ),
      //     child: buildTestableWidget(homePage),
      //   ),
      // );
      // await tester.pumpAndSettle(const Duration(minutes: 1));
      // final bodyFinder = find.byType(HomeBody);

      // expect(bodyFinder, findsOneWidget);
    });
  });
}
