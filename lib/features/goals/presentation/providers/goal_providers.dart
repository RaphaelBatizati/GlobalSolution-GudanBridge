import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/goal.dart';

class GoalListNotifier extends StateNotifier<List<Goal>> {
  GoalListNotifier()
      : super([
    Goal(
      id: 'g1',
      title: 'Melhorar equilíbrio vida-trabalho',
      category: 'Pessoal',
      description:
      'Definir limites claros de horário e criar um ritual de desligar ao fim do dia.',
      createdAt: DateTime(2025, 1, 1),
      dueDate: null,
      done: false,
    ),
    Goal(
      id: 'g2',
      title: 'Desenvolver habilidade de feedback',
      category: 'Profissional',
      description:
      'Participar de treinamentos e praticar feedback construtivo com o time.',
      createdAt: DateTime(2025, 1, 1),
      dueDate: null,
      done: false,
    ),
  ]);

  void addGoal({
    required String title,
    required String category,
    required String description,
    DateTime? dueDate,
  }) {
    final goal = Goal(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      category: category,
      description: description,
      createdAt: DateTime.now(),
      dueDate: dueDate,
      done: false,
    );
    state = [...state, goal];
  }

  void toggleDone(String id) {
    state = [
      for (final g in state)
        if (g.id == id) g.copyWith(done: !g.done) else g,
    ];
  }
}

final goalListProvider =
StateNotifierProvider<GoalListNotifier, List<Goal>>(
      (ref) => GoalListNotifier(),
);
