import 'package:abhiyaan/services/auth_service.dart';
import 'package:abhiyaan/services/local_storage_service.dart';
import 'package:abhiyaan/theme/theme_service.dart';
import 'package:abhiyaan/ui/views/auth/auth_view.dart';
import 'package:abhiyaan/ui/views/auth/onboarding/onboarding_view.dart';
import 'package:abhiyaan/ui/views/auth/register/register_view.dart';
import 'package:abhiyaan/ui/views/auth/sign_in/sign_in_view.dart';
import 'package:abhiyaan/ui/views/bottom_nav/bottom_nav_view.dart';
import 'package:abhiyaan/ui/views/community/clubs/clubs_view.dart';
import 'package:abhiyaan/ui/views/community/community_view.dart';
import 'package:abhiyaan/ui/views/event/detailed_event/detailed_event_view.dart';
import 'package:abhiyaan/ui/views/event/event_view.dart';
import 'package:abhiyaan/ui/views/notifications/notification_view.dart';
import 'package:abhiyaan/ui/views/profile/profile_view.dart';
import 'package:abhiyaan/ui/views/profile/settings/settings_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:abhiyaan/ui/views/home/home_view.dart';
import 'package:abhiyaan/ui/views/splash/splash_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: AuthView),
    MaterialRoute(page: ProfileView),
    MaterialRoute(page: SettingsView),
    MaterialRoute(page: BottomNavView),
    MaterialRoute(page: EventView),
    MaterialRoute(page: DetailedEventView),
    MaterialRoute(page: SignInView),
    MaterialRoute(page: RegisterView),
    MaterialRoute(page: OnboardingView),
    MaterialRoute(page: CommunityView),
    MaterialRoute(page: NotificationView),
    MaterialRoute(page: ClubsView),
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
