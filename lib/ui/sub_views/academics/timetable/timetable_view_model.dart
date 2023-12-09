part of 'timetable_view.dart';

class TimeTableViewModel extends BaseViewModel {
  final log = getLogger('TimeTableViewModel');
  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  DateTime getOneYearBack() {
    return DateTime.now().subtract(const Duration(days: 365));
  }

  DateTime getOneYearForward() {
    return DateTime.now().add(const Duration(days: 365));
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(this.selectedDay, selectedDay)) {
      debugPrint("Selected Day: $selectedDay");
      this.selectedDay = selectedDay;
      this.focusedDay = focusedDay;
    }
    notifyListeners();
  }

  void onFormatChanged(CalendarFormat format) {
    if (calendarFormat != format) {
      calendarFormat = format;
    }
    notifyListeners();
  }
}
