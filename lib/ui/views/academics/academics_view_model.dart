part of 'academics_view.dart';

class AcademicsViewModel extends BaseViewModel {
  final FirestoreService _firestoreService = FirestoreService();
  final fontTheme = FontThemeClass();
  final _navigationService = locator<NavigationService>();

  List<AcademicsUpdates> _academicsUpdates = [];
  List<AcademicsUpdates> get academicsUpdates => _academicsUpdates;

  Future<void> loadData() async {
    setBusy(true);
    try {
      _academicsUpdates =
          await _firestoreService.getAllAcademicData('academicUpdates');
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
    Future.delayed(const Duration(milliseconds: 1000), () {
      setBusy(false);
    });
  }

  final List<GridListModel> _gridListModel = [
    GridListModel(
        title: "Timetable",
        image: AssetImagePath.timetableImg,
        route: const TimeTableView()),
    GridListModel(
        title: "Syllabus",
        image: AssetImagePath.syllabusImg,
        route: const SyllabusView()),
    GridListModel(
        title: "Student Section",
        image: AssetImagePath.studentSectionImg,
        route: const StudentSectionView()),
    GridListModel(
        title: "Class Notes",
        image: AssetImagePath.classNotesImg,
        route: const ClassNotesView()),
    GridListModel(
        title: "Practicals",
        image: AssetImagePath.practicalsImg,
        route: const PracticalsView()),
    GridListModel(
        title: "PYQ's", image: AssetImagePath.pyqsImg, route: const PyqsView()),
    GridListModel(
        title: "Courses",
        image: AssetImagePath.coursesImg,
        route: const CoursesView()),
    GridListModel(
        title: "Results",
        image: AssetImagePath.resultsImg,
        route: const ResultsView()),
    GridListModel(
        title: "Attendance",
        image: AssetImagePath.attendanceImg,
        route: const AttendanceView()),
  ];

  List<GridListModel> get getGridListModel => _gridListModel;
}

class GridListModel {
  late String title;
  late String image;
  late Widget route;
  GridListModel({
    required this.title,
    required this.image,
    required this.route,
  });
}

// Academics Updates Model
class AcademicsUpdates {
  late String title;
  late String description;
  late Timestamp date;
  AcademicsUpdates({
    required this.title,
    required this.description,
    required this.date,
  });
}
