import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darpan/file_exporter.dart';
import 'package:darpan/ui/sub_views/academics/timetable/timetable_view_component.dart';
part 'timetable_view_model.dart';

class TimeTableView extends StatelessWidget {
  const TimeTableView({super.key});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TimeTableViewModel>.reactive(
        viewModelBuilder: () => TimeTableViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Daily Tasks",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: FontThemeClass().heading(context).fontSize,
                        fontWeight: FontWeight.w700,
                        color: context.colorScheme.primaryColor,
                      ),
                    ),
                    for (int i = 0; i < model.lectureDataList.length; i++)
                      TimeLineWidget(
                        isFirst: i == 0,
                        isLast: i == model.lectureDataList.length - 1,
                        isPast:
                            model.lectureDataList[i].startTime.toDate().hour <
                                DateTime.now().hour,
                        index: i,
                      )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
