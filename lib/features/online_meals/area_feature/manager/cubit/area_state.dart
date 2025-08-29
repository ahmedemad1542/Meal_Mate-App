import 'package:meal_mate/features/online_meals/area_feature/data/model/area_model.dart';

abstract class AreaState {}
class AreaInitial extends AreaState {}

class AreaLoading extends AreaState {}


class AreaLoaded extends AreaState {
  final List<AreaModel> areas;
  AreaLoaded(this.areas);
}


class AreaError extends AreaState {
  final String message;
  AreaError(this.message);
}
