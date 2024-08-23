class CalendarState {
  DateTime selectedDate;
  DateTime currentViewDate;

  CalendarState({
    required this.selectedDate,
    required this.currentViewDate,
  });

  CalendarState copyWith({
    DateTime? currentViewDate,
    DateTime? selectedDate,
  }) {
    return CalendarState(
      currentViewDate: currentViewDate ?? this.currentViewDate,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}
