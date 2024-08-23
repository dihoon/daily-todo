import 'package:daily_todo/common/widget/todo.dart';
import 'package:daily_todo/provider/calendar_provider.dart';
import 'package:daily_todo/provider/daily_todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoList extends ConsumerStatefulWidget {
  const TodoList({
    super.key,
  });

  @override
  ConsumerState<TodoList> createState() => _TodoListState();
}

class _TodoListState extends ConsumerState<TodoList> {
  @override
  Widget build(BuildContext context) {
    final selectedDate =
        ref.watch(calendarProvider.select((state) => state.selectedDate));
    final dailyTodo = ref.watch(dailyTodoProvider(selectedDate));

    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.separated(
            itemBuilder: (_, index) {
              if (index == dailyTodo.length) {
                return SizedBox(
                  height: 80,
                );
              }

              return Todo(todo: dailyTodo[index]);
            },
            separatorBuilder: (_, index) {
              return SizedBox(
                height: 8,
              );
            },
            itemCount: dailyTodo.length + 1),
      ),
    );
  }
}
