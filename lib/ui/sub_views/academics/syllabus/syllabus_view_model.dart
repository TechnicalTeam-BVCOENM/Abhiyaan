part of 'syllabus_view.dart';

class SyllabusViewModel extends BaseViewModel {
  final log = getLogger('SyllabusViewModel');
  final fontTheme = FontThemeClass();
  final FirestoreService _firestoreService = FirestoreService();
  List<Syllabus> syllabus = [];
  List<Syllabus> get academicsUpdates => syllabus;
  Future<void> loadData() async {
    setBusy(true);
    try {
      syllabus = await _firestoreService.getAllSyllabus('Department');
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
    Future.delayed(const Duration(milliseconds: 1000), () {
      setBusy(false);
    });
  }
}

class Syllabus {
  late String subjectName;
  late String imageUrl;
  Syllabus({
    required this.subjectName,
    required this.imageUrl,
  });
}
