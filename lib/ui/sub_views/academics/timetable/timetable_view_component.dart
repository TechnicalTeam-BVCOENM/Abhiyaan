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
      height: 70.h,
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

class LectureCard extends ViewModelWidget<TimeTableViewModel> {
  final int index;
  const LectureCard({super.key, required this.index});

  @override
  Widget build(BuildContext context, TimeTableViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: SizedBox(
        height: 64.h,
        child: Card(
          elevation: 0,
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: context.colorScheme.primaryColor.withOpacity(0.3),
              width: 1.0,
            ),
          ),
          color: context.colorScheme.secondaryLPurpleColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  viewModel.lectureDataList[index].subjectName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: FontThemeClass().heading3(context).fontSize,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      viewModel.lectureDataList[index].subjectTeacherName,
                      style: FontThemeClass().subHeading(context,
                          context.colorScheme.primaryColor.withOpacity(0.6)),
                    ),
                    Text(
                      'From ${viewModel.lectureDataList[index].startTime.toDate().toString().substring(10, 16)}',
                      style: FontThemeClass().subHeading(context,
                          context.colorScheme.primaryColor.withOpacity(0.6)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
