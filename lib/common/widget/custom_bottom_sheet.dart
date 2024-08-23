import 'package:daily_todo/model/todo_model.dart';
import 'package:daily_todo/provider/calendar_provider.dart';
import 'package:daily_todo/provider/daily_todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomBottomSheet extends ConsumerStatefulWidget {
  const CustomBottomSheet({super.key});

  @override
  ConsumerState<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends ConsumerState<CustomBottomSheet> {
  String content = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Row(
            children: [
              Expanded(
                  child: TextField(
                decoration: InputDecoration(
                  hintText: '오늘의 할 일',
                  border: InputBorder.none,
                ),
                autofocus: true,
                onEditingComplete: submit,
                onChanged: (content) => this.content = content,
              )),
              IconButton(
                onPressed: submit,
                icon: Icon(Icons.arrow_circle_up),
              )
            ],
          ),
        ),
      ),
    );
  }

  void submit() {
    final selectedDate =
        ref.read(calendarProvider.select((state) => state.selectedDate));
    final dailyTodoNotifier =
        ref.read(dailyTodoProvider(selectedDate).notifier);
    if (content != '') {
      final newTodo = TodoModel(id: '${DateTime.now()}', content: content);

      dailyTodoNotifier.addTodo(newTodo);
      ;
    }

    Navigator.of(context).pop();
  }
}
