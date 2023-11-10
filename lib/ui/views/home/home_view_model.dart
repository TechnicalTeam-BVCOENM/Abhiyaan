part of 'home_view.dart';

class HomeViewModel extends BaseViewModel {
  final log = getLogger('HomeViewModel');
  String user = "Sachin";
  int currentIndex = 3;
}

class DepartmentUpdates {
  late String name;
  late String description;
  late String date;

  DepartmentUpdates({
    required this.name,
    required this.description,
    required this.date,
  });

}