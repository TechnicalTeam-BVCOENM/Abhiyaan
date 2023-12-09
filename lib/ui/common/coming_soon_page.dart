import 'package:darpan/file_exporter.dart';
import 'package:darpan/ui/sub_views/academics/student_section/student_section_view.dart';

class StudentSectionView extends StatelessWidget {
  const StudentSectionView({super.key});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StudentSectionViewModel>.reactive(
        viewModelBuilder: () => StudentSectionViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor:
                context.colorScheme.backgroundColor, // Background color
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Coming Soon !',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.primaryColor, // Text color
                    ),
                  ),
                  const SizedBox(height: 50), // Spacer
                  Text(
                    'Sorry for the inconvenience caused.',
                    style: TextStyle(
                      fontSize: 16,
                      color: context.colorScheme.onBackground, // Subtitle color
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
