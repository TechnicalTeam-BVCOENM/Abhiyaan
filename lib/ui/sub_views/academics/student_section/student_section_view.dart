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
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: context
                    .colorScheme.secondaryBlackColor, //change your color here
              ),
              backgroundColor: context.colorScheme.backgroundColor,
              elevation: 0,
              title: Text(
                'Student Section',
                style: FontThemeClass().heading2(context),
              ),
              centerTitle: true,
            ),
            backgroundColor:
                context.colorScheme.backgroundColor, // Background color
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        Text(
                          'Amazingness in Progress, Stay Tuned!',
                          style: TextStyle(
                            fontSize: 22,

                            color:
                                context.colorScheme.primaryColor, // Text color
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40), // Spacer

                  // Back Button
                  IconButton(
                    icon: const Icon(Icons.arrow_circle_left_outlined),
                    iconSize: 90,
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
