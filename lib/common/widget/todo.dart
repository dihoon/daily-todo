import 'package:daily_todo/model/todo_model.dart';
import 'package:daily_todo/provider/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Todo extends ConsumerWidget {
  final TodoModel todo;

  const Todo({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(todoProvider(this.todo.id));

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(todo.content),
            IconButton(
              onPressed: () {
                final todoNotifier =
                    ref.read(todoProvider(this.todo.id).notifier);

                todoNotifier.toggleCompletion();
              },
              icon: Icon(todo.isCompleted == true
                  ? Icons.check_box_outlined
                  : Icons.check_box_outline_blank),
            )
          ],
        ),
      ),
    );
  }
}
