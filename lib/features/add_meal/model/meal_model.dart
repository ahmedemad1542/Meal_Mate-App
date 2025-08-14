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
    this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'cookingTime': cookingTime,
      'describtion': describtion,
      if (imagePath != null) 'imagePath': imagePath, // أضفها بس لو مش null
    };
  }

  factory MealModel.fromMap(Map<String, dynamic> map) {
    return MealModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      cookingTime: (map['cookingTime'] as num).toInt(),
      describtion: map['describtion'] as String,
      imagePath: map['imagePath'] as String?,
    );
  }
}
