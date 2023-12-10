import 'package:darpan/file_exporter.dart';
part 'results_view_model.dart';

class ResultsView extends StatelessWidget {
  const ResultsView({super.key});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ResultsViewModel>.reactive(
        viewModelBuilder: () => ResultsViewModel(),
        builder: (context, model, child) {
          return const Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: [Center(child: Text("Results"))],
                ),
              ),
            ),
          );
        });
  }
}
