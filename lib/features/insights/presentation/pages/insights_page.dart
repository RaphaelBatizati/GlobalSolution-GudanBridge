import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../checkin/presentation/providers/checkin_providers.dart';
import '../../../goals/presentation/providers/goal_providers.dart';
import '../../../habits/presentation/providers/habit_providers.dart';

class InsightsPage extends ConsumerWidget {
  const InsightsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkIns = ref.watch(checkInListProvider);
    final habits = ref.watch(habitListProvider);
    final goals = ref.watch(goalListProvider);

    final totalCheckIns = checkIns.length;
    final avgMood = totalCheckIns == 0
        ? 0.0
        : checkIns.map((c) => c.mood).reduce((a, b) => a + b) /
            totalCheckIns;
    final avgEnergy = totalCheckIns == 0
        ? 0.0
        : checkIns.map((c) => c.energy).reduce((a, b) => a + b) /
            totalCheckIns;

    final completedGoals = goals.where((g) => g.done).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Insights do seu bem-estar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resumo geral',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _InsightCard(
                  title: 'Check-ins realizados',
                  value: '$totalCheckIns',
                  description:
                      'Cada registro é um passo para entender melhor seu dia a dia.',
                ),
                _InsightCard(
                  title: 'Humor médio',
                  value: avgMood.toStringAsFixed(1),
                  description:
                      'Valores mais altos indicam dias emocionalmente mais leves.',
                ),
                _InsightCard(
                  title: 'Energia média',
                  value: avgEnergy.toStringAsFixed(1),
                  description:
                      'Ajuda a perceber quando seu corpo e mente pedem descanso.',
                ),
                _InsightCard(
                  title: 'Metas concluídas',
                  value: '$completedGoals',
                  description:
                      'Celebre cada meta concluída no seu desenvolvimento.',
                ),
                _InsightCard(
                  title: 'Micro-hábitos ativos',
                  value: '${habits.length}',
                  description:
                      'Pequenos cuidados diários constroem grandes mudanças.',
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Dica da GudanBridge',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _buildTip(avgMood: avgMood, avgEnergy: avgEnergy),
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  String _buildTip({required double avgMood, required double avgEnergy}) {
    if (avgMood == 0 && avgEnergy == 0) {
      return 'Comece fazendo seu primeiro check-in hoje. A partir dele, vamos entender melhor como apoiar você.';
    }
    if (avgMood < 3) {
      return 'Seu humor médio tem estado mais baixo. Que tal reservar alguns minutos do seu dia para uma pausa consciente ou conversar com alguém de confiança?';
    }
    if (avgEnergy < 5) {
      return 'Sua energia parece estar oscilando. Experimente organizar pausas curtas durante o trabalho e observar seu sono nos próximos dias.';
    }
    return 'Você tem mantido um equilíbrio interessante entre humor e energia. Continue cuidando de você com pequenos hábitos diários e metas alinhadas ao que importa.';
  }
}

class _InsightCard extends StatelessWidget {
  final String title;
  final String value;
  final String description;

  const _InsightCard({
    required this.title,
    required this.value,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
