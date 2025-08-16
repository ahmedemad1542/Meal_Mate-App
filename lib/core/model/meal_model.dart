class MealModel {
  final int? id;
  final String name;
  final int cookingTime;
  final String describtion;
  final String? imagePath;

  MealModel({
    this.id,
    required this.name,
    required this.cookingTime,
    required this.describtion,
    this.imagePath
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'cookingTime': cookingTime,
      'describtion': describtion,
      'imagePath' : imagePath,
    };
  }

  factory MealModel.fromMap(Map<String, dynamic> map) {
    return MealModel(
      id: map['id'],
      name: map['name'],
      cookingTime: map['cookingTime'],
      describtion: map['describtion'],
      imagePath :  map['imagePath']
    );
  }
}
