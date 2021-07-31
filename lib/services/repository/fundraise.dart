import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/services/data_provider/fundraiser.dart';

class FundraiseRepository {
  final FundraiseDataProvider dataProvider;

  FundraiseRepository({
    required this.dataProvider,
  });

  // creating a fundraise
  Future<void> createFundraise(Fundraise fundraise, String token) async {
    return await dataProvider.createFundraise(fundraise, token);
  }

  // Get popular fundraisers
  Future<HomeFundraise> getPopularFundraises() async {
    return await dataProvider.getPopularFundraises();
  }

  // Get single fundraise
  Future<Fundraise> getSingleFundraise(String id) async {
    return await dataProvider.getSingleFundraise(id);
  }

  // Update fundraise
  Future<Fundraise> updateFundraise(Fundraise fundraise, String token) async {
    return await dataProvider.updateFundraise(fundraise, token);
  }

  // delete fundraise
  Future<String> deleteFundraise(String id, String token) async {
    return await dataProvider.deleteFundraise(id, token);
  }

  // get all fundraises created by user
  Future<HomeFundraise> getUserFundaisers(String token, String userId) async {
    return await dataProvider.getUserFundaisers(token, userId);
  }
}
