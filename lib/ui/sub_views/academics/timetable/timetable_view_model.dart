part of 'timetable_view.dart';

class TimeTableViewModel extends BaseViewModel {
  final log = getLogger('TimeTableViewModel');
  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();
  DateTime now = DateTime.now();
  late String todaysDay;

  DateTime getOneYearBack() {
    return DateTime.now().subtract(const Duration(days: 365));
  }

  DateTime getOneYearForward() {
    return DateTime.now().add(const Duration(days: 365));
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(this.selectedDay, selectedDay)) {
      loadData(selectedDay.weekday);
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

  List<LectureDataModel> _lectureDataList = [];
  List<LectureDataModel> get lectureDataList => _lectureDataList;

  String getDayName(int index) {
    switch (index) {
      case 1:
        return "mon";
      case 2:
        return "tue";
      case 3:
        return "wed";
      case 4:
        return "thu";
      case 5:
        return "fri";
      default:
        return "holiday";
    }
  }

  Future<void> loadData(int day) async {
    setBusy(true);
    try {
      final FirestoreService firestoreService = FirestoreService();
      todaysDay = getDayName(day);
      List<LectureDataModel> lectureData =
          await firestoreService.getTimeTableData(todaysDay);
      lectureData.sort((a, b) => a.startTime.compareTo(b.startTime));
      _lectureDataList = lectureData;
      debugPrint(_lectureDataList.toString());
      notifyListeners();
    } catch (e) {
      log.e(e);
    }
    setBusy(false);
  }

  void init() {
    loadData(now.weekday);
  }

  int _activeIndex = 0;
  int get activeIndex => _activeIndex;
  void updateActiveIndex(int newIndex) {
    _activeIndex = newIndex;
    notifyListeners();
  }

  bool isLecturePassed(int index) {
    if (selectedDay.day == DateTime.now().day) {
      return _lectureDataList[index].startTime.toDate().hour <
          DateTime.now().hour;
    } else {
      return selectedDay.day < DateTime.now().day;
    }
  }
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
