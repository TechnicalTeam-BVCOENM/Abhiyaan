part of '../clubs/clubs_view.dart';

class ClubsViewModel extends BaseViewModel {
  final DepartmentalClubsData clubsData;
final AnalyticsService _analyticsService = locator<AnalyticsService>();
  
  ClubsViewModel(this.clubsData);

  void init(){
  _analyticsService.logScreen(screenName: 'Departmental Clubs Screen Opened');
  }

  final log = getLogger('ClubsView');
  final _navigationService = locator<NavigationService>();

  navigateToEventView() {
    _navigationService.replaceWith(Routes.profileView);
  }
}
