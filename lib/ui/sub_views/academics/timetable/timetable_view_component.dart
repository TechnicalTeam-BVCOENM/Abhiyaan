import 'package:darpan/file_exporter.dart';
import 'package:darpan/ui/sub_views/academics/timetable/timetable_view.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimeLineWidget extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final int index;
  final bool isPast;

  const TimeLineWidget(
      {super.key,
      required this.isFirst,
      required this.isLast,
      required this.index,
      required this.isPast});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isFirst ? 90.h : 100.h,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: LineStyle(
          color: isPast
              ? context.colorScheme.primaryColor
              : context.colorScheme.primaryColor.withOpacity(0.5),
          thickness: 3.sp,
        ),
        indicatorStyle: IndicatorStyle(
          color: isPast
              ? context.colorScheme.primaryColor
              : context.colorScheme.primaryColor.withOpacity(0.5),
          width: 24.w,
          height: 24.h,
          drawGap: true,
          iconStyle: IconStyle(
            color: context.colorScheme.secondaryWhiteColor,
            fontSize: 18.sp,
            iconData: Icons.done,
          ),
        ),
        endChild: LectureCard(index: index),
      ),
    );
  }
}

//  margin: const EdgeInsets.all(10),
//       padding: const EdgeInsets.all(10),
//       height: 60.h,
//       width: MediaQuery.of(context).size.width,
//       decoration: BoxDecoration(
//         color: context.colorScheme.primaryColor.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(10),
//       ),

class LectureCard extends ViewModelWidget<TimeTableViewModel> {
  final int index;
  const LectureCard({super.key, required this.index});

  @override
  Widget build(BuildContext context, TimeTableViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 64.h,
        child: Card(
          color: context.colorScheme.secondaryLPurpleColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  viewModel.lectureDataList[index].subjectName,
                  style: TextStyle(
                    fontSize: FontThemeClass().heading3(context).fontSize,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  viewModel.lectureDataList[index].subjectTeacherName,
                  style: FontThemeClass().subHeading(context,
                      context.colorScheme.secondaryBlackColor.withOpacity(0.5)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
