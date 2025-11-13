import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/habit.dart';

class HabitListNotifier extends StateNotifier<List<Habit>> {
  HabitListNotifier()
      : super(const [
          Habit(
            id: '1',
            title: 'Pausa consciente',
            description: 'Fazer uma pausa de 3 minutos para respirar e alongar.',
            targetPerDay: 2,
            doneToday: 0,
            isActive: true,
          ),
          Habit(
            id: '2',
            title: 'Desconectar após o expediente',
            description: 'Evitar ler e-mails e mensagens de trabalho após o horário.',
            targetPerDay: 1,
            doneToday: 0,
            isActive: true,
          ),
        ]);

  void addHabit(String title, String description, int targetPerDay) {
    final habit = Habit(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      description: description,
      targetPerDay: targetPerDay,
      doneToday: 0,
      isActive: true,
    );
    state = [...state, habit];
  }

  void completeOnce(String id) {
    state = [
      for (final h in state)
        if (h.id == id)
          h.copyWith(doneToday: (h.doneToday + 1).clamp(0, h.targetPerDay))
        else
          h,
    ];
  }

  void resetToday() {
    state = [
      for (final h in state) h.copyWith(doneToday: 0),
    ];
  }
}

final habitListProvider =
    StateNotifierProvider<HabitListNotifier, List<Habit>>(
  (ref) => HabitListNotifier(),
);
