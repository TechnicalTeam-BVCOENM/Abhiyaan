import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'splash_view_model.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.nonReactive(
      viewModelBuilder: () => SplashViewModel(),
      onViewModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: context.colorScheme.scaffold,
          body: SafeArea(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Center(
                      // Centered logo
                      child: Image(
                        width: 320.w,
                        image: const AssetImage(
                          AssetImagePath.logoImg,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Version ${AppConstants.appVersion}',
                    style: FontThemeClass().caption(
                      context,
                      color: context.colorScheme.secondaryText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 18), // Additional spacing if needed
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
