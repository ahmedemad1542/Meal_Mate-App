import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:meal_mate/features/online_meals/area_feature/data/repo/area_repo.dart';
import 'package:meal_mate/features/online_meals/area_feature/manager/cubit/area_state.dart';

// Import the repo
// Import your model if needed

class AreaCubit extends Cubit<AreaState> {
  final AreaRepo areaRepo;
  bool _hasInitialLoadCompleted = false;
  
  AreaCubit(this.areaRepo) : super(AreaInitial());

  Future<void> getAreas({bool forceRefresh = false}) async {
    // For force refresh (pull-to-refresh), always fetch
    if (forceRefresh) {
      areaRepo.clearCache(); // Clear the cache before fetching
      emit(AreaLoading());
      try {
        final data = await areaRepo.fetchAreas();
        emit(AreaLoaded(data));
        _hasInitialLoadCompleted = true;
      } catch (e) {
        emit(AreaError(e.toString()));
      }
      return;
    }

    // For normal load, check if we already have data loaded in this session
    if (state is AreaLoaded && _hasInitialLoadCompleted) {
      return; // Don't reload if we already have data in this session
    }

    // Initial load or retry after error
    emit(AreaLoading());
    try {
      final data = await areaRepo.fetchAreas();
      emit(AreaLoaded(data));
      _hasInitialLoadCompleted = true;
    } catch (e) {
      emit(AreaError(e.toString()));
    }
  }

  // Call this when app starts to ensure fresh data on app restart
  void resetSession() {
    _hasInitialLoadCompleted = false;
    areaRepo.clearCache();
  }
}

