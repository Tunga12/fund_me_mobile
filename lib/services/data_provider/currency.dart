import 'dart:convert';

import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:http/http.dart' as http;

class CurrencyDataProvider {
  final http.Client httpClient;
  CurrencyDataProvider({required this.httpClient});

  Future<double> getCurrencyRate() async {
    final response = await httpClient.get(Uri.parse(EndPoints.currencyURL));

    if (response.statusCode == 200) {
      Map<String, dynamic> _data = jsonDecode(response.body);

      return _data['USD_ETB'];
    } else {
      throw Exception('error occured');
    }
  }
}
