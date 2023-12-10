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
      padding: EdgeInsets.symmetric(vertical: 8.r),
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        elevation: 0,
        clipBehavior: Clip.hardEdge,
        color: context.colorScheme.secondaryLPurpleColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course.courseName,
                style: FontThemeClass().heading2(context),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
              ),
              4.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          course.courseDesc,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: FontThemeClass().subHeading2(context,
                              context.colorScheme.secondarySectionColor),
                        ),
                        6.verticalSpace,
                        ElevatedButton(
                          onPressed: () {
                            UrlLauncher().launchURL(course.url);
                          },
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(
                              Size(130.w, 40.h),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                                context.colorScheme.primaryColor),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                            ),
                          ),
                          child: Text(
                            'Check Out',
                            style: FontThemeClass().subHeading(context,
                                context.colorScheme.secondaryWhiteColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  10.horizontalSpace,
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: CachedNetworkImageWidget(
                      fit: BoxFit.cover,
                      imageUrl: course.image,
                      height: 100.h,
                      width: 95.w,
                      maxHeightDiskCache: ResponsiveUtils.screenWidth(context),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
