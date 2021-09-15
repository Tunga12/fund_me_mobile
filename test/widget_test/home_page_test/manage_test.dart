import 'package:crowd_funding_app/Screens/manage.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:crowd_funding_app/services/data_provider/fundraiser.dart';
import 'package:crowd_funding_app/services/provider/fundraise.dart';
import 'package:crowd_funding_app/services/repository/fundraise.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../unit_test.mocks.dart';
import '../common/mock_fundraise.dart';
import '../common/wrapper.dart';

@GenerateMocks([http.Client])
void main() {
  group("Testing home body", () {
    MockClient? client;
    FundraiseDataProvider? _fundraiseDataProvider;
    setUp(() {
      client = MockClient();
      _fundraiseDataProvider = FundraiseDataProvider(httpClient: client!);
    });

    //
    testWidgets('Provider is not empty', (tester) async {
      final _providerKey = GlobalKey();
      final _childKey = GlobalKey();
      BuildContext? buildContext;
      FundraiseRepository _fundraiseRepository =
          FundraiseRepository(dataProvider: _fundraiseDataProvider!);
      when(client!.get(Uri.parse(EndPoints.popularFundraisers + "?page=0")))
          .thenAnswer((_) async => http.Response(mockHomeFundraisers, 200));
      await tester.pumpWidget(
        ChangeNotifierProvider<FundraiseModel>(
          key: _providerKey,
          create: (context) {
            buildContext = context;
            return FundraiseModel(
              fundraiseRepository: _fundraiseRepository,
            );
          },
          child: buildTestableWidget(
            Manage(
              key: _childKey,
            ),
          ),
        ),
      );
      await tester.pump(const Duration(minutes: 1));
      // Finder listView = find.byType(ListView);
      // await tester.fling(find.byType(ListView), Offset(0, -200), 3000);

      // expect(find.byIcon(Icons.ios_share), findsNothing);
      // expect(listView, findsOneWidget);
      expect(
          Provider.of<FundraiseModel>(_childKey.currentContext!, listen: false),
          isNotNull);
      // expect(
      //     Provider.of<FundraiseModel>(_childKey.currentContext!, listen: false)
      //         .response
      //         .status,
      //     ResponseStatus.SUCCESS);
    });

    testWidgets('Testing scrolling', (tester) async {
      final _providerKey = GlobalKey();
      final _childKey = GlobalKey();
      BuildContext? buildContext;
      FundraiseRepository _fundraiseRepository =
          FundraiseRepository(dataProvider: _fundraiseDataProvider!);
      when(client!.get(Uri.parse(EndPoints.popularFundraisers + "?page=0")))
          .thenAnswer((_) async => http.Response(mockHomeFundraisers, 200));
      await tester.pumpWidget(
        ChangeNotifierProvider<FundraiseModel>(
          key: _providerKey,
          create: (context) {
            buildContext = context;
            return FundraiseModel(
              fundraiseRepository: _fundraiseRepository,
            );
          },
          child: buildTestableWidget(
            Manage(
              key: _childKey,
            ),
          ),
        ),
      );

      await tester.pump(const Duration(minutes: 1));

      expect(find.byType(ListView), findsNothing);
    });
  });
}
