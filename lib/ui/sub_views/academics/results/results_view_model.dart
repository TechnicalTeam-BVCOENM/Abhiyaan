part of 'results_view.dart';

class ResultsViewModel extends BaseViewModel {
  final log = getLogger('ResultsViewModel');
  bool _isExpanded = false;

  // List to store button pressed states for each semester
  final List<List<bool>> _semesterButtonStates =
      List.generate(8, (_) => List.filled(4, false));

  // Variable to track the currently selected semester
  int _selectedSemesterIndex = -1;

  bool get isExpanded => _isExpanded;
  int get selectedSemesterIndex => _selectedSemesterIndex;

  List<bool> buttonPressedStates(int semesterIndex) {
    return _semesterButtonStates[semesterIndex] ?? List.filled(4, false);
  }

  void updateExpansionState(bool isExpanded) {
    _isExpanded = isExpanded;
    notifyListeners();
  }

  void updateButtonPressedState(int semesterIndex, int index, bool isPressed) {
    // Reset the pressed state for the previous semester buttons
    if (_selectedSemesterIndex != -1) {
      _semesterButtonStates[_selectedSemesterIndex] = List.filled(4, false);
    }

    _semesterButtonStates[semesterIndex][index] = isPressed;

    _selectedSemesterIndex = semesterIndex;

    notifyListeners();
  }
}
