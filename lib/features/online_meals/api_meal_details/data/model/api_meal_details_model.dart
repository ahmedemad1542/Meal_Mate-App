class ApiMealDetailModel {
  final String id;
  final String name;
  final String instructions;
  final String thumbnail;

  ApiMealDetailModel({
    required this.id,
    required this.name,
    required this.instructions,
    required this.thumbnail,
  });

  factory ApiMealDetailModel.fromJson(Map<String, dynamic> json) {
    return ApiMealDetailModel(
      id: json['idMeal'],
      name: json['strMeal'],
      instructions: json['strInstructions'],
      thumbnail: json['strMealThumb'],
    );
  }
}
