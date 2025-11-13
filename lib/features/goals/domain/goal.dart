class Goal {
  final String id;
  final String title;
  final String category; // 'Pessoal' ou 'Profissional'
  final String description;
  final DateTime createdAt;
  final DateTime? dueDate;
  final bool done;

  const Goal({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.createdAt,
    required this.dueDate,
    required this.done,
  });

  Goal copyWith({
    String? id,
    String? title,
    String? category,
    String? description,
    DateTime? createdAt,
    DateTime? dueDate,
    bool? done,
  }) {
    return Goal(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
      done: done ?? this.done,
    );
  }
}
