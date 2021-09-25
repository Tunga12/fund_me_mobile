import 'package:crowd_funding_app/services/data_provider/currency.dart';

class CurrencyRepository {
  final CurrencyDataProvider dataProvider;
  CurrencyRepository({required this.dataProvider});

  Future<double> getCurrencyRate() async {
    return await dataProvider.getCurrencyRate();
  }
}