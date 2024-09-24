import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/services/auth_service.dart';
import 'package:abhiyaan/ui/bottom_sheets/event/event_sheet.dart';
import 'package:abhiyaan/ui/views/auth/auth_view.dart';
import 'package:abhiyaan/ui/views/auth/onboarding/onboarding_view.dart';
import 'package:abhiyaan/ui/views/auth/register/register_view.dart';
import 'package:abhiyaan/ui/views/auth/sign_in/sign_in_view.dart';
import 'package:abhiyaan/ui/views/bottom_nav/bottom_nav_view.dart';
import 'package:abhiyaan/ui/views/community/clubs/clubs_view.dart';
import 'package:abhiyaan/ui/views/community/community_view.dart';
import 'package:abhiyaan/ui/views/community/detailed_blogs/detailed_blogs_view.dart';
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

// @stacked-import
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
    MaterialRoute(page: DettailedBlogPage),
    MaterialRoute(page: GalleryTabView),
    MaterialRoute(page: GalleryView),
    MaterialRoute(page: ExpandImageView),
    // @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: ThemeService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: AnalyticsService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: LocalStorageService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: AuthenticationService),
    Singleton(classType: BottomNavViewModel, asType: BottomNavViewModel),
    Singleton(classType: ProfileViewModel, asType: ProfileViewModel),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: EventSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: AlertDialog),
    // @stacked-dialog
  ],
  logger: StackedLogger(),
)
class $AppRouter {}

// dart run build_runner build --delete-conflicting-outputs

// Don't remove the above comments. Those are used by the build system
