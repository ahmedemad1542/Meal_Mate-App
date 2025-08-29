class AreaModel {
  final String name;

  AreaModel({required this.name});

  factory AreaModel.fromJson(Map<String, dynamic> json) {
    return AreaModel(name: json['strArea']);
  }
}
