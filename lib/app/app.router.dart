// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:darpan/file_exporter.dart' as _i21;
import 'package:darpan/ui/sub_views/academics/attendance/attendance_view.dart'
    as _i18;
import 'package:darpan/ui/sub_views/academics/class_notes/class_notes_view.dart'
    as _i17;
import 'package:darpan/ui/sub_views/academics/courses/courses_view.dart'
    as _i19;
import 'package:darpan/ui/sub_views/academics/practicals/practicals_view.dart'
    as _i16;
import 'package:darpan/ui/sub_views/academics/pyqs/pyqs_view.dart' as _i15;
import 'package:darpan/ui/sub_views/academics/results/results_view.dart'
    as _i14;
import 'package:darpan/ui/sub_views/academics/student_section/student_section_view.dart'
    as _i13;
import 'package:darpan/ui/sub_views/academics/syllabus/syllabus_view.dart'
    as _i12;
import 'package:darpan/ui/sub_views/academics/timetable/timetable_view.dart'
    as _i11;
import 'package:darpan/ui/sub_views/event/detailed_event_view.dart' as _i10;
import 'package:darpan/ui/views/academics/academics_view.dart' as _i4;
import 'package:darpan/ui/views/auth/auth_view.dart' as _i5;
import 'package:darpan/ui/views/bottom_nav/bottom_nav_view.dart' as _i8;
import 'package:darpan/ui/views/event/event_view.dart' as _i9;
import 'package:darpan/ui/views/home/home_view.dart' as _i3;
import 'package:darpan/ui/views/profile/profile_view.dart' as _i6;
import 'package:darpan/ui/views/settings/settings_view.dart' as _i7;
import 'package:darpan/ui/views/splash/splash_view.dart' as _i2;
import 'package:flutter/material.dart' as _i20;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i22;

class Routes {
  static const splashView = '/';

  static const homeView = '/home-view';

  static const academicsView = '/academics-view';

  static const authView = '/auth-view';

  static const profileView = '/profile-view';

  static const settingsView = '/settings-view';

  static const bottomNavView = '/bottom-nav-view';

  static const eventView = '/event-view';

  static const detailedEventView = '/detailed-event-view';

  static const timeTableView = '/time-table-view';

  static const syllabusView = '/syllabus-view';

  static const studentSectionView = '/student-section-view';

  static const resultsView = '/results-view';

  static const pyqsView = '/pyqs-view';

  static const practicalsView = '/practicals-view';

  static const classNotesView = '/class-notes-view';

  static const attendanceView = '/attendance-view';

  static const coursesView = '/courses-view';

  static const all = <String>{
    splashView,
    homeView,
    academicsView,
    authView,
    profileView,
    settingsView,
    bottomNavView,
    eventView,
    detailedEventView,
    timeTableView,
    syllabusView,
    studentSectionView,
    resultsView,
    pyqsView,
    practicalsView,
    classNotesView,
    attendanceView,
    coursesView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.splashView,
      page: _i2.SplashView,
    ),
    _i1.RouteDef(
      Routes.homeView,
      page: _i3.HomeView,
    ),
    _i1.RouteDef(
      Routes.academicsView,
      page: _i4.AcademicsView,
    ),
    _i1.RouteDef(
      Routes.authView,
      page: _i5.AuthView,
    ),
    _i1.RouteDef(
      Routes.profileView,
      page: _i6.ProfileView,
    ),
    _i1.RouteDef(
      Routes.settingsView,
      page: _i7.SettingsView,
    ),
    _i1.RouteDef(
      Routes.bottomNavView,
      page: _i8.BottomNavView,
    ),
    _i1.RouteDef(
      Routes.eventView,
      page: _i9.EventView,
    ),
    _i1.RouteDef(
      Routes.detailedEventView,
      page: _i10.DetailedEventView,
    ),
    _i1.RouteDef(
      Routes.timeTableView,
      page: _i11.TimeTableView,
    ),
    _i1.RouteDef(
      Routes.syllabusView,
      page: _i12.SyllabusView,
    ),
    _i1.RouteDef(
      Routes.studentSectionView,
      page: _i13.StudentSectionView,
    ),
    _i1.RouteDef(
      Routes.resultsView,
      page: _i14.ResultsView,
    ),
    _i1.RouteDef(
      Routes.pyqsView,
      page: _i15.PyqsView,
    ),
    _i1.RouteDef(
      Routes.practicalsView,
      page: _i16.PracticalsView,
    ),
    _i1.RouteDef(
      Routes.classNotesView,
      page: _i17.ClassNotesView,
    ),
    _i1.RouteDef(
      Routes.attendanceView,
      page: _i18.AttendanceView,
    ),
    _i1.RouteDef(
      Routes.coursesView,
      page: _i19.CoursesView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.SplashView(),
        settings: data,
      );
    },
    _i3.HomeView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.HomeView(),
        settings: data,
      );
    },
    _i4.AcademicsView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.AcademicsView(),
        settings: data,
      );
    },
    _i5.AuthView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.AuthView(),
        settings: data,
      );
    },
    _i6.ProfileView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.ProfileView(),
        settings: data,
      );
    },
    _i7.SettingsView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.SettingsView(),
        settings: data,
      );
    },
    _i8.BottomNavView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.BottomNavView(),
        settings: data,
      );
    },
    _i9.EventView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.EventView(),
        settings: data,
      );
    },
    _i10.DetailedEventView: (data) {
      final args = data.getArgs<DetailedEventViewArguments>(nullOk: false);
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i10.DetailedEventView(key: args.key, eventData: args.eventData),
        settings: data,
      );
    },
    _i11.TimeTableView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i11.TimeTableView(),
        settings: data,
      );
    },
    _i12.SyllabusView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i12.SyllabusView(),
        settings: data,
      );
    },
    _i13.StudentSectionView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i13.StudentSectionView(),
        settings: data,
      );
    },
    _i14.ResultsView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i14.ResultsView(),
        settings: data,
      );
    },
    _i15.PyqsView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i15.PyqsView(),
        settings: data,
      );
    },
    _i16.PracticalsView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i16.PracticalsView(),
        settings: data,
      );
    },
    _i17.ClassNotesView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i17.ClassNotesView(),
        settings: data,
      );
    },
    _i18.AttendanceView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i18.AttendanceView(),
        settings: data,
      );
    },
    _i19.CoursesView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i19.CoursesView(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class DetailedEventViewArguments {
  const DetailedEventViewArguments({
    this.key,
    required this.eventData,
  });

  final _i21.Key? key;

  final _i9.EventModel eventData;

  @override
  String toString() {
    return '{"key": "$key", "eventData": "$eventData"}';
  }

  @override
  bool operator ==(covariant DetailedEventViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.eventData == eventData;
  }

  @override
  int get hashCode {
    return key.hashCode ^ eventData.hashCode;
  }
}

extension NavigatorStateExtension on _i22.NavigationService {
  Future<dynamic> navigateToSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAcademicsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.academicsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAuthView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.authView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSettingsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.settingsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToBottomNavView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.bottomNavView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEventView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.eventView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDetailedEventView({
    _i21.Key? key,
    required _i9.EventModel eventData,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.detailedEventView,
        arguments: DetailedEventViewArguments(key: key, eventData: eventData),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTimeTableView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.timeTableView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSyllabusView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.syllabusView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStudentSectionView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.studentSectionView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToResultsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.resultsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPyqsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.pyqsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPracticalsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.practicalsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToClassNotesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.classNotesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAttendanceView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.attendanceView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCoursesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.coursesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAcademicsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.academicsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAuthView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.authView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSettingsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.settingsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithBottomNavView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.bottomNavView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEventView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.eventView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDetailedEventView({
    _i21.Key? key,
    required _i9.EventModel eventData,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.detailedEventView,
        arguments: DetailedEventViewArguments(key: key, eventData: eventData),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTimeTableView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.timeTableView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSyllabusView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.syllabusView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStudentSectionView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.studentSectionView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithResultsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.resultsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPyqsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.pyqsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPracticalsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.practicalsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithClassNotesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.classNotesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAttendanceView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.attendanceView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCoursesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.coursesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
