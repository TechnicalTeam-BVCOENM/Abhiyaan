import 'package:darpan/file_exporter.dart';
import 'package:darpan/services/firestore_service.dart';
import 'package:darpan/ui/sub_views/academics/courses/courses_view_components.dart';
part 'courses_view_model.dart';

class CoursesView extends StatelessWidget {
  const CoursesView({super.key});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CoursesViewModel>.reactive(
      viewModelBuilder: () => CoursesViewModel(),
      onViewModelReady: (viewModel) => viewModel.getCourses(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Courses',
              style: FontThemeClass().heading(context),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18).r,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: model.courses.length,
                itemBuilder: (context, index) {
                  return CourseCard(course: model.courses[index]);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
