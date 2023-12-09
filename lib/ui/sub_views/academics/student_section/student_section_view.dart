import 'package:darpan/file_exporter.dart';
part 'student_section_view_model.dart';

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
                  SizedBox(height: 50), // Spacer
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
