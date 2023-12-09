import 'package:darpan/file_exporter.dart';
part 'syllabus_view_model.dart';

class SyllabusView extends StatelessWidget {
  const SyllabusView({super.key});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SyllabusViewModel>.reactive(
        viewModelBuilder: () => SyllabusViewModel(),
        builder: (context, model, child) {
          return const Scaffold();
        });
  }
}
