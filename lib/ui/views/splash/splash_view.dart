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
          backgroundColor: context.colorScheme.backgroundColor,
          body: SafeArea(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Expanded(
                    child: Center(
                      // Centered logo
                      child: Image(
                        image: AssetImage(AssetImagePath.logoImg),
                      ),
                    ),
                  ),
                  Text(
                    'Version 1.0.0',
                    style: FontThemeClass().caption(
                      context,
                      color: context.colorScheme.headingColor,
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
