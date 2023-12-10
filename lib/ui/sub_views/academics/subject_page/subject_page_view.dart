import 'package:darpan/file_exporter.dart';
import 'package:darpan/ui/common/common_component_model.dart';
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
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ElevatedButton(
                    onPressed: () {
                      UrlLauncher externalUrlHandler = UrlLauncher();
                      externalUrlHandler.launchURL(
                          "https://www.vidyalankar.org/engineering/assets/docs/be/computer-engineering-syllabus-sem-vii-mumbai-university.pdf");
                    },
                    child: const SizedBox(
                        width: double.infinity - 100,
                        height: 40,
                        child: Center(child: Text("click here for Syllabus")))),
              ));
        });
  }
}
