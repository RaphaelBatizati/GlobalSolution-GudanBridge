import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/checkin.dart';

class CheckInListNotifier extends StateNotifier<List<CheckIn>> {
  CheckInListNotifier() : super(const []);

  void addCheckIn({
    required int mood,
    required int energy,
    required String workload,
    required String note,
  }) {
    final checkIn = CheckIn(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      dateTime: DateTime.now(),
      mood: mood,
      energy: energy,
      workload: workload,
      note: note,
    );
    state = [checkIn, ...state];
  }
}

final checkInListProvider =
    StateNotifierProvider<CheckInListNotifier, List<CheckIn>>(
  (ref) => CheckInListNotifier(),
);
