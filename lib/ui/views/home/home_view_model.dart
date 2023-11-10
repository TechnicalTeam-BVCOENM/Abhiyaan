part of 'home_view.dart';

class HomeViewModel extends BaseViewModel {
  final log = getLogger('HomeViewModel');
  String user = "Sachin";
  int currentIndex = 3;

  final PageController pageController = PageController();
  List<DepartmentUpdates> departmentUpdatesList = [
    DepartmentUpdates(
        name: "Placement",
        description:
            "A TCS company will be arrived on 17 of December 2023.  This company require Software Develop",
        date: "Today"),
    DepartmentUpdates(
        name: "Placement",
        description:
            "A TCS company will be arrived on 17 of December 2023.  This company require Software Develop",
        date: "20-08-23"),
    DepartmentUpdates(
        name: "Placement",
        description:
            "A TCS company will be arrived on 17 of December 2023.  This company require Software Develop",
        date: "18-09-23"),
  ];
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
