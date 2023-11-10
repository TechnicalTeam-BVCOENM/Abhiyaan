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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Add your photo here
              Image(
                image: AssetImage('assets/darpan_photo.png'),
              ),

              SizedBox(
                  height:
                      16.0), // Add some space between the photo and the text
              Text(
                'Darpan', // Your App name
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'BVCOENM',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color(0xFFD6D5FA),);
      },
    );
  }
}
