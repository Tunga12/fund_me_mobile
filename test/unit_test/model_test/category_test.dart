import 'package:crowd_funding_app/Models/category.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;


@GenerateMocks([http.Client])
main() {
  group("[Category Model]", () {
    Category? _categoryModel;
    setUp(() {
      _categoryModel = Category(categoryName: "Creative");
    });

    // Testing category Model
    test('[Model] check individual values', () async {
      _categoryModel = Category(
        categoryID: '123456789',
        categoryName: "Creative",
        
      );

      // BEGIN TEST...
      expect(_categoryModel!.categoryName, 'Creative');
      expect(_categoryModel!.categoryID, isNotNull);
    });
  });
}
