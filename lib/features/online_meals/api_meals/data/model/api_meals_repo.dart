class ApiMealsModel {
  final String id;
  final String name;
  final String thumbnail;

  ApiMealsModel({
    required this.id,
    required this.name,
    required this.thumbnail,
  });

  factory ApiMealsModel.fromJson(Map<String, dynamic> json) {
    return ApiMealsModel(
      id: json['idMeal'],
      name: json['strMeal'],
      thumbnail: json['strMealThumb'],
    );
  }
}
