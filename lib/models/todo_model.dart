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

  // 以下のリンク先を参考にfromJson/toJsonを実装した
  // <https://docs.flutter.dev/development/data-and-backend/json>
  TodoModel.fromJson(Map<String, dynamic> json)
      : uuid = json['uuid'],
        label = json['label'],
        isCompleted = json['isCompleted'];

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'label': label,
        'isCompleted': isCompleted,
      };
}
