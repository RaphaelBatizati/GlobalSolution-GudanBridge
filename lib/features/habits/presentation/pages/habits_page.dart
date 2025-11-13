    import 'package:flutter/material.dart';
    import 'package:flutter_riverpod/flutter_riverpod.dart';
    import '../providers/habit_providers.dart';
    import '../widgets/habit_card.dart';

    class HabitsPage extends ConsumerWidget {
      const HabitsPage({super.key});

      @override
      Widget build(BuildContext context, WidgetRef ref) {
        final habits = ref.watch(habitListProvider);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Jornadas e micro-hábitos'),
            actions: [
              IconButton(
                onPressed: () {
                  ref.read(habitListProvider.notifier).resetToday();
                },
                icon: const Icon(Icons.refresh),
                tooltip: 'Reiniciar progresso de hoje',
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: habits.isEmpty
                ? const Center(
                    child: Text(
                      'Você ainda não tem jornadas de cuidado. Adicione um micro-hábito para começar.',
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.separated(
                    itemCount: habits.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, index) => HabitCard(habit: habits[index]),
                  ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _openAddHabitDialog(context, ref),
            icon: const Icon(Icons.add),
            label: const Text('Novo micro-hábito'),
          ),
        );
      }

      void _openAddHabitDialog(BuildContext context, WidgetRef ref) {
        final titleController = TextEditingController();
        final descriptionController = TextEditingController();
        int target = 1;

        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('Novo micro-hábito'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Título',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Descrição',
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Vezes por dia'),
                      DropdownButton<int>(
                        value: target,
                        items: const [
                          DropdownMenuItem(value: 1, child: Text('1')),
                          DropdownMenuItem(value: 2, child: Text('2')),
                          DropdownMenuItem(value: 3, child: Text('3')),
                        ],
                        onChanged: (value) {
                          if (value == null) return;
                          target = value;
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.trim().isEmpty) {
                      return;
                    }
                    ref.read(habitListProvider.notifier).addHabit(
                          titleController.text.trim(),
                          descriptionController.text.trim(),
                          target,
                        );
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('Adicionar'),
                ),
              ],
            );
          },
        );
      }
    }
