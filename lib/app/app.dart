import 'package:darpan/services/auth_service.dart';
import 'package:darpan/services/local_storage_service.dart';
import 'package:darpan/theme/theme_service.dart';
import 'package:darpan/ui/sub_views/academics/attendance/attendance_view.dart';
import 'package:darpan/ui/sub_views/academics/class_notes/class_notes_view.dart';
import 'package:darpan/ui/sub_views/academics/courses/courses_view.dart';
import 'package:darpan/ui/sub_views/academics/practicals/practicals_view.dart';
import 'package:darpan/ui/sub_views/academics/pyqs/pyqs_view.dart';
import 'package:darpan/ui/sub_views/academics/results/results_view.dart';
import 'package:darpan/ui/sub_views/academics/student_section/student_section_view.dart';
import 'package:darpan/ui/sub_views/academics/syllabus/syllabus_view.dart';
import 'package:darpan/ui/sub_views/academics/timetable/timetable_view.dart';
import 'package:darpan/ui/views/academics/academics_view.dart';
import 'package:darpan/ui/views/auth/auth_view.dart';
import 'package:darpan/ui/views/bottom_nav/bottom_nav_view.dart';
import 'package:darpan/ui/sub_views/event/detailed_event_view.dart';
import 'package:darpan/ui/views/event/event_view.dart';
import 'package:darpan/ui/views/profile/profile_view.dart';
import 'package:darpan/ui/views/settings/settings_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:darpan/ui/views/home/home_view.dart';
import 'package:darpan/ui/views/splash/splash_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: AcademicsView),
    MaterialRoute(page: AuthView),
    MaterialRoute(page: ProfileView),
    MaterialRoute(page: SettingsView),
    MaterialRoute(page: BottomNavView),
    MaterialRoute(page: EventView),
    MaterialRoute(page: DetailedEventView),
    MaterialRoute(page: TimeTableView),
    MaterialRoute(page: SyllabusView),
    MaterialRoute(page: StudentSectionView),
    MaterialRoute(page: ResultsView),
    MaterialRoute(page: PyqsView),
    MaterialRoute(page: PracticalsView),
    MaterialRoute(page: ClassNotesView),
    MaterialRoute(page: AttendanceView),
    MaterialRoute(page: CoursesView)
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: LocalStorageService),
    LazySingleton(classType: ThemeService),
    LazySingleton(classType: AuthenticationService)
  ],
  logger: StackedLogger(),
)
class $AppRouter {}

//flutter pub run build_runner build --delete-conflicting-outputs
