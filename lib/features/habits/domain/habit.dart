class Habit {
  final String id;
  final String title;
  final String description;
  final int targetPerDay;
  final int doneToday;
  final bool isActive;

  const Habit({
    required this.id,
    required this.title,
    required this.description,
    required this.targetPerDay,
    required this.doneToday,
    required this.isActive,
  });

  Habit copyWith({
    String? id,
    String? title,
    String? description,
    int? targetPerDay,
    int? doneToday,
    bool? isActive,
  }) {
    return Habit(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      targetPerDay: targetPerDay ?? this.targetPerDay,
      doneToday: doneToday ?? this.doneToday,
      isActive: isActive ?? this.isActive,
    );
  }
}
