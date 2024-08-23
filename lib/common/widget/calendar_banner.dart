import 'package:daily_todo/common/constant/colors.dart';
import 'package:daily_todo/provider/calendar_provider.dart';
import 'package:daily_todo/provider/daily_todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalendarBanner extends ConsumerWidget {
  const CalendarBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarState = ref.watch(calendarProvider);
    final todos = ref.watch(dailyTodoProvider(calendarState.selectedDate));
    final selectedDate = calendarState.selectedDate;

    final defaultTextStyle = TextStyle(color: Colors.white);

    return Container(
      color: PRIMARY_COLOR,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${selectedDate.year}.${selectedDate.month}.${selectedDate.day}',
              style: defaultTextStyle,
            ),
            Text(
              '${todos.length}개',
              style: defaultTextStyle,
            )
          ],
        ),
      ),
    );
  }
}
