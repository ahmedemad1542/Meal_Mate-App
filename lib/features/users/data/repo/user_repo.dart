import 'dart:math';

import 'package:dio/dio.dart';
import 'package:meal_mate/core/networking/api_endpoints.dart';
import 'package:meal_mate/core/networking/dio_helper.dart';
import 'package:meal_mate/features/users/data/model/users_model.dart';

class UserRepo {
  final DioHelper dioHelper;

  UserRepo._internal(this.dioHelper);

  static final UserRepo _userRepo = UserRepo._internal(DioHelper());

  factory UserRepo() => _userRepo;

  Future<List<UsersModel>> getAllUsers() async {
    final allUsers = await dioHelper.getRequest(ApiEndpoints.getAllUsers);
    final List<dynamic> data = allUsers.data;
    return data.map((user) => UsersModel.fromJson(user)).toList();
  }
}
