part of 'splash_view.dart';

class SplashViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final log = getLogger('SplashViewModel');

  void init(BuildContext context) async {
    await Future.delayed(3.seconds);
    _navigationService.navigateTo(Routes.homeView);
  }
}
