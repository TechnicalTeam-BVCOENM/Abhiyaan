import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/services/auth_service.dart';
import 'package:abhiyaan/ui/views/auth/auth_view.dart';
import 'package:abhiyaan/ui/views/auth/onboarding/onboarding_view.dart';
import 'package:abhiyaan/ui/views/auth/register/register_view.dart';
import 'package:abhiyaan/ui/views/auth/sign_in/sign_in_view.dart';
import 'package:abhiyaan/ui/views/bottom_nav/bottom_nav_view.dart';
import 'package:abhiyaan/ui/views/community/clubs/clubs_view.dart';
import 'package:abhiyaan/ui/views/community/community_view.dart';
import 'package:abhiyaan/ui/views/community/detailed_blogs/detailed_blogs_view.dart';
import 'package:abhiyaan/ui/views/community/uni_clubs/uni_clubs_view.dart';
import 'package:abhiyaan/ui/views/event/detailed_event/detailed_event_view.dart';
import 'package:abhiyaan/ui/views/event/event_view.dart';
import 'package:abhiyaan/ui/views/event/expand_image/expand_image_view.dart';
import 'package:abhiyaan/ui/views/event/gallery/gallery_grid/gallery_view.dart';
import 'package:abhiyaan/ui/views/event/gallery/gallery_tab_view/gallery_tab_view.dart';
import 'package:abhiyaan/ui/views/profile/preferences/preferences_view.dart';
import 'package:abhiyaan/ui/views/profile/profile_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:abhiyaan/ui/views/home/home_view.dart';
import 'package:abhiyaan/ui/views/splash/splash_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: AuthView),
    MaterialRoute(page: ProfileView),
    MaterialRoute(page: PreferencesView),
    MaterialRoute(page: BottomNavView),
    MaterialRoute(page: EventView),
    MaterialRoute(page: DetailedEventView),
    MaterialRoute(page: SignInView),
    MaterialRoute(page: RegisterView),
    MaterialRoute(page: OnboardingView),
    MaterialRoute(page: CommunityView),
    MaterialRoute(page: ClubsView),
    MaterialRoute(page: UniClubsView),
    MaterialRoute(page: DettailedBlogPage),
    MaterialRoute(page: GalleryTabView),
    MaterialRoute(page: GalleryView),
    MaterialRoute(page: ExpandImageView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: LocalStorageService),
    LazySingleton(classType: ThemeService),
    LazySingleton(classType: AuthenticationService),
    LazySingleton(classType: AnalyticsService),
    Singleton(classType: BottomNavViewModel, asType: BottomNavViewModel),
    Singleton(classType: ProfileViewModel, asType: ProfileViewModel)
  ],
  logger: StackedLogger(),
)
class $AppRouter {}

// dart run build_runner build --delete-conflicting-outputs
