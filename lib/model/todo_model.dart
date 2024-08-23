class TodoModel {
  final String id;
  final String content;
  final bool? isCompleted;

  TodoModel({
    required this.id,
    required this.content,
    this.isCompleted = false,
  });

  TodoModel copyWith({
    String? id,
    String? content,
    bool? isCompleted,
  }) {
    return TodoModel(
      id: id ?? this.id,
      content: content ?? this.content,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
