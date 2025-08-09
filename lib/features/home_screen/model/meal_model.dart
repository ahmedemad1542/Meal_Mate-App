class MealModel {
  final int? id;
  final String name;
  final double cookingTime;
  final String describtion;

  MealModel({
    this.id,
    required this.name,
    required this.cookingTime,
    required this.describtion,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'cookingTime': cookingTime,
      'describtion': describtion,
    };
  }

  factory MealModel.fromMap(Map<String, dynamic> map) {
    return MealModel(
      id: map['id'],
      name: map['name'],
      cookingTime: map['cookingTime'],
      describtion: map['describtion'],
    );
  }
}
