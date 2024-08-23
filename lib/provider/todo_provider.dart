import 'package:daily_todo/model/todo_model.dart';
import 'package:daily_todo/provider/calendar_provider.dart';
import 'package:daily_todo/provider/daily_todo_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final todoProvider =
    StateNotifierProvider.family<TodoNotifier, TodoModel, String>((ref, id) {
  final selectedDate =
      ref.watch(calendarProvider.select((state) => state.selectedDate));

  final todos = ref.read(dailyTodoProvider(selectedDate));

  final todo = todos.firstWhere((todo) => todo.id == id);

  return TodoNotifier(todo);
});

class TodoNotifier extends StateNotifier<TodoModel> {
  TodoNotifier(TodoModel todo) : super(todo);

  void toggleCompletion() {
    state = state.copyWith(isCompleted: !state.isCompleted!);
  }
}
