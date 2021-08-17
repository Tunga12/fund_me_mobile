import 'package:crowd_funding_app/Models/donation.dart';
import 'package:crowd_funding_app/services/data_provider/donation.dart';

class DonationRepository {
  final DonationDataProvider dataProvider;
  DonationRepository({required this.dataProvider});

  // create donation
  Future<Donation> createDonation(
      Donation donation, String token, String fundraiserId) async {
    return await dataProvider.createDonation(donation, token, fundraiserId);
  }

  // pay with paypal
  Future<String> payWithPayPal(
      Donation donation, String token, String fundraiserId) async {
    return await dataProvider.payWithPayPal(donation, token, fundraiserId);
  }
}
