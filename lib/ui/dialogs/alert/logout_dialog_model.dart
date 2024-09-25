part of 'logout_dialog.dart';

class LogoutDialogModel extends BaseViewModel {
  final log = getLogger('LogoutDialogModel');
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final _localStorageService = locator<LocalStorageService>();

  Future<void> logout() async {
    try {
      setBusy(true);
      final bool success = await _authenticationService.signOut().then((value) {
        return value;
      });
      if (success) {
        log.i('sign out success');
        await _navigationService.clearStackAndShow(Routes.authView);
        await _localStorageService.clear();
      } else {
        log.e('sign out failed');
      }
    } on Exception catch (e) {
      log.e(e.toString());
    } finally {
      setBusy(false);
    }
  }
}
