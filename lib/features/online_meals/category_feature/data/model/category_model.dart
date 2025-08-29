class CategoryModel {
  final String id;
  final String name;
  final String thumbnail;

  CategoryModel({
    required this.id,
    required this.name,
    required this.thumbnail,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['idCategory'],
      name: json['strCategory'],
      thumbnail: json['strCategoryThumb'],
    );
  }
}
