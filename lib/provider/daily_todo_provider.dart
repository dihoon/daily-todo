import 'package:daily_todo/database/database.dart';
import 'package:daily_todo/model/todo_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

final dailyTodoProvider =
    StateNotifierProvider.family<DailyTodoNotifier, List<TodoModel>, DateTime>(
  (ref, date) => DailyTodoNotifier(date: date),
);

class DailyTodoNotifier extends StateNotifier<List<TodoModel>> {
  final DateTime date;
  final AppDatabase database = GetIt.I<AppDatabase>();

  DailyTodoNotifier({
    required this.date,
  }) : super([]) {
    loadTodosForDate();
  }

  Future<void> loadTodosForDate() async {
    final todoData = await database.getStreamTodoByDate(date).first;
    final todos = todoData.map((data) => TodoModel.fromDrift(data)).toList();

    state = todos;
  }

  void addTodo(TodoModel todo) async {
    final TodoTableCompanion = todo.toDrift();
    database.createTodo(TodoTableCompanion);
    state = [...state, todo];
  }

  void removeTodo(String id) async {
    await database.removeTodoById(id);
    state = state.where((todo) => todo.id != id).toList();
  }
}
