part of 'academics_view.dart';

class AcademicsViewModel extends BaseViewModel {
  final fontTheme = FontThemeClass();

  final gridListTitle = [
    "Timetable",
    "Syllabus",
    "Student Section",
    "Class Notes",
    "Practicals",
    "PYQ's",
    "Courses",
    "Results",
    "Attendance",
  ];

  final gridListImages = [
    AssetImagePath.timetableImg,
    AssetImagePath.syllabusImg,
    AssetImagePath.studentSectionImg,
    AssetImagePath.classNotesImg,
    AssetImagePath.practicalsImg,
    AssetImagePath.pyqsImg,
    AssetImagePath.coursesImg,
    AssetImagePath.resultsImg,
    AssetImagePath.attendanceImg,
  ];

  final List<AcademicsUpdates> academicsUpdatesList = [
    AcademicsUpdates(
      title: "Term Test 1",
      postedOn: "29-7-2023",
      description: "Practical exam is hold from 8th of August to 10th of August.",
    ),
    AcademicsUpdates(
      title: "Term Test 2",
      postedOn: "10-10-2023",
      description: "Practical exam is hold from 19th of October to 22nd of October.",
    ),
    AcademicsUpdates(
      title: "Practical Timetable",
      postedOn: "Today",
      description: "Practical exam is hold from 31st of October to 5th of November.",
    ),
    AcademicsUpdates(
      title: "Semester Timetable",
      postedOn: "Today",
      description: "Semester exam is hold from 5th of November to 18th of November.",
    ),
  ];
}

// Academics Updates Model
class AcademicsUpdates {
  late String title;
  late String postedOn;
  late String description;

  AcademicsUpdates({
    required this.title,
    required this.postedOn,
    required this.description,
  });
}
