import 'dart:convert';

import 'package:crowd_funding_app/Models/help.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:http/http.dart' as http;

class HelpDataProvider {
  final http.Client httpClient;

  HelpDataProvider({
    required this.httpClient,
  });

  Future<List<HelpDataModel>> getHelp() async {
    final response = await http.get(Uri.parse(EndPoints.helpURL));

    if (response.statusCode == 200) {
      List _jsonResponse = jsonDecode(response.body) as List;
      return _jsonResponse.map((help) => HelpDataModel.fromJson(help)).toList();
    } else {
      throw Exception(response.body);
    }
  }
}
