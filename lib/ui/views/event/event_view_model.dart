// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'event_view.dart';

class EventViewModel extends BaseViewModel {
  final log = getLogger('EventViewModel');
  final FirestoreService _firestoreService = FirestoreService();
  final _navigationService = locator<NavigationService>();
  final _analyticsService = locator<AnalyticsService>();
  EventDetails eventDetails = EventDetails();
  FontThemeClass fontTheme = FontThemeClass();

  List<SponsorsModel> _sponsors = [];
  List<MemoriesModel> _bestMemories = [];
  List<SponsorsModel> get sponsors => _sponsors;
  List<MemoriesModel> get bestMemories => _bestMemories;
  List<EventModel> _events = [];
  List<GalleryModel> _gallery = [];
  List<EventModel> get events => _events;
  List<GalleryModel> get gallery => _gallery;
  final List<EventModel> _todayEvent = [];
  List<EventModel>? get todayEvent => _todayEvent;
  late final List<EventModel> _upcomingEvents = [];
  List<EventModel> get upcomingEvents => _upcomingEvents;

  var sponsorsCarosoulOptions = CarouselOptions(
    scrollPhysics: const BouncingScrollPhysics(),
    autoPlayCurve: Curves.easeInOutCubic,
    enableInfiniteScroll: true,
    autoPlay: true,
    autoPlayInterval: 4.seconds,
    autoPlayAnimationDuration: 4.seconds,
    pauseAutoPlayOnTouch: true,
    pauseAutoPlayInFiniteScroll: true,
    viewportFraction: 0.25,
    height: 80.h,
  );

  var upcommingCarosoulOptions = CarouselOptions(
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
  var ongoingCarosoulOptions = CarouselOptions(
    height: 280.h,
    scrollPhysics: const BouncingScrollPhysics(),
    autoPlayCurve: Curves.easeInOutCubic,
    enableInfiniteScroll: true,
    autoPlay: true,
    autoPlayInterval: 6.seconds,
    autoPlayAnimationDuration: 1.seconds,
    pauseAutoPlayOnTouch: true,
    pauseAutoPlayInFiniteScroll: true,
    viewportFraction: 1,
  );

  void init() async {
    _analyticsService.logScreen(screenName: "Event Screen Opened");
    await loadData();
  }

  navigateToDetailedEventView() {
    _navigationService.navigateTo(Routes.detailedEventView);
  }

  Future<void> loadData() async {
    try {
      _events = await runBusyFuture(_firestoreService.getAllEvents());
      getTodaysEvent();
      getRemainingEvents();
      sortEventsByDateTime(events);
      _gallery = await runBusyFuture(_firestoreService.getGalleryImages());
      _gallery.sort((a, b) => b.year.compareTo(a.year));
      _sponsors = await _firestoreService.getAllSponsors();
      _bestMemories = await runBusyFuture(_firestoreService.getAllMemories());
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

  void setTodayEvent(EventModel event) {
    _todayEvent.add(event);
    notifyListeners();
  }

  void getTodaysEvent() {
    for (EventModel event in events) {
      DateTime now = DateTime.now();
      int month = event.startDate.toDate().month;
      int year = event.startDate.toDate().year;
      int day = event.startDate.toDate().day;
      if (getMonthName(month, year) == getCurrentMonth() &&
          day == now.day &&
          year == now.year) {
        setTodayEvent(event);
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
void sortEventsByDateTime(List<EventModel> events) {
  events.sort((a, b) {
    int dateComparison = a.startDate.toDate().compareTo(b.startDate.toDate());
    if (dateComparison == 0) {
      return a.endDate.toDate().compareTo(b.endDate.toDate());
    }
    return dateComparison;
  });
}

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
  String docID;

  EventModel({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.imageUrl,
    required this.location,
    required this.cName,
    required this.cEmail,
    required this.cPhone,
    required this.about,
    required this.registerUrl,
    required this.docID,
  });

  // Factory constructor to create an EventModel from a Firestore document
  factory EventModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return EventModel(
      title: data['title'] ?? '',
      startDate: data['startDate'] ?? Timestamp.now(),
      endDate: data['endDate'] ?? Timestamp.now(),
      imageUrl: data['imageUrl'] ?? '',
      location: data['location'] ?? '',
      cName: data['cName'] ?? '',
      cEmail: data['cEmail'] ?? '',
      cPhone: data['cPhone'] ?? 0,
      about: data['about'] ?? '',
      registerUrl: data['registerUrl'] ?? '',
      docID: doc.id,
    );
  }

  // Convert an EventModel instance to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'startDate': startDate,
      'endDate': endDate,
      'imageUrl': imageUrl,
      'location': location,
      'cName': cName,
      'cEmail': cEmail,
      'cPhone': cPhone,
      'about': about,
      'registerUrl': registerUrl,
    };
  }

  // Factory constructor to create an EventModel from a JSON Map
  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      title: json['title'] ?? '',
      startDate: json['startDate'] ?? Timestamp.now(),
      endDate: json['endDate'] ?? Timestamp.now(),
      imageUrl: json['imageUrl'] ?? '',
      location: json['location'] ?? '',
      cName: json['cName'] ?? '',
      cEmail: json['cEmail'] ?? '',
      cPhone: json['cPhone'] ?? 0,
      about: json['about'] ?? '',
      registerUrl: json['registerUrl'] ?? '',
      docID: json['docID'] ?? '',
    );
  }

  // Convert an EventModel instance to a JSON Map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'startDate': startDate,
      'endDate': endDate,
      'imageUrl': imageUrl,
      'location': location,
      'cName': cName,
      'cEmail': cEmail,
      'cPhone': cPhone,
      'about': about,
      'registerUrl': registerUrl,
      'docID': docID,
    };
  }
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

class GalleryModel {
  final String logoUrl;
  final String themeName;
  final int year;
  final Map<String, dynamic> abhiyaan;
  final Map<String, dynamic> cultural;
  final Map<String, dynamic> sports;

  GalleryModel({
    required this.logoUrl,
    required this.themeName,
    required this.year,
    required this.abhiyaan,
    required this.cultural,
    required this.sports,
  });

  factory GalleryModel.fromJson(Map<String, dynamic> json) {
    return GalleryModel(
      logoUrl: json['LogoUrl'] ?? "",
      themeName: json['ThemeName'] ?? "",
      year: json['year'] ?? 0,
      abhiyaan: json['abhiyaan'] ?? {},
      cultural: json['cultural'] ?? {},
      sports: json['sports'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'LogoUrl': logoUrl,
      'ThemeName': themeName,
      'year': year,
      'abhiyaan': abhiyaan,
      'cultural': cultural,
      'sports': sports,
    };
  }
}

class MemoriesModel {
  String imageUrl;
  MemoriesModel({
    required this.imageUrl,
  });
}
