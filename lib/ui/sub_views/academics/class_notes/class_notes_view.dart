import 'package:darpan/file_exporter.dart';
part 'class_notes_view_model.dart';

class ClassNotesView extends StatelessWidget {
  const ClassNotesView({super.key});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ClassNotesViewModel>.reactive(
        viewModelBuilder: () => ClassNotesViewModel(),
        builder: (context, model, child) {
          return const Scaffold();
        });
  }
}
