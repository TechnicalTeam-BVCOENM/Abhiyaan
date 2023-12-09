import 'package:darpan/file_exporter.dart';
part 'pyqs_view_model.dart';

class PyqsView extends StatelessWidget {
  const PyqsView({super.key});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PyqsViewModel>.reactive(
        viewModelBuilder: () => PyqsViewModel(),
        builder: (context, model, child) {
          return const Scaffold();
        });
  }
}
