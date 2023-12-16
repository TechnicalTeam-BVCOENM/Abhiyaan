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
          backgroundColor: context.colorScheme.backgroundColor,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Add your photo here
                const Image(
                  image: AssetImage(AssetImagePath.logoImg),
                ),

                const SizedBox(
                    height:
                        16.0), // Add some space between the photo and the text
                Text('Darpan', // Your App name
                    style: FontThemeClass().header(context)),
                const SizedBox(height: 8.0),
                Text('BVCOENM',
                    style: FontThemeClass().title(context,
                        color: context.colorScheme.secondaryBlackColor)),
              ],
            ),
          ),
        );
      },
    );
  }
}
