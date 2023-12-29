part of 'event_view.dart';

class EventViewModel extends BaseViewModel {
  final log = getLogger('EventViewModel');
  final FirestoreService _firestoreService = FirestoreService();
  final _navigationService = locator<NavigationService>();
  List<SponsorsModel> _sponsors = [];
  List<SponsorsModel> get sponsors => _sponsors;
  List<EventModel> _events = [];
  List<EventModel> get events => _events;
  EventModel? _todayEvent;
  EventModel? get todayEvent => _todayEvent;
  late final List<EventModel> _upcomingEvents = [];
  List<EventModel> get upcomingEvents => _upcomingEvents;

  var carouselOptions = CarouselOptions(
    scrollPhysics: const BouncingScrollPhysics(),
    autoPlayCurve: Curves.easeInOutCubic,
    enableInfiniteScroll: true,
    autoPlay: true,
    autoPlayInterval: 4.seconds,
    autoPlayAnimationDuration: 1.seconds,
    pauseAutoPlayOnTouch: true,
    pauseAutoPlayInFiniteScroll: true,
    viewportFraction: 0.65,
  );

  void init() async {
    await loadData();
  }

  navigateToDetailedEventView() {
    _navigationService.navigateTo(Routes.detailedEventView);
  }

  Future<void> loadData() async {

    try {
      _events = await runBusyFuture(_firestoreService.getAllEvents());
      getRemainingEvents();
      notifyListeners();
      getTodaysEvent();
      _sponsors = await _firestoreService.getAllSponsors();
      notifyListeners();
    } catch (e) {
      log.e("Error Loading Sponsors: ${e.toString()}");
    }
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

  void getRemainingEvents() {
    for (EventModel event in events) {
      DateTime now = DateTime.now();
      int month = event.startDate.toDate().month;
      int year = event.startDate.toDate().year;
      int day = event.startDate.toDate().day;
      if (year > now.year ||
          (year == now.year &&
              (month > now.month || (month == now.month && day > now.day)))) {
        upcomingEvents.add(event);
        notifyListeners();
      }
    }
    upcomingEvents.sort(
      (a, b) {
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
      },
    );
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
  String registerUrl;

  EventModel(
      {required this.title,
      required this.startDate,
      required this.endDate,
      required this.location,
      required this.imageUrl,
      required this.cName,
      required this.cEmail,
      required this.cPhone,
      required this.about,
      required this.registerUrl});
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
