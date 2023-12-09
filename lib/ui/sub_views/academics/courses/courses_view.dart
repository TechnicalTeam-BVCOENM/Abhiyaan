import 'package:darpan/file_exporter.dart';
part 'courses_view_model.dart';

class CoursesView extends StatelessWidget {
  const CoursesView({super.key});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CoursesViewModel>.reactive(
        viewModelBuilder: () => CoursesViewModel(),
        builder: (context, model, child) {
          return const Scaffold();
        });
  }
}
