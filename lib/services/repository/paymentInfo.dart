import 'package:crowd_funding_app/Models/paymentInfo.dart';
import 'package:crowd_funding_app/services/data_provider/paymentInfo.dart';

class PaymentInfoRepository {
  final PaymentInfoDataProvider dataProvider = PaymentInfoDataProvider();

  // search shortcode
  Future<PaymentInfo> searchShortcode(String shortcode) async {
    return await dataProvider.searchShortcode(shortcode);
  }

  // get paymentInfo by id
  Future<PaymentInfo> getPaymentInfo(String id) async {
    return await dataProvider.getPaymentInfo(id);
  }
}
