part of 'timetable_view.dart';

class TimeTableViewModel extends BaseViewModel {
  final log = getLogger('TimeTableViewModel');
  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(this.selectedDay, selectedDay)) {
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
