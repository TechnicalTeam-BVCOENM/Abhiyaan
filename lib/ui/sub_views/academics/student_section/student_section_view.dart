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
                  const SizedBox(height: 20), // Spacer
                  Text(
                    'Stay tuned for Version 2.0.0.',
                    style: TextStyle(
                      fontSize: 16,
                      color: context.colorScheme.onBackground, // Subtitle color
                    ),
                  ),
                  const SizedBox(height: 30), // Spacer

                  // Back Button
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    iconSize: 50,
                    color: context.colorScheme.primaryColor,
                    onPressed: () {
                      // Implement your back button logic here
                      Navigator.of(context)
                          .pop(); // For example, pops the current screen
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
