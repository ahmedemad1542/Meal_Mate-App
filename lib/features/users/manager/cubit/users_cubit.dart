import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'users_state.dart';

class UsersCubitCubit extends Cubit<UsersCubitState> {
  UsersCubitCubit() : super(UsersCubitInitial());
}
