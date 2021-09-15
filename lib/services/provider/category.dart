import 'dart:io';

import 'package:crowd_funding_app/Models/category.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/services/repository/category.dart';
import 'package:crowd_funding_app/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CategoryModel extends ChangeNotifier {
  CategoryRepository categoryRepository;
  CategoryModel({
    required this.categoryRepository,
  });

  Response _response =
      Response(status: ResponseStatus.LOADING, data: null, message: '');

  // get response
  Response get response => _response;

  // set response
  set response(Response response) {
    _response = response;
    notifyListeners();
  }

  // get all categories
  Future getAllCategories() async {
    try {
      List<Category> categories = await categoryRepository.getAllCategories();
      print('categories $categories');
      categories.insert(
        0,
        Category(categoryID: "0", categoryName: LocaleKeys.select_category_label_text.tr()),
      );
      response = Response(
          status: ResponseStatus.SUCCESS,
          data: categories,
          message: "successfully fetched");
    } on SocketException catch (e) {
     
      response = Response(
          status: ResponseStatus.CONNECTIONERROR,
          data: null,
          message: "No internet connection");
    } on FormatException catch (e) {
      print('Fundraise Error ${e.message}');
      response = Response(
          status: ResponseStatus.FORMATERROR,
          data: null,
          message: "Invalid response from the server");
    } catch (e) {
      print("Category error error ${e.toString()}");
    }
  }

  // TODO: get single category

  Future signOut() async {
    response =
        Response(data: null, status: ResponseStatus.LOADING, message: "");
  }
}
