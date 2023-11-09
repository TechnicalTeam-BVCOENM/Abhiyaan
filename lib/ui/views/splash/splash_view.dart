import 'package:darpan/file_exporter.dart';
part 'splash_view_model.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.nonReactive(
      viewModelBuilder: () => SplashViewModel(),
      onViewModelReady: (model) => model.init(context),
      builder: (context, model, child) {
        return const Scaffold(
            body: Center(
          child: Text("On Splash Screen"),
        ));
      },
    );
  }
}
