import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:crowd_funding_app/services/data_provider/fundraiser.dart';
import 'package:crowd_funding_app/services/provider/fundraise.dart';
import 'package:crowd_funding_app/services/repository/fundraise.dart';
import 'package:crowd_funding_app/widgets/campaign_card.dart';
import 'package:crowd_funding_app/widgets/fundraiser_card.dart';
import 'package:crowd_funding_app/widgets/home_body.dart';
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

    // Testing if scrolling
    testWidgets("Testing scrolling", (tester) async {
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
            HomeBody(
              key: _childKey,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(minutes: 1));
      Finder listView = find.byType(ListView);
      await tester.fling(find.byType(ListView), Offset(0, -200), 3000);
      
      expect(find.byIcon(Icons.ios_share), findsNothing);
      expect(listView, findsOneWidget);
      expect(
          Provider.of<FundraiseModel>(_childKey.currentContext!, listen: false),
          isNotNull);
      expect(
          Provider.of<FundraiseModel>(_childKey.currentContext!, listen: false)
              .response
              .status,
          ResponseStatus.SUCCESS);
    });

    testWidgets('testing if CampaignCard shows up', (tester) async {
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
            HomeBody(
              key: _childKey,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle(const Duration(minutes: 1));

      expect(find.byType(Scrollbar), findsNWidgets(1));
      expect(find.byKey(Key('home_body_first_list_view')), findsOneWidget);
      expect(find.byKey(Key("test_container")), findsOneWidget);
      await tester.drag(find.byKey(Key('home_body_first_list_view')), Offset(0.0, -500));
      await tester.pump();
      expect(find.byType(CampaignCard, skipOffstage: false), findsOneWidget);
     
    });
  });
}
