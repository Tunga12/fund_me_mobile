import 'dart:io';

import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/services/data_provider/fundraiser.dart';

class FundraiseRepository {
  final FundraiseDataProvider dataProvider;

  FundraiseRepository({
    required this.dataProvider,
  });

  // creating a fundraise
  Future<bool> createFundraise(
      Fundraise fundraise, String token, File image) async {
    return await dataProvider.createFundraise(fundraise, token, image);
  }

  // Get popular fundraisers
  Future<HomeFundraise> getPopularFundraises(int page) async {
    return await dataProvider.getPopularFundraises(page);
  }

  // Get single fundraise
  Future<Fundraise> getSingleFundraise(String id) async {
    return await dataProvider.getSingleFundraise(id);
  }

  // Update fundraise
  Future<bool> updateFundraise(Fundraise fundraise, String token,
      {File? image}) async {
    return await dataProvider.updateFundraise(fundraise, token, image: image);
  }

  // delete fundraise
  Future<String> deleteFundraise(String id, String token) async {
    return await dataProvider.deleteFundraise(id, token);
  }

  // get all fundraises created by user
  Future<HomeFundraise> getUserFundaisers(String token, int page) async {
    return await dataProvider.getUserFundaisers(token, page);
  }

  // get all fundraises created by user
  Future<HomeFundraise> getMemberFundrases(String token, int page) async {
    return await dataProvider.getMemberFundrases(token, page);
  }

  // search fundraise
  Future<HomeFundraise> searchFundraises(String title, int pageNumber) async {
    return await dataProvider.searchFundraises(title, pageNumber);
  }
}
