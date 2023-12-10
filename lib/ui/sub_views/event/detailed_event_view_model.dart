part of '../event/detailed_event_view.dart';

class DetailedEventViewModel extends BaseViewModel {
  final EventModel eventData;
  DetailedEventViewModel(this.eventData);
  
  final log = getLogger('DetailedEventView');
  final _navigationService = locator<NavigationService>();

  navigateToEventView() {
    _navigationService.replaceWith(Routes.profileView);
  }
}
