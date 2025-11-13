class CheckIn {
  final String id;
  final DateTime dateTime;
  final int mood; // 1-5
  final int energy; // 1-10
  final String workload; // 'baixa', 'equilibrada', 'alta'
  final String note;

  const CheckIn({
    required this.id,
    required this.dateTime,
    required this.mood,
    required this.energy,
    required this.workload,
    required this.note,
  });
}
