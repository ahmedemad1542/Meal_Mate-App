import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_mate/features/online_meals/area_feature/data/repo/area_repo.dart';
import 'package:meal_mate/features/online_meals/area_feature/manager/cubit/area_state.dart';

class AreaCubit extends Cubit<AreaState> {
  final AreaRepo areaRepo;
  AreaCubit(this.areaRepo) : super(AreaInitial());

  Future<void> getAreas() async {
    if (state is AreaLoaded) return; // prevent re-fetch
    emit(AreaLoading());
    try {
      final data = await areaRepo.fetchAreas();
      emit(AreaLoaded(data));
    } catch (e) {
      emit(AreaError(e.toString()));
    }
  }
}
