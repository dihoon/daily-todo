import 'package:daily_todo/common/constant/colors.dart';
import 'package:daily_todo/common/layout/default_layout.dart';
import 'package:daily_todo/common/widget/calendar.dart';
import 'package:daily_todo/common/widget/calendar_banner.dart';
import 'package:daily_todo/common/widget/custom_bottom_sheet.dart';
import 'package:daily_todo/common/widget/todo_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      floatingButton: FloatingActionButton(
        backgroundColor: PRIMARY_COLOR,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return CustomBottomSheet();
              });
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Calendar(),
            CalendarBanner(),
            TodoList(),
          ],
        ),
      ),
    );
  }
}
