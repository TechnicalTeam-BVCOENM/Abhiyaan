part of 'bottom_nav_view.dart';

class BottomNavViewModel extends IndexTrackingViewModel {
  void init() {}

  Future<bool> onPop() async {
    return false;
  }

  Widget getViewForCurrentIndex(int index) {
    switch (index) {
      case 0:
        return const HomeView();
      case 1:
        return const CommunityView();
      case 2:
        return const EventView();
      case 3:
        return const ProfileView();
      default:
        return const HomeView();
    }
  }
}
