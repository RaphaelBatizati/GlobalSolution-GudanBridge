import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/checkin.dart';
import '../providers/checkin_providers.dart';

class CheckInPage extends ConsumerStatefulWidget {
  const CheckInPage({super.key});

  @override
  ConsumerState<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends ConsumerState<CheckInPage> {
  int _mood = 3;
  double _energy = 5;
  String _workload = 'equilibrada';
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _submit() {
    ref.read(checkInListProvider.notifier).addCheckIn(
          mood: _mood,
          energy: _energy.round(),
          workload: _workload,
          note: _noteController.text.trim(),
        );
    _noteController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Check-in registrado. Obrigado por cuidar de você hoje.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final checkIns = ref.watch(checkInListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Como você está hoje?'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Check-in emocional',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Humor geral'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Baixo'),
                        Expanded(
                          child: Slider(
                            value: _mood.toDouble(),
                            min: 1,
                            max: 5,
                            divisions: 4,
                            label: _mood.toString(),
                            onChanged: (value) {
                              setState(() => _mood = value.round());
                            },
                          ),
                        ),
                        const Text('Alto'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text('Nível de energia'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Baixa'),
                        Expanded(
                          child: Slider(
                            value: _energy,
                            min: 1,
                            max: 10,
                            divisions: 9,
                            label: _energy.round().toString(),
                            onChanged: (value) {
                              setState(() => _energy = value);
                            },
                          ),
                        ),
                        const Text('Alta'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text('Como está sua carga de trabalho?'),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        ChoiceChip(
                          label: const Text('Baixa'),
                          selected: _workload == 'baixa',
                          onSelected: (_) {
                            setState(() => _workload = 'baixa');
                          },
                        ),
                        ChoiceChip(
                          label: const Text('Equilibrada'),
                          selected: _workload == 'equilibrada',
                          onSelected: (_) {
                            setState(() => _workload = 'equilibrada');
                          },
                        ),
                        ChoiceChip(
                          label: const Text('Alta'),
                          selected: _workload == 'alta',
                          onSelected: (_) {
                            setState(() => _workload = 'alta');
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text('Quer compartilhar algo sobre o seu dia?'),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _noteController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: 'Escreva aqui, se quiser...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _submit,
                        icon: const Icon(Icons.check_circle_outline),
                        label: const Text('Registrar check-in'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Últimos registros',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            if (checkIns.isEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'Você ainda não fez nenhum check-in. Comece registrando como você se sente hoje.',
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: checkIns.length.clamp(0, 10),
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (_, index) {
                  final CheckIn c = checkIns[index];
                  return ListTile(
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    leading: CircleAvatar(
                      child: Text(c.mood.toString()),
                    ),
                    title: Text(
                      'Humor ${c.mood} • Energia ${c.energy}',
                    ),
                    subtitle: Text(
                      '${c.workload.toUpperCase()} • ${c.dateTime.day.toString().padLeft(2, '0')}/${c.dateTime.month.toString().padLeft(2, '0')} '
                      '${c.dateTime.hour.toString().padLeft(2, '0')}:${c.dateTime.minute.toString().padLeft(2, '0')}',
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
