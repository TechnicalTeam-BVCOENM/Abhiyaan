import 'dart:ui';

import 'package:abhiyaan/file_exporter.dart';

class ScreenLoader with ChangeNotifier {
  final log = getLogger("ScreenLoader");
  bool isLoaderActive = false;

  final _overlay =
      OverlayEntry(builder: (context) => const _ScreenLoadingWidget());

  void startLoader() {
    if (isLoaderActive) return;
    try {
      StackedService.navigatorKey!.currentState!.overlay!.insert(_overlay);
      isLoaderActive = true;
      notifyListeners();
    } catch (e) {
      log.e("Error is $e");
    }
  }

  void stopLoader() {
    if (isLoaderActive) {
      isLoaderActive = false;
      _overlay.remove();
    }
    notifyListeners();
  }
}

class _ScreenLoadingWidget extends StatelessWidget {
  const _ScreenLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Center(
              child: SizedBox(
                height: 40.h,
                width: 40.w,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  color: context.colorScheme.accentColor,
                  strokeWidth: 6.w,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
