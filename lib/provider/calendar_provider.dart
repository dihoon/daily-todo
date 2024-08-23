import 'package:daily_todo/model/calendar_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final calendarProvider =
    StateNotifierProvider<CalendarStateNotifier, CalendarState>(
        (ref) => CalendarStateNotifier());

class CalendarStateNotifier extends StateNotifier<CalendarState> {
  CalendarStateNotifier()
      : super(CalendarState(
            selectedDate: DateTime.now().toUtc(),
            currentViewDate: DateTime.now().toUtc()));

  void updateSelectedDate({
    DateTime? selectedDate,
    DateTime? currentViewDate,
  }) {
    state = state.copyWith(
      selectedDate: selectedDate,
      currentViewDate: currentViewDate,
    );
  }
}
