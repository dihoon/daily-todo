import 'package:daily_todo/common/constant/colors.dart';
import 'package:daily_todo/provider/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoModal extends ConsumerStatefulWidget {
  final String todoId;

  const TodoModal({
    super.key,
    required this.todoId,
  });

  @override
  ConsumerState<TodoModal> createState() => _TodoModalState();
}

class _TodoModalState extends ConsumerState<TodoModal> {
  final formkey = GlobalKey<FormState>();
  bool isEditable = false;
  late FocusNode contentFocusNode;

  @override
  void initState() {
    super.initState();
    contentFocusNode = FocusNode();
  }

  @override
  void dispose() {
    contentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todo = ref.read(todoProvider(widget.todoId));
    final scrollController = ScrollController();
    String content = todo.content;

    final defaultInputBorderStyle = OutlineInputBorder(
      borderSide: BorderSide(width: 0, color: Colors.grey),
    );

    return Dialog(
      child: Container(
        height: 300,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '상세 내용',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: Form(
                key: formkey,
                child: Scrollbar(
                  thumbVisibility: true,
                  controller: scrollController,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: TextFormField(
                      enabled: isEditable,
                      focusNode: contentFocusNode,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(border: InputBorder.none),
                      style: TextStyle(color: Colors.black),
                      onSaved: (value) {
                        content = value ?? '';
                      },
                      initialValue: todo.content,
                      maxLines: null,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (isEditable) {
                        final todoNotifier =
                            ref.read(todoProvider(widget.todoId).notifier);
                        formkey.currentState!.save();

                        todoNotifier.updateContent(content);

                        Navigator.of(context).pop();
                      } else {
                        setState(() {
                          isEditable = true;
                        });
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          contentFocusNode.requestFocus();
                        });
                      }
                    },
                    child: Text(
                      isEditable ? '저장' : '수정',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PRIMARY_COLOR,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
