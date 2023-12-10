part of 'results_view.dart';

class ResultsViewModel extends BaseViewModel {
  final log = getLogger('ResultsViewModel');
  bool _isExpanded = false;

  final List<List<bool>> _semesterButtonStates =
      List.generate(8, (_) => List.filled(4, false));

  int _selectedSemesterIndex = -1;

  List<bool> buttonPressedStates(int semesterIndex) {
    return _semesterButtonStates[semesterIndex] ?? List.filled(4, false);
  }

  void updateExpansionState(bool isExpanded) {
    _isExpanded = isExpanded;
    notifyListeners();
  }

  void updateButtonPressedState(int semesterIndex, int index, bool isPressed) {
    if (_selectedSemesterIndex != -1) {
      _semesterButtonStates[_selectedSemesterIndex] = List.filled(4, false);
    }

    _semesterButtonStates[semesterIndex][index] = isPressed;

    _selectedSemesterIndex = semesterIndex;

    notifyListeners();
  }

  Set<int> _expandedSemesterIndices = {};

  Set<int> get expandedSemesterIndices => _expandedSemesterIndices;

  void updateExpandedSemesterIndices(int semesterIndex, bool expanded) {
    if (expanded) {
      _expandedSemesterIndices.add(semesterIndex);
    } else {
      _expandedSemesterIndices.remove(semesterIndex);
    }
    notifyListeners();
  }
}
