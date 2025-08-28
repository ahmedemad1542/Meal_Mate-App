import 'package:hive/hive.dart';
part 'meal_model.g.dart';

@HiveType(typeId: 0)
class MealModel extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int cookingTime;

  @HiveField(2)
  final String description; 

  @HiveField(3)
  final String? imagePath;

  @HiveField(4)
  int? id;

  @HiveField(5)
  final double rating;

  MealModel({
    required this.name,
    required this.cookingTime,
    required this.description, 
    this.imagePath,
    this.id,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'cookingTime': cookingTime,
      'description': description, 
      'imagePath': imagePath,
      'id': id,
      'rating': rating, 
    };
  }

  factory MealModel.fromMap(Map<String, dynamic> map) {
    return MealModel(
      name: map['name'],
      cookingTime: map['cookingTime'],
      description: map['description'], 
      imagePath: map['imagePath'],
      id: map['id'],
      rating: map['rating'] ?? 0.0,
    );
  }

  // for update method (optional)
  MealModel copyWith({
    String? name,
    int? cookingTime,
    String? description,
    String? imagePath,
    int? id,
    double? rating,
  }) {
    return MealModel(
      name: name ?? this.name,
      cookingTime: cookingTime ?? this.cookingTime,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
      id: id ?? this.id,
      rating: rating ?? this.rating,
    );
  }

  @override
  String toString() {
    return 'MealModel(name: $name, cookingTime: $cookingTime, description: $description, imagePath: $imagePath, id: $id, rating: $rating)';
  }
}