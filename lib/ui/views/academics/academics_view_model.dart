part of 'academics_view.dart';

class AcademicsViewModel extends BaseViewModel {
  final FirestoreService _firestoreService = FirestoreService();
  final fontTheme = FontThemeClass();

  List<AcademicsUpdates> _academicsUpdates = [];
  List<AcademicsUpdates> get academicsUpdates => _academicsUpdates;

  Future<void> loadData() async {
    setBusy(true);
    try {
      _academicsUpdates = await _firestoreService.getAllAcademicData('academicUpdates');
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
    setBusy(false);
  }

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
}

// Academics Updates Model
class AcademicsUpdates {
  late String title;
  late String description;
  late Timestamp date;
  bool isExpanded;
  double expandedHeight;
  int maxLines;
  bool overflow;

  AcademicsUpdates({
    required this.title,
    required this.description,
    required this.date,
    this.isExpanded = false,
    this.expandedHeight = 100.0,
    this.maxLines = 2,
    this.overflow = true,
  });
}
