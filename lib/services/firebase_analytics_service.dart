import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  Future logLogin(String method) async {
    await _analytics.logLogin(loginMethod: method);
  }

  Future logScreen({required String screenName}) async {
    await _analytics.logScreenView(screenName: screenName);
  }

  Future logSignUp({required String method}) async {
    await _analytics.logSignUp(signUpMethod: method);
  }

  Future logEvent({required String eventName, required String value}) async {
    await _analytics.logEvent(
      name: eventName,
      parameters: {'value': value},
    );
  }

  Future setUserProperties({required String userId}) async {
    await _analytics.setUserId(id: userId);
  }
}
