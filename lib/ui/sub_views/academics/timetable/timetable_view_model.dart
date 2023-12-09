part of 'timetable_view.dart';

class TimeTableViewModel extends BaseViewModel {
  final log = getLogger('TimeTableViewModel');

  List<LectureDataModel> get lectureDataList => _lectureDataList;
  final List<LectureDataModel> _lectureDataList = [
    LectureDataModel(
        startTime: Timestamp.fromDate(DateTime.parse("2021-09-01 09:00:00")),
        subjectName: "Maths",
        subjectTeacherName: "Mr. Sharma"),
    LectureDataModel(
        startTime: Timestamp.fromDate(DateTime.parse("2021-09-01 10:00:00")),
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
