import 'package:cvms_mobile/features/activity/data/activity_repository.dart';
import 'package:cvms_mobile/features/activity/models/activity_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  final ActivityRepository repo;

  ActivityCubit({ActivityRepository? repo})
    : repo = repo ?? ActivityRepository(),
      super(ActivityInitial());

  Future<void> fetchRecentActivities({int limit = 50}) async {
    if (isClosed) return;
    emit(ActivityLoading());
    try {
      final activities = await repo.getRecentActivities(limit: limit);
      if (isClosed) return;
      emit(ActivityLoaded(activities));
    } catch (e) {
      if (isClosed) return;
      emit(ActivityError("Failed to load activities: ${e.toString()}"));
    }
  }
}
