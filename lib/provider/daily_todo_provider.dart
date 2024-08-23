import 'package:daily_todo/model/todo_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dailyTodoProvider =
    StateNotifierProvider.family<DailyTodoNotifier, List<TodoModel>, DateTime>(
        (ref, date) => DailyTodoNotifier(date: date));

class DailyTodoNotifier extends StateNotifier<List<TodoModel>> {
  final DateTime date;

  DailyTodoNotifier({
    required this.date,
  }) : super([]);

  void addTodo(TodoModel todo) {
    state = [...state, todo];
  }

  void removeTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }
}
