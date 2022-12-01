class TodoModel {
  const TodoModel({
    required this.uuid,
    required this.label,
    this.isCompleted = false,
  });

  final String uuid;
  final String label;
  final bool isCompleted;

  TodoModel copyWith({
    String? uuid,
    String? label,
    bool? isCompleted,
  }) {
    return TodoModel(
      uuid: uuid ?? this.uuid,
      label: label ?? this.label,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
