import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darpan/file_exporter.dart';
import 'package:darpan/services/firestore_service.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:darpan/ui/sub_views/academics/timetable/timetable_view_component.dart';
part 'timetable_view_model.dart';

class TimeTableView extends StatelessWidget {
  const TimeTableView({super.key});
  @override
  Widget build(BuildContext context) {
    FontThemeClass fontThemeClass = FontThemeClass();
    return ViewModelBuilder<TimeTableViewModel>.reactive(
      viewModelBuilder: () => TimeTableViewModel(),
      onViewModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: context.colorScheme.backgroundColor,
          appBar: AppBar(
            title: Text(
              'Timetable',
              style: FontThemeClass().heading(context),
            ),
            centerTitle: true,
            iconTheme: IconThemeData(
              color: context.colorScheme.iconColor,
            ),
            backgroundColor: context.colorScheme.backgroundColor,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 18).r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TableCalendar(
                    locale: 'en_US',
                    firstDay: model.getOneYearBack(),
                    lastDay: model.getOneYearForward(),
                    focusedDay: model.focusedDay,
                    rowHeight: 34.h,
                    daysOfWeekHeight: 24.h,
                    availableGestures: AvailableGestures.all,
                    daysOfWeekStyle: const DaysOfWeekStyle(
                      weekdayStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      weekendStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    calendarFormat: model.calendarFormat,
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'Month',
                      CalendarFormat.week: 'Week'
                    },
                    headerStyle: HeaderStyle(
                      leftChevronVisible: false,
                      rightChevronVisible: false,
                      formatButtonShowsNext: false,
                      titleTextStyle: fontThemeClass.heading3(context),
                      formatButtonTextStyle:
                          fontThemeClass.subHeading(context, Colors.white),
                      formatButtonDecoration: BoxDecoration(
                        color: context.colorScheme.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    calendarStyle: CalendarStyle(
                      cellMargin: const EdgeInsets.all(0),
                      cellAlignment: Alignment.center,
                      defaultTextStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      weekendTextStyle: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: context.colorScheme.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: BoxDecoration(
                        color:
                            context.colorScheme.primaryColor.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      selectedTextStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      todayTextStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    selectedDayPredicate: (day) {
                      return isSameDay(model.selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      model.onDaySelected(selectedDay, focusedDay);
                    },
                    onFormatChanged: (format) {
                      model.onFormatChanged(format);
                    },
                    onPageChanged: (focusedDay) {
                      model.focusedDay = focusedDay;
                    },
                  ),
                  20.verticalSpace,
                  Text(
                    model.todaysDay == 'holiday' ? "Holiday" : "Lectures",
                    textAlign: TextAlign.start,
                    style: fontThemeClass.heading3(context),
                  ),
                  8.verticalSpace,
                  model.todaysDay == 'holiday'
                      ? Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: context.colorScheme.primaryColor
                                  .withOpacity(0.3),
                              width: 1.0,
                            ),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "It's weekend o'clock!",
                                      style: FontThemeClass().subHeading(
                                          context,
                                          context.colorScheme.primaryColor),
                                    ),
                                    Text(
                                      'Sip, savor and soak in the sunshine.',
                                      textAlign: TextAlign.center,
                                      style: FontThemeClass().subHeading2(
                                          context,
                                          context.colorScheme
                                              .secondarySectionColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            for (int i = 0;
                                i < model.lectureDataList.length;
                                i++) ...[
                              TimeLineWidget(
                                isFirst: i == 0,
                                isLast: i == model.lectureDataList.length - 1,
                                isPast: model.lectureDataList[i].startTime
                                        .toDate()
                                        .hour <
                                    DateTime.now().hour,
                                index: i,
                              ),
                            ],
                          ],
                        )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
