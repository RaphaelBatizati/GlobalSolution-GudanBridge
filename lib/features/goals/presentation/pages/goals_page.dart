    import 'package:flutter/material.dart';
    import 'package:flutter_riverpod/flutter_riverpod.dart';
    import '../providers/goal_providers.dart';
    import '../../domain/goal.dart';

    class GoalsPage extends ConsumerStatefulWidget {
      const GoalsPage({super.key});

      @override
      ConsumerState<GoalsPage> createState() => _GoalsPageState();
    }

    class _GoalsPageState extends ConsumerState<GoalsPage> {
      String _filterCategory = 'Todas';

      @override
      Widget build(BuildContext context) {
        final goals = ref.watch(goalListProvider);
        final filteredGoals = _filterCategory == 'Todas'
            ? goals
            : goals.where((g) => g.category == _filterCategory).toList();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Metas de desenvolvimento'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Em que área você quer crescer?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    ChoiceChip(
                      label: const Text('Todas'),
                      selected: _filterCategory == 'Todas',
                      onSelected: (_) {
                        setState(() => _filterCategory = 'Todas');
                      },
                    ),
                    ChoiceChip(
                      label: const Text('Pessoal'),
                      selected: _filterCategory == 'Pessoal',
                      onSelected: (_) {
                        setState(() => _filterCategory = 'Pessoal');
                      },
                    ),
                    ChoiceChip(
                      label: const Text('Profissional'),
                      selected: _filterCategory == 'Profissional',
                      onSelected: (_) {
                        setState(() => _filterCategory = 'Profissional');
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: filteredGoals.isEmpty
                      ? const Center(
                          child: Text(
                            'Nenhuma meta cadastrada ainda. Crie uma meta para o seu desenvolvimento pessoal ou profissional.',
                            textAlign: TextAlign.center,
                          ),
                        )
                      : ListView.separated(
                          itemCount: filteredGoals.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (_, index) {
                            final Goal g = filteredGoals[index];
                            return Card(
                              child: ListTile(
                                leading: Icon(
                                  g.category == 'Pessoal'
                                      ? Icons.self_improvement
                                      : Icons.work_outline,
                                ),
                                title: Text(g.title),
                                subtitle: Text(g.description),
                                trailing: Checkbox(
                                  value: g.done,
                                  onChanged: (_) {
                                    ref
                                        .read(goalListProvider.notifier)
                                        .toggleDone(g.id);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _openAddGoalDialog(context),
            icon: const Icon(Icons.add),
            label: const Text('Nova meta'),
          ),
        );
      }

      void _openAddGoalDialog(BuildContext context) {
        final titleController = TextEditingController();
        final descriptionController = TextEditingController();
        String category = 'Pessoal';

        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('Nova meta de desenvolvimento'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Título da meta',
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Descrição',
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Categoria'),
                        DropdownButton<String>(
                          value: category,
                          items: const [
                            DropdownMenuItem(
                              value: 'Pessoal',
                              child: Text('Pessoal'),
                            ),
                            DropdownMenuItem(
                              value: 'Profissional',
                              child: Text('Profissional'),
                            ),
                          ],
                          onChanged: (value) {
                            if (value == null) return;
                            category = value;
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.trim().isEmpty) return;
                    ref.read(goalListProvider.notifier).addGoal(
                          title: titleController.text.trim(),
                          category: category,
                          description: descriptionController.text.trim(),
                        );
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('Salvar'),
                ),
              ],
            );
          },
        );
      }
    }
