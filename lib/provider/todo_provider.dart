import 'package:daily_todo/database/database.dart';
import 'package:daily_todo/model/todo_model.dart';
import 'package:daily_todo/provider/calendar_provider.dart';
import 'package:daily_todo/provider/daily_todo_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

final todoProvider =
    StateNotifierProvider.family<TodoNotifier, TodoModel, String>((ref, id) {
  final selectedDate =
      ref.watch(calendarProvider.select((state) => state.selectedDate));

  final todos = ref.read(dailyTodoProvider(selectedDate));

  final TodoModel todo = todos.firstWhere((todo) => todo.id == id);

  return TodoNotifier(todo: todo, ref: ref, selectedDate: selectedDate);
});

class TodoNotifier extends StateNotifier<TodoModel> {
  final Ref ref;
  final DateTime selectedDate;
  TodoNotifier({
    required TodoModel todo,
    required this.ref,
    required this.selectedDate,
  }) : super(todo);

  void toggleCompletion() {
    final database = GetIt.I<AppDatabase>();

    state = state.copyWith(isCompleted: !state.isCompleted!);

    final todoTableCompanion = state.toDrift();

    database.updateTodoById(state.id, todoTableCompanion);

    ref.read(dailyTodoProvider(selectedDate).notifier).loadTodosForDate();
  }

  void updateContent(String content) {
    final database = GetIt.I<AppDatabase>();

    state = state.copyWith(
      content: content,
    );

    final todoTableCompanion = state.toDrift();

    database.updateTodoById(state.id, todoTableCompanion);

    ref.read(dailyTodoProvider(selectedDate).notifier).loadTodosForDate();
  }
}
