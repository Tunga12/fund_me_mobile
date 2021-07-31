import 'package:crowd_funding_app/Models/category.dart';
import 'package:crowd_funding_app/services/data_provider/category.dart';

class CategoryRepository {
  final CategoryDataProvider dataProvider;
  CategoryRepository({
    required this.dataProvider,
  });

  // get all categories available
  Future<List<Category>> getAllCategories() async {
    return await dataProvider.getAllCategories();
  }

  // get a single category by id
  Future<Category> getSingleCategory(String id) async {
    return await dataProvider.getSingleCategory(id);
  }
}
