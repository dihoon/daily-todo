import 'package:daily_todo/database/database.dart';
import 'package:drift/drift.dart';

class TodoModel {
  final String id;
  final String content;
  final bool? isCompleted;
  final DateTime date;

  TodoModel({
    required this.id,
    required this.content,
    this.isCompleted = false,
    required this.date,
  });

  TodoModel copyWith({
    String? id,
    String? content,
    bool? isCompleted,
    DateTime? date,
  }) {
    return TodoModel(
      id: id ?? this.id,
      content: content ?? this.content,
      isCompleted: isCompleted ?? this.isCompleted,
      date: date ?? this.date,
    );
  }

  factory TodoModel.fromDrift(TodoTableData data) {
    return TodoModel(
      id: data.id,
      content: data.content,
      isCompleted: data.isCompleted,
      date: data.date,
    );
  }

  TodoTableCompanion toDrift() {
    return TodoTableCompanion(
      id: Value(id),
      content: Value(content),
      isCompleted: Value(isCompleted ?? false),
      date: Value(date),
    );
  }
}
