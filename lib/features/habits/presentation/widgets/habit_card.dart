import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/habit.dart';
import '../providers/habit_providers.dart';

class HabitCard extends ConsumerWidget {
  final Habit habit;

  const HabitCard({super.key, required this.habit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress =
        habit.targetPerDay == 0 ? 0.0 : habit.doneToday / habit.targetPerDay;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              habit.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              habit.description,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 6,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Hoje: ${habit.doneToday}/${habit.targetPerDay}'),
                TextButton.icon(
                  onPressed: () {
                    ref
                        .read(habitListProvider.notifier)
                        .completeOnce(habit.id);
                  },
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('Concluir agora'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
