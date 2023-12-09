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

  List<LectureDataModel> get lectureDataList => _lectureDataList;
  final List<LectureDataModel> _lectureDataList = [
    LectureDataModel(
        startTime: Timestamp.fromDate(DateTime.parse("2023-09-01 02:00:00")),
        subjectName: "Maths",
        subjectTeacherName: "Mr. Sharma"),
    LectureDataModel(
        startTime: Timestamp.fromDate(DateTime.parse("2021-09-01 02:00:00")),
        subjectName: "Science",
        subjectTeacherName: "Mr. Sharma"),
    LectureDataModel(
        startTime: Timestamp.fromDate(DateTime.parse("2021-09-01 11:00:00")),
        subjectName: "English",
        subjectTeacherName: "Mr. Sharma"),
    LectureDataModel(
        startTime: Timestamp.fromDate(DateTime.parse("2021-09-01 22:00:00")),
        subjectName: "Hindi",
        subjectTeacherName: "Mr. Sharma"),
    LectureDataModel(
        startTime: Timestamp.fromDate(DateTime.parse("2021-09-01 23:00:00")),
        subjectName: "Social Science",
        subjectTeacherName: "Mr. Sharma"),
  ];
}

class LectureDataModel {
  late final Timestamp startTime;
  late final String subjectName;
  late final String subjectTeacherName;

  LectureDataModel(
      {required this.startTime,
      required this.subjectName,
      required this.subjectTeacherName});
}
