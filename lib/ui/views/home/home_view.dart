import 'package:darpan/file_exporter.dart';

part 'home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: Center(
            child: Text(model.s),
          ),
        );
      },
    );
  }
}
