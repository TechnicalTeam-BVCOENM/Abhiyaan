part of '../detailed_event/detailed_event_view.dart';

class DetailedEventViewModel extends BaseViewModel {
  final EventModel eventData;
  int activeIndex = 0;
  final FirestoreService _firestoreService = FirestoreService();
  FontThemeClass fontThemeClass = FontThemeClass();
  List<Map<String, dynamic>> _bestMoments = [];
  List<Map<String, dynamic>> get bestMoments => _bestMoments;
  DetailedEventViewModel(this.eventData);
  final log = getLogger('DetailedEventView');
  final _navigationService = locator<NavigationService>();
  Future<void> getbestMoments() async {
    _bestMoments = await _firestoreService.getBestMoments(eventData.docID);
    notifyListeners();
  }

  navigateToEventView() {
    _navigationService.replaceWith(Routes.profileView);
  }

  void updateActiveIndex(int newIndex) {
    try {
      activeIndex = newIndex;
      notifyListeners();
    } on Exception catch (e) {
      log.e("Error in updating active index : ${e.toString()}");
    }
  }
}
