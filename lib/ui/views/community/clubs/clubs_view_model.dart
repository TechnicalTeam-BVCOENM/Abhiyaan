part of '../clubs/clubs_view.dart';

class ClubsViewModel extends BaseViewModel {
  final DepartmentalClubsData clubsData;
  ClubsViewModel(this.clubsData);

  final log = getLogger('ClubsView');
  final _navigationService = locator<NavigationService>();

  navigateToEventView() {
    _navigationService.replaceWith(Routes.profileView);
  }
}
