import 'package:daily_todo/database/database.dart';
import 'package:daily_todo/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  final database = AppDatabase();

  GetIt.instance.registerSingleton<AppDatabase>(database);

  runApp(
    ProviderScope(
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Jua'),
        home: HomeScreen(),
      ),
    ),
  );
}
