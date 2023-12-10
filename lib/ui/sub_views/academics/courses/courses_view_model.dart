part of 'courses_view.dart';

class CoursesViewModel extends BaseViewModel {
  final log = getLogger('CoursesViewModel');
  final FirestoreService _firestoreService = FirestoreService();
  final fontTheme = FontThemeClass();
  List<CourseModel> courses = [];

// Get all courses
  Future<void> getCourses() async {
    setBusy(true);
    try {
      courses = await _firestoreService.getAllCourses();
      courses.shuffle(); //to display courses randomly
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
    setBusy(false);
  }
}

//Courses model
class CourseModel {
  final String courseName;
  final String courseDesc;
  final String image;
  final String url;
  CourseModel({
    required this.courseName,
    required this.courseDesc,
    required this.image,
    required this.url,
  });
}
