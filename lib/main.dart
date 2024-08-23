import 'package:daily_todo/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting();

  runApp(
    ProviderScope(
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Jua'),
        home: HomeScreen(),
      ),
    ),
  );
}
