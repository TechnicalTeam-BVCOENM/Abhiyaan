part of '../detailed_event/detailed_event_view.dart';

class DetailedEventViewModel extends BaseViewModel {
  final log = getLogger('DetailedEventView');

  final _navigationService = locator<NavigationService>();

  navigateToEventView() {
    _navigationService.replaceWith(Routes.profileView);
  }
}
