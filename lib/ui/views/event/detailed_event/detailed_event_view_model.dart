part of '../detailed_event/detailed_event_view.dart';

class DetailedEventViewModel extends BaseViewModel {
  final log = getLogger('DetailedEventView');
  final EventModel eventData;
  final FirestoreService _firestoreService = FirestoreService();
  final _analyticsService = locator<AnalyticsService>();
  FontThemeClass fontThemeClass = FontThemeClass();

  int activeIndex = 0;
  List<Map<String, dynamic>> _bestMoments = [];
  List<Map<String, dynamic>> get bestMoments => _bestMoments;
  DetailedEventViewModel(this.eventData);

  void init() {
    _analyticsService.logScreen(screenName: 'Detailed Event Screen Opened');
    getbestMoments();
  }

  Future<void> getbestMoments() async {
    _bestMoments = await _firestoreService.getBestMoments(eventData.docID);
    notifyListeners();
  }

  void updateActiveIndex(int newIndex) {
    try {
      activeIndex = newIndex;
      notifyListeners();
    } on Exception catch (e) {
      log.e("Error in updating active index : ${e.toString()}");
    }
  }

  Future shareEvent(EventModel eventData) async {
    _analyticsService.logEvent(
        eventName: "Share_Event",
        value:
            "${eventData.title} Event Share button clicked : ${eventData.docID}");
    await Share.share(
        'Check out this event on Abhiyaan App\n\n${eventData.title}\n${eventData.about}\n${DateFormat('dd-MM-yyyy').format(eventData.startDate.toDate())} to ${DateFormat('dd-MM-yyyy').format(eventData.endDate.toDate())}\n${eventData.location}\n\nContact Details:\n${eventData.cName}\n${eventData.cEmail}\n${eventData.cPhone}\n\n${eventData.registerUrl}');
  }
}
