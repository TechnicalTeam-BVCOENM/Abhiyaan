import 'package:darpan/file_exporter.dart';
part 'practicals_view_model.dart';

class PracticalsView extends StatelessWidget {
  const PracticalsView({super.key});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PracticalsViewModel>.reactive(
        viewModelBuilder: () => PracticalsViewModel(),
        builder: (context, model, child) {
          return const Scaffold();
        });
  }
}
