import 'package:daily_todo/common/constant/colors.dart';
import 'package:daily_todo/common/widget/todo_modal.dart';
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
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  openModal(context: context, todoId: todo.id);
                },
                child: Container(
                  color: Colors.transparent,
                  alignment: Alignment.centerLeft,
                  height: double.maxFinite,
                  child: Text(
                    todo.content,
                    style: TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              style: const ButtonStyle(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () {
                final todoNotifier =
                    ref.read(todoProvider(this.todo.id).notifier);

                todoNotifier.toggleCompletion();
              },
              icon: SizedBox(
                width: 32,
                child: Icon(
                  color: todo.isCompleted == true ? PRIMARY_COLOR : Colors.grey,
                  todo.isCompleted == true
                      ? Icons.check_box_outlined
                      : Icons.check_box_outline_blank,
                  size: 36,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> openModal({
    required BuildContext context,
    required String todoId,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return TodoModal(todoId: todoId);
      },
    );
  }
}
