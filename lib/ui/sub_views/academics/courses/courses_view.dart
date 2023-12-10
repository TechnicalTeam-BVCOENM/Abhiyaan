import 'package:darpan/file_exporter.dart';
import 'package:darpan/services/firestore_service.dart';
import 'package:darpan/theme/responsive_utils.dart';
import 'package:darpan/ui/common/shimmer.dart';
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
            backgroundColor: context.colorScheme.backgroundColor,
            appBar: AppBar(
              foregroundColor: context.colorScheme.primaryDarkColor,
              backgroundColor: context.colorScheme.backgroundColor,
              elevation: 0,
              title: Text(
                'Courses',
                style: model.fontTheme.appBarText(context),
              ),
              centerTitle: true,
            ),
            body: model.isBusy
                ? const ShimmerLoadingWidget()
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Container(
                      color: context.colorScheme.backgroundColor,
                      margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      height: ResponsiveUtils.screenHeight(context),
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: model.courses.length,
                          itemBuilder: (context, index) {
                            return CourseCard(course: model.courses[index]);
                          }),
                    )),
          );
        });
  }
}
