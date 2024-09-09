// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:abhiyaan/file_exporter.dart' as _i21;
import 'package:abhiyaan/ui/views/auth/auth_view.dart' as _i4;
import 'package:abhiyaan/ui/views/auth/onboarding/onboarding_view.dart' as _i12;
import 'package:abhiyaan/ui/views/auth/register/register_view.dart' as _i11;
import 'package:abhiyaan/ui/views/auth/sign_in/sign_in_view.dart' as _i10;
import 'package:abhiyaan/ui/views/bottom_nav/bottom_nav_view.dart' as _i7;
import 'package:abhiyaan/ui/views/community/clubs/clubs_view.dart' as _i14;
import 'package:abhiyaan/ui/views/community/community_view.dart' as _i13;
import 'package:abhiyaan/ui/views/community/detailed_blogs/detailed_blogs_view.dart'
    as _i16;
import 'package:abhiyaan/ui/views/community/uni_clubs/uni_clubs_view.dart'
    as _i15;
import 'package:abhiyaan/ui/views/event/detailed_event/detailed_event_view.dart'
    as _i9;
import 'package:abhiyaan/ui/views/event/event_view.dart' as _i8;
import 'package:abhiyaan/ui/views/event/expand_image/expand_image_view.dart'
    as _i19;
import 'package:abhiyaan/ui/views/event/gallery/gallery_grid/gallery_view.dart'
    as _i18;
import 'package:abhiyaan/ui/views/event/gallery/gallery_tab_view/gallery_tab_view.dart'
    as _i17;
import 'package:abhiyaan/ui/views/home/home_view.dart' as _i3;
import 'package:abhiyaan/ui/views/profile/preferences/preferences_view.dart'
    as _i6;
import 'package:abhiyaan/ui/views/profile/profile_view.dart' as _i5;
import 'package:abhiyaan/ui/views/splash/splash_view.dart' as _i2;
import 'package:flutter/material.dart' as _i20;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i22;

class Routes {
  static const splashView = '/';

  static const homeView = '/home-view';

  static const authView = '/auth-view';

  static const profileView = '/profile-view';

  static const preferencesView = '/preferences-view';

  static const bottomNavView = '/bottom-nav-view';

  static const eventView = '/event-view';

  static const detailedEventView = '/detailed-event-view';

  static const signInView = '/sign-in-view';

  static const registerView = '/register-view';

  static const onboardingView = '/onboarding-view';

  static const communityView = '/community-view';

  static const clubsView = '/clubs-view';

  static const uniClubsView = '/uni-clubs-view';

  static const dettailedBlogPage = '/dettailed-blog-page';

  static const galleryTabView = '/gallery-tab-view';

  static const galleryView = '/gallery-view';

  static const expandImageView = '/expand-image-view';

  static const all = <String>{
    splashView,
    homeView,
    authView,
    profileView,
    preferencesView,
    bottomNavView,
    eventView,
    detailedEventView,
    signInView,
    registerView,
    onboardingView,
    communityView,
    clubsView,
    uniClubsView,
    dettailedBlogPage,
    galleryTabView,
    galleryView,
    expandImageView,
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
      Routes.authView,
      page: _i4.AuthView,
    ),
    _i1.RouteDef(
      Routes.profileView,
      page: _i5.ProfileView,
    ),
    _i1.RouteDef(
      Routes.preferencesView,
      page: _i6.PreferencesView,
    ),
    _i1.RouteDef(
      Routes.bottomNavView,
      page: _i7.BottomNavView,
    ),
    _i1.RouteDef(
      Routes.eventView,
      page: _i8.EventView,
    ),
    _i1.RouteDef(
      Routes.detailedEventView,
      page: _i9.DetailedEventView,
    ),
    _i1.RouteDef(
      Routes.signInView,
      page: _i10.SignInView,
    ),
    _i1.RouteDef(
      Routes.registerView,
      page: _i11.RegisterView,
    ),
    _i1.RouteDef(
      Routes.onboardingView,
      page: _i12.OnboardingView,
    ),
    _i1.RouteDef(
      Routes.communityView,
      page: _i13.CommunityView,
    ),
    _i1.RouteDef(
      Routes.clubsView,
      page: _i14.ClubsView,
    ),
    _i1.RouteDef(
      Routes.uniClubsView,
      page: _i15.UniClubsView,
    ),
    _i1.RouteDef(
      Routes.dettailedBlogPage,
      page: _i16.DettailedBlogPage,
    ),
    _i1.RouteDef(
      Routes.galleryTabView,
      page: _i17.GalleryTabView,
    ),
    _i1.RouteDef(
      Routes.galleryView,
      page: _i18.GalleryView,
    ),
    _i1.RouteDef(
      Routes.expandImageView,
      page: _i19.ExpandImageView,
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
    _i4.AuthView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.AuthView(),
        settings: data,
      );
    },
    _i5.ProfileView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.ProfileView(),
        settings: data,
      );
    },
    _i6.PreferencesView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.PreferencesView(),
        settings: data,
      );
    },
    _i7.BottomNavView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.BottomNavView(),
        settings: data,
      );
    },
    _i8.EventView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.EventView(),
        settings: data,
      );
    },
    _i9.DetailedEventView: (data) {
      final args = data.getArgs<DetailedEventViewArguments>(nullOk: false);
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i9.DetailedEventView(key: args.key, eventData: args.eventData),
        settings: data,
      );
    },
    _i10.SignInView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.SignInView(),
        settings: data,
      );
    },
    _i11.RegisterView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i11.RegisterView(),
        settings: data,
      );
    },
    _i12.OnboardingView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i12.OnboardingView(),
        settings: data,
      );
    },
    _i13.CommunityView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i13.CommunityView(),
        settings: data,
      );
    },
    _i14.ClubsView: (data) {
      final args = data.getArgs<ClubsViewArguments>(nullOk: false);
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i14.ClubsView(key: args.key, clubsData: args.clubsData),
        settings: data,
      );
    },
    _i15.UniClubsView: (data) {
      final args = data.getArgs<UniClubsViewArguments>(nullOk: false);
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => _i15.UniClubsView(
            key: args.key, universalClubsData: args.universalClubsData),
        settings: data,
      );
    },
    _i16.DettailedBlogPage: (data) {
      final args = data.getArgs<DettailedBlogPageArguments>(nullOk: false);
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i16.DettailedBlogPage(key: args.key, blogData: args.blogData),
        settings: data,
      );
    },
    _i17.GalleryTabView: (data) {
      final args = data.getArgs<GalleryTabViewArguments>(nullOk: false);
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i17.GalleryTabView(key: args.key, gallery: args.gallery),
        settings: data,
      );
    },
    _i18.GalleryView: (data) {
      final args = data.getArgs<GalleryViewArguments>(nullOk: false);
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => _i18.GalleryView(
            key: args.key, images: args.images, title: args.title),
        settings: data,
      );
    },
    _i19.ExpandImageView: (data) {
      final args = data.getArgs<ExpandImageViewArguments>(nullOk: false);
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i19.ExpandImageView(key: args.key, imageUrl: args.imageUrl),
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

  final _i8.EventModel eventData;

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

class ClubsViewArguments {
  const ClubsViewArguments({
    this.key,
    required this.clubsData,
  });

  final _i21.Key? key;

  final _i13.DepartmentalClubsData clubsData;

  @override
  String toString() {
    return '{"key": "$key", "clubsData": "$clubsData"}';
  }

  @override
  bool operator ==(covariant ClubsViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.clubsData == clubsData;
  }

  @override
  int get hashCode {
    return key.hashCode ^ clubsData.hashCode;
  }
}

class UniClubsViewArguments {
  const UniClubsViewArguments({
    this.key,
    required this.universalClubsData,
  });

  final _i21.Key? key;

  final _i13.UniversalClubsData universalClubsData;

  @override
  String toString() {
    return '{"key": "$key", "universalClubsData": "$universalClubsData"}';
  }

  @override
  bool operator ==(covariant UniClubsViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.universalClubsData == universalClubsData;
  }

  @override
  int get hashCode {
    return key.hashCode ^ universalClubsData.hashCode;
  }
}

class DettailedBlogPageArguments {
  const DettailedBlogPageArguments({
    this.key,
    required this.blogData,
  });

  final _i21.Key? key;

  final _i13.CommunityBlogsData blogData;

  @override
  String toString() {
    return '{"key": "$key", "blogData": "$blogData"}';
  }

  @override
  bool operator ==(covariant DettailedBlogPageArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.blogData == blogData;
  }

  @override
  int get hashCode {
    return key.hashCode ^ blogData.hashCode;
  }
}

class GalleryTabViewArguments {
  const GalleryTabViewArguments({
    this.key,
    required this.gallery,
  });

  final _i21.Key? key;

  final _i8.GalleryModel gallery;

  @override
  String toString() {
    return '{"key": "$key", "gallery": "$gallery"}';
  }

  @override
  bool operator ==(covariant GalleryTabViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.gallery == gallery;
  }

  @override
  int get hashCode {
    return key.hashCode ^ gallery.hashCode;
  }
}

class GalleryViewArguments {
  const GalleryViewArguments({
    this.key,
    required this.images,
    required this.title,
  });

  final _i21.Key? key;

  final List<dynamic> images;

  final String title;

  @override
  String toString() {
    return '{"key": "$key", "images": "$images", "title": "$title"}';
  }

  @override
  bool operator ==(covariant GalleryViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.images == images && other.title == title;
  }

  @override
  int get hashCode {
    return key.hashCode ^ images.hashCode ^ title.hashCode;
  }
}

class ExpandImageViewArguments {
  const ExpandImageViewArguments({
    this.key,
    required this.imageUrl,
  });

  final _i21.Key? key;

  final String imageUrl;

  @override
  String toString() {
    return '{"key": "$key", "imageUrl": "$imageUrl"}';
  }

  @override
  bool operator ==(covariant ExpandImageViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return key.hashCode ^ imageUrl.hashCode;
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

  Future<dynamic> navigateToPreferencesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.preferencesView,
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
    required _i8.EventModel eventData,
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

  Future<dynamic> navigateToSignInView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.signInView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToRegisterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.registerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOnboardingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.onboardingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCommunityView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.communityView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToClubsView({
    _i21.Key? key,
    required _i13.DepartmentalClubsData clubsData,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.clubsView,
        arguments: ClubsViewArguments(key: key, clubsData: clubsData),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToUniClubsView({
    _i21.Key? key,
    required _i13.UniversalClubsData universalClubsData,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.uniClubsView,
        arguments: UniClubsViewArguments(
            key: key, universalClubsData: universalClubsData),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDettailedBlogPage({
    _i21.Key? key,
    required _i13.CommunityBlogsData blogData,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.dettailedBlogPage,
        arguments: DettailedBlogPageArguments(key: key, blogData: blogData),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToGalleryTabView({
    _i21.Key? key,
    required _i8.GalleryModel gallery,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.galleryTabView,
        arguments: GalleryTabViewArguments(key: key, gallery: gallery),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToGalleryView({
    _i21.Key? key,
    required List<dynamic> images,
    required String title,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.galleryView,
        arguments: GalleryViewArguments(key: key, images: images, title: title),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToExpandImageView({
    _i21.Key? key,
    required String imageUrl,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.expandImageView,
        arguments: ExpandImageViewArguments(key: key, imageUrl: imageUrl),
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

  Future<dynamic> replaceWithPreferencesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.preferencesView,
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
    required _i8.EventModel eventData,
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

  Future<dynamic> replaceWithSignInView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.signInView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithRegisterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.registerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithOnboardingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.onboardingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCommunityView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.communityView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithClubsView({
    _i21.Key? key,
    required _i13.DepartmentalClubsData clubsData,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.clubsView,
        arguments: ClubsViewArguments(key: key, clubsData: clubsData),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithUniClubsView({
    _i21.Key? key,
    required _i13.UniversalClubsData universalClubsData,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.uniClubsView,
        arguments: UniClubsViewArguments(
            key: key, universalClubsData: universalClubsData),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDettailedBlogPage({
    _i21.Key? key,
    required _i13.CommunityBlogsData blogData,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.dettailedBlogPage,
        arguments: DettailedBlogPageArguments(key: key, blogData: blogData),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithGalleryTabView({
    _i21.Key? key,
    required _i8.GalleryModel gallery,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.galleryTabView,
        arguments: GalleryTabViewArguments(key: key, gallery: gallery),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithGalleryView({
    _i21.Key? key,
    required List<dynamic> images,
    required String title,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.galleryView,
        arguments: GalleryViewArguments(key: key, images: images, title: title),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithExpandImageView({
    _i21.Key? key,
    required String imageUrl,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.expandImageView,
        arguments: ExpandImageViewArguments(key: key, imageUrl: imageUrl),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
