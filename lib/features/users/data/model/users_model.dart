// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:meal_mate/features/users/data/enum/gender_enum.dart';

class UsersModel {
  final String firstName;
  final int id;
  final String lastName;
  final int age;
  final Gender gender;
  final String username;

  UsersModel({
    required this.firstName,
    required this.id,
    required this.lastName,
    required this.age,
    required this.gender,
    required this.username,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      firstName: json["firstName"],
      id: json["id"],
      lastName: json["lastName"],
      age: json["age"],
      gender: json["gender"],
      username: json["username"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "lastName": lastName,
      "firstName": firstName,
      "age": age,
      "gender": gender,
      "uesrname": username,
    };
  }
}
