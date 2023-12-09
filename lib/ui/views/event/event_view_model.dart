part of 'event_view.dart';

class EventViewModel extends BaseViewModel {
  final FirestoreService _firestoreService = FirestoreService();
  final log = getLogger('EventViewModel');

  final _navigationService = locator<NavigationService>();

  navigateToDetailedEventView() {
    _navigationService.navigateTo(Routes.detailedEventView);
  }

  // Init Method
  void init() async {
    await loadData();
  }

  List<SponsorsModel> _sponsors = [];
  List<SponsorsModel> get sponsors => _sponsors;
  List<EventModel> _events = [];
  List<EventModel> get events => _events;

  Future<void> loadData() async {
    setBusy(true);
    try {
      _sponsors = await _firestoreService.getAllSponsors();
      _events = await _firestoreService.getAllEvents();
      getTodaysEvent();
      getRemainingEvents();
      log.i(_events[0].title);
      notifyListeners();
    } catch (e) {
      log.e(e);
    }
    setBusy(false);
    log.i("Sponsors Loaded");
  }

  // Methods
  String getCurrentMonth() {
    int currentMonthNumber = DateTime.now().month;
    int currentYear = DateTime.now().year;
    String currentMonth = DateFormat('MMMM')
        .format(DateTime(currentYear, currentMonthNumber, 1))
        .substring(0, 3);
    return currentMonth;
  }

  String getMonthName(currentMonthNumber, currentYear) {
    String currentMonth = DateFormat('MMMM')
        .format(DateTime(currentYear, currentMonthNumber, 1))
        .substring(0, 3);
    return currentMonth;
  }

  late EventModel? _todayEvent;
  EventModel? get todayEvent => _todayEvent;
  EventModel? setTodayEvent(EventModel? event) {
    _todayEvent = event;
    notifyListeners();
    return null;
  }

  void getTodaysEvent() {
    setTodayEvent(null);
    for (EventModel event in events) {
      DateTime now = DateTime.now();
      int month = event.startDate.toDate().month;
      int year = event.startDate.toDate().year;
      int day = event.startDate.toDate().day;
      if (getMonthName(month, year) == getCurrentMonth() &&
          day == now.day &&
          year == now.year) {
        setTodayEvent(event);
        break;
      }
    }
  }

  late final List<EventModel> _remainigEvents = [];
  List<EventModel> get remainigEvents => _remainigEvents;
  void getRemainingEvents() {
    for (EventModel event in events) {
      DateTime now = DateTime.now();
      int month = event.startDate.toDate().month;
      int year = event.startDate.toDate().year;
      int day = event.startDate.toDate().day;
      if (year > now.year ||
          (year == now.year &&
              (month > now.month || (month == now.month && day > now.day)))) {
        remainigEvents.add(event);
        for (EventModel event in remainigEvents) {
          log.i(event.title);
        }
        notifyListeners();
      }
    }

    //Doc:  This is sorting according to year, month and date
    remainigEvents.sort((a, b) {
      int yearComparison =
          a.startDate.toDate().year.compareTo(b.startDate.toDate().year);
      if (yearComparison == 0) {
        int monthComparison =
            a.startDate.toDate().month.compareTo(b.startDate.toDate().month);
        if (monthComparison == 0) {
          return a.startDate.toDate().day.compareTo(b.startDate.toDate().day);
        }
        return monthComparison;
      }
      return yearComparison;
    });
  }
}

// Models
class EventModel {
  String title;
  Timestamp startDate;
  Timestamp endDate;
  String imageUrl;
  String location;
  String cName;
  String cEmail;
  int cPhone;
  String about;

  EventModel({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.imageUrl,
    required this.cName,
    required this.cEmail,
    required this.cPhone,
    required this.about,
  });
}

class SponsorsModel {
  String title;
  String imageUrl;
  String url;

  SponsorsModel({
    required this.title,
    required this.url,
    required this.imageUrl,
  });
}
