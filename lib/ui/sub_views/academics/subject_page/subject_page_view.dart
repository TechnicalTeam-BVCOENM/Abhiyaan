import 'package:darpan/file_exporter.dart';
part 'subject_page_view_model.dart';

class SubjectView extends StatelessWidget {
  const SubjectView({super.key});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SubjectViewModel>.reactive(
        viewModelBuilder: () => SubjectViewModel(),
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
              body: const Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text("data"),
              ));
        });
  }
}
