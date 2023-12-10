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
            appBar: AppBar(),
            backgroundColor: context.colorScheme.backgroundColor,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Coming Soon !',
                    style: FontThemeClass().heading(context,
                        color: context.colorScheme.primaryColor),
                  ),
                  4.verticalSpace,
                  Text(
                    'Amazingness in progress. Stay tuned !',
                    style: FontThemeClass().subHeading2(
                        context, context.colorScheme.secondarySectionColor),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
