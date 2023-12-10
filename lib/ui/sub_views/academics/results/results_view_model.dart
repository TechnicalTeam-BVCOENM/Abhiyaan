part of 'results_view.dart';

class ResultsViewModel extends BaseViewModel {
  final FirestoreService _firestoreService = FirestoreService();
  final log = getLogger('ResultsViewModel');
  // bool _isExpanded = false;

  final List<List<bool>> _semesterButtonStates =
      List.generate(8, (_) => List.filled(4, false));

  int _selectedSemesterIndex = -1;

  List<bool> buttonPressedStates(int semesterIndex) {
    return _semesterButtonStates[semesterIndex];
  }

  // void updateExpansionState(bool isExpanded) {
  //   _isExpanded = isExpanded;
  //   notifyListeners();
  // }

  void updateButtonPressedState(int semesterIndex, int index, bool isPressed) {
    if (_selectedSemesterIndex != -1) {
      _semesterButtonStates[_selectedSemesterIndex] = List.filled(4, false);
    }

    _semesterButtonStates[semesterIndex][index] = isPressed;

    _selectedSemesterIndex = semesterIndex;

    notifyListeners();
  }

  final Set<int> _expandedSemesterIndices = {};

  Set<int> get expandedSemesterIndices => _expandedSemesterIndices;

  void updateExpandedSemesterIndices(int semesterIndex, bool expanded) {
    if (expanded) {
      _expandedSemesterIndices.add(semesterIndex);
    } else {
      _expandedSemesterIndices.remove(semesterIndex);
    }
    notifyListeners();
  }

  List<ResultModel> results = [
    ResultModel(
        ut1Link: 'example.com',
        ut2Link: 'example.com',
        gazetteLink: 'example.com',
        marksheetLink: 'example.com')
  ];

  Future<void> fetchResults() async {
    setBusy(true);
    try {
      results = await _firestoreService.getSemesterResults();
      // print(results[0].gazetteLink.toString());
      notifyListeners();
      // Notify listeners or update your view model state as needed
    } catch (e) {
      // Handle errors
    }
    setBusy(false);
  }
}

class ResultModel {
  String ut1Link;
  String ut2Link;
  String gazetteLink;
  String marksheetLink;

  ResultModel({
    required this.ut1Link,
    required this.ut2Link,
    required this.gazetteLink,
    required this.marksheetLink,
  });
}
