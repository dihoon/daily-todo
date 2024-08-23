import 'package:daily_todo/common/layout/default_layout.dart';
import 'package:daily_todo/common/widget/calendar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: SafeArea(
        child: Column(
          children: [
            Calendar(),
          ],
        ),
      ),
    );
  }
}
