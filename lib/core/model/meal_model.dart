import 'package:hive/hive.dart';
part 'meal_model.g.dart';

@HiveType(typeId: 0)
class MealModel extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int cookingTime;

  @HiveField(2)
  final String describtion;

  @HiveField(3)
  final String? imagePath;

  @HiveField(4)
  int? id;

  MealModel({
    required this.name,
    required this.cookingTime,
    required this.describtion,
    this.imagePath,
    this.id,
  });
    Map<String, dynamic> toMap() {
    return {
      'name': name,
      'cookingTime': cookingTime,
      'describtion': describtion,
      'imagePath': imagePath,
      'id': id,
    };
  }
  factory MealModel.fromMap(Map<String, dynamic> map) {
    return MealModel(
      name: map['name'],
      cookingTime: map['cookingTime'],
      describtion: map['describtion'],
      imagePath: map['imagePath'],
      id: map['id'],
    );
  }
}
