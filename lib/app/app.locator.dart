// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/ui/views/bottom_nav/bottom_nav_view.dart';
import 'package:abhiyaan/ui/views/profile/profile_view.dart';
import 'package:stacked_shared/stacked_shared.dart';

import '../services/auth_service.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => LocalStorageService());
  locator.registerLazySingleton(() => ThemeService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => AnalyticsService());
  locator.registerSingleton<BottomNavViewModel>(BottomNavViewModel());
  locator.registerSingleton<ProfileViewModel>(ProfileViewModel());
}
