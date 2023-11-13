import 'package:darpan/file_exporter.dart';
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
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Add your photo here
                const Image(
                  image: AssetImage(AssetImagePath.logo),
                ),

                const SizedBox(
                    height:
                        16.0), // Add some space between the photo and the text
                Text('Darpan', // Your App name
                    style: FontThemeClass().heading(context)),
                const SizedBox(height: 8.0),
                Text('BVCOENM',
                    style: FontThemeClass().smallSubHeading(
                        context, context.colorScheme.secondaryBlackColor)),
              ],
            ),
          ),
        );
      },
    );
  }
}
