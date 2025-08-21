import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_mate/features/users/data/model/users_model.dart';
import 'package:meal_mate/features/users/data/repo/user_repo.dart';
import 'package:meal_mate/features/users/manager/cubit/users_state.dart';

class UsersCubitCubit extends Cubit<UsersState> {
  final UserRepo userRepo;
  late List<UsersModel> theUsers;
  UsersCubitCubit(this.userRepo) : super(UsersInitial());

  List<UsersModel> getAllUsers() {
    userRepo
        .getAllUsers()
        .then((users) {
          if (users.isNotEmpty) {
            emit(UsersLoaded(users));
            return theUsers = users;
          } else {
            emit(UsersError("No users found"));
          }
        })
        .catchError((error) {
          emit(UsersError("Failed to load users: $error"));
          return (error);
        });
  }
}
