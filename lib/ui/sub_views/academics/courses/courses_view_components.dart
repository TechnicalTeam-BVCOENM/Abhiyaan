import 'package:darpan/file_exporter.dart';
import 'package:darpan/theme/responsive_utils.dart';
import 'package:darpan/ui/common/cached_network_image.dart';
import 'package:darpan/ui/common/common_component_model.dart';
import 'package:darpan/ui/sub_views/academics/courses/courses_view.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({super.key, required this.course});

  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        width: ResponsiveUtils.screenWidth(context),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 210.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      course.courseName,
                      style: FontThemeClass().heading4(context),
                    ),
                    SizedBox(
                      height: 5.sp,
                    ),
                    SizedBox(
                      height: 40.h,
                      child: Text(
                        course.courseDesc,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: true,
                        style: FontThemeClass().subHeading2(
                            context, context.colorScheme.secondary),
                      ),
                    ),
                    SizedBox(
                      height: 5.sp,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        UrlLauncher().launchURL(course.url);
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                          const Size(130, 40),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                            context.colorScheme.primaryColor),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      child: Text(
                        'Check out',
                        style: FontThemeClass().subHeading(
                            context, context.colorScheme.secondaryWhiteColor),
                      ),
                    ),
                  ],
                ),
              ),
              CachedNetworkImageWidget(
                imageUrl: course.image,
                height: 90.h,
                width: 90.w,
                maxHeightDiskCache: ResponsiveUtils.screenWidth(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}
