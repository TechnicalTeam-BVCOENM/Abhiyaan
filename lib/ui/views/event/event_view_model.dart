part of 'event_view.dart';

class BrandModel {
  final String imageUrl;
  BrandModel({required this.imageUrl});
}

class EventViewModel extends BaseViewModel {
  // Variables
  final log = getLogger('EventViewModel');
  EventModel? todayEvent;
  List<EventModel> remainigEvents = [];
  // Init Method
  void init() {
    getTodaysEvent();
    getRemainingEvents();
  }

  // List
  final List<EventModel> eventsList = [
    EventModel(
      title: 'Abhiyaan',
      time: '10:00 AM',
      year: 2024,
      day: 17,
      month: 11,
      imageUrl:
          'https://imgs.search.brave.com/y2ve9MehABcSRTFjQYPcwpiFeueug4jPMSBV80j3lew/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXRteXVuaS5j/b20vYXp1cmUvY29s/bGVnZS1pbWFnZS9i/aWcvYmhhcmF0aS12/aWR5YXBlZXRocy1p/bnN0aXR1dGUtb2Yt/bWFuYWdlbWVudC1z/dHVkaWVzLXJlc2Vh/cmNoLWJ2aW1zci1t/dW1iYWkuanBn',
      location: 'Quadrangle',
    ),
    EventModel(
      title: 'CESA',
      time: '2:30 PM',
      year: 2023,
      day: 18,
      month: 11,
      imageUrl:
          'https://imgs.search.brave.com/naQcU43e9tgthZ_RRInjFZjKgnNxm8W09L3uTjUs44Q/rs:fit:860:0:0/g:ce/aHR0cHM6Ly93d3cu/YnZ1bml2ZXJzaXR5/LmVkdS5pbi9kb21t/dW1iYWkvaW1hZ2Vz/L2Fib3V0LWhvbWUu/anBn',
      location: 'Qudrangle',
    ),
    EventModel(
      title: 'CESA',
      time: '2:30 PM',
      year: 2023,
      day: 14,
      month: 11,
      imageUrl:
          'https://imgs.search.brave.com/naQcU43e9tgthZ_RRInjFZjKgnNxm8W09L3uTjUs44Q/rs:fit:860:0:0/g:ce/aHR0cHM6Ly93d3cu/YnZ1bml2ZXJzaXR5/LmVkdS5pbi9kb21t/dW1iYWkvaW1hZ2Vz/L2Fib3V0LWhvbWUu/anBn',
      location: 'Qudrangle',
    ),
    EventModel(
      title: 'CESA',
      time: '2:30 PM',
      year: 2023,
      day: 12,
      month: 12,
      imageUrl:
          'https://imgs.search.brave.com/naQcU43e9tgthZ_RRInjFZjKgnNxm8W09L3uTjUs44Q/rs:fit:860:0:0/g:ce/aHR0cHM6Ly93d3cu/YnZ1bml2ZXJzaXR5/LmVkdS5pbi9kb21t/dW1iYWkvaW1hZ2Vz/L2Fib3V0LWhvbWUu/anBn',
      location: 'Qudrangle',
    ),
    EventModel(
      title: 'CESA',
      time: '2:30 PM',
      year: 2024,
      day: 18,
      month: 1,
      imageUrl:
          'https://imgs.search.brave.com/naQcU43e9tgthZ_RRInjFZjKgnNxm8W09L3uTjUs44Q/rs:fit:860:0:0/g:ce/aHR0cHM6Ly93d3cu/YnZ1bml2ZXJzaXR5/LmVkdS5pbi9kb21t/dW1iYWkvaW1hZ2Vz/L2Fib3V0LWhvbWUu/anBn',
      location: 'Qudrangle',
    ),
  ];

  final List<BrandModel> brands = [
    BrandModel(
      imageUrl:
          'https://imgs.search.brave.com/PH2aMidbf55D3f5OjcucErBN-WaxA5R73Y87-bEZfns/rs:fit:860:0:0/g:ce/aHR0cHM6Ly91cGxv/YWQud2lraW1lZGlh/Lm9yZy93aWtpcGVk/aWEvY29tbW9ucy84/Lzg5L0xvZ28tQmVS/ZWFsLnBuZw',
    ),
    BrandModel(
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/en/thumb/d/d3/Starbucks_Corporation_Logo_2011.svg/1200px-Starbucks_Corporation_Logo_2011.svg.png',
    ),
    BrandModel(
      imageUrl:
          'https://e7.pngegg.com/pngimages/384/715/png-clipart-lokmat-pune-nashik-newspaper-lokmat-pune-thumbnail.png',
    ),
    BrandModel(
      imageUrl:
          'https://brandlogos.net/wp-content/uploads/2013/03/monster-energy-eps-vector-logo.png',
    ),

    // Add more BrandModel instances as needed
  ];

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

  void getTodaysEvent() {
    todayEvent = null; // Initialize todayEvent to null or a default value.

    for (EventModel event in eventsList) {
      DateTime now = DateTime.now();
      if (getMonthName(event.month, event.year) == getCurrentMonth() &&
          event.day == now.day &&
          event.year == now.year) {
        todayEvent = event;
        break;
      }
    }
  }

  void getRemainingEvents() {
    for (EventModel event in eventsList) {
      if (event.year > DateTime.now().year ||
          (event.year == DateTime.now().year &&
              (event.month > DateTime.now().month ||
                  (event.month == DateTime.now().month &&
                      event.day > DateTime.now().day)))) {
        remainigEvents.add(event);
      }
    }

    //Doc:  This is sorting according to year, month and date
    remainigEvents.sort((a, b) {
      int yearComparison = a.year.compareTo(b.year);
      if (yearComparison == 0) {
        int monthComparison = a.month.compareTo(b.month);
        if (monthComparison == 0) {
          return a.day.compareTo(b.day);
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
  String time;
  int day;
  int year;
  int month;
  String imageUrl;

  String location;

  EventModel({
    required this.title,
    required this.time,
    required this.day,
    required this.month,
    required this.year,
    required this.location,
    required this.imageUrl,
  });
}
