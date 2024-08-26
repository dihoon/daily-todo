import 'package:daily_todo/common/constant/colors.dart';
import 'package:daily_todo/provider/calendar_provider.dart';
import 'package:daily_todo/provider/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends ConsumerStatefulWidget {
  const Calendar({super.key});

  @override
  ConsumerState<Calendar> createState() => _CalendarState();
}

class _CalendarState extends ConsumerState<Calendar> {
  late DateTime selectedDate;
  late DateTime currentViewDate;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    selectedDate = DateTime.utc(now.year, now.month, now.day);
    currentViewDate = selectedDate;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      onDaySelected(selectedDate, currentViewDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    final calendarState = ref.watch(calendarProvider);
    final eventState = ref.watch(eventProvider(calendarState.selectedDate));
    return TableCalendar(
      focusedDay: calendarState.currentViewDate,
      firstDay: DateTime(1900),
      lastDay: DateTime(3000),
      daysOfWeekHeight: 20,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
      calendarStyle: CalendarStyle(
          isTodayHighlighted: false,
          selectedDecoration: BoxDecoration(
            color: PRIMARY_COLOR,
            shape: BoxShape.circle,
          ),
          markerDecoration: BoxDecoration(
            color: ACCENT_COLOR,
            shape: BoxShape.circle,
          )),
      eventLoader: eventLoader,
      daysOfWeekStyle: DaysOfWeekStyle(decoration: BoxDecoration()),
      selectedDayPredicate: selectedDayPredicate,
      onDaySelected: onDaySelected,
      locale: 'ko_KR',
    );
  }

  bool selectedDayPredicate(DateTime day) {
    final calendarState = ref.read(calendarProvider);
    return calendarState.selectedDate.isAtSameMomentAs(day);
  }

  void onDaySelected(selectedDay, focusedDay) {
    final calendarState = ref
        .read(calendarProvider.notifier)
        .updateSelectedDate(
            selectedDate: selectedDay, currentViewDate: selectedDay);
  }

  List eventLoader(day) {
    final hasEvents = ref.watch(eventProvider(day));
    return hasEvents;
  }
}
