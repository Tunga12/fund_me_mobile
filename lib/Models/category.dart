class Category {
  String? categoryID;
  String? categoryName;

  Category({
    this.categoryID,
    this.categoryName,
  });

  factory Category.fromJson(Map<String, dynamic> data) {
    String categoryID = data['_id'];
    String categoryName = data['name'];

    return Category(
      categoryID: categoryID,
      categoryName: categoryName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': categoryID,
      'name': categoryName,
    };
  }

  @override
  String toString() {
    return 'Category ( categoryID: $categoryID,categoryName: $categoryName,)';
  }
}
