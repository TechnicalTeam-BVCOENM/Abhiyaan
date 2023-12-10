import 'package:darpan/file_exporter.dart';
import 'package:darpan/services/firestore_service.dart';
import 'package:darpan/ui/sub_views/academics/syllabus/syllabus_view_component.dart';
part 'syllabus_view_model.dart';

class SyllabusView extends StatelessWidget {
  const SyllabusView({super.key});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SyllabusViewModel>.reactive(
        viewModelBuilder: () => SyllabusViewModel(),
        onViewModelReady: (viewModel) => viewModel.loadData(),
        builder: (context, model, child) {
          return Scaffold(
              backgroundColor: context.colorScheme.backgroundColor,
              appBar: AppBar(
                title: Text(
                  'Syllabus',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.headingColor,
                  ),
                ),
                centerTitle: true,
                iconTheme: IconThemeData(
                  color: context.colorScheme.iconColor,
                ),
                backgroundColor: context.colorScheme.backgroundColor,
              ),
              body: subjectCard(
                  model.syllabus, model.syllabus.length, context, model));
        });
  }
}
