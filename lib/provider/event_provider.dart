import 'package:daily_todo/provider/daily_todo_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final eventProvider = Provider.family<List, DateTime>((ref, date) {
  final length =
      ref.watch(dailyTodoProvider(date).select((state) => state.length));

  return length > 0 ? [true] : [];
});
