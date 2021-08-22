import 'dart:convert';

import 'package:crowd_funding_app/Models/category.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:http/http.dart' as http;

class CategoryDataProvider {
  final http.Client httpClient;
  CategoryDataProvider({
    required this.httpClient,
  });

  // get all categories available
  Future<List<Category>> getAllCategories() async {
    final response = await httpClient.get(
      Uri.parse(EndPoints.categories),
    );

    if (response.statusCode == 200) {
      // print("response $P");
      final _allCategories = jsonDecode(response.body);
      final allCategories = _allCategories as List;

      return allCategories
          .map((category) => Category.fromJson(category))
          .toList();
    } else {
      throw Exception("${response.body}");
    }
  }

  // get a single category by id
  Future<Category> getSingleCategory(String id) async {
    final response = await httpClient.get(
      Uri.parse(EndPoints.categories + id),
    );

    if (response.statusCode == 200) {
      final category = jsonDecode(response.body) as Map<String, dynamic>;
      return Category.fromJson(category);
    } else {
      throw Exception('Failed to fetch single category');
    }
  }
}
