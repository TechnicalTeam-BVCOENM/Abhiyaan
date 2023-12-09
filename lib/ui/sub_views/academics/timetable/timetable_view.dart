import 'package:darpan/file_exporter.dart';
import 'package:table_calendar/table_calendar.dart';
part 'timetable_view_model.dart';

class TimeTableView extends StatelessWidget {
  const TimeTableView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TimeTableViewModel>.reactive(
      viewModelBuilder: () => TimeTableViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: context.colorScheme.backgroundColor,
          appBar: AppBar(
            title: Text(
              'Timetable',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.headingColor,
              ),
            ),
            centerTitle: true,
            iconTheme: IconThemeData(
              color: context.colorScheme.iconColor,
            ),
            backgroundColor: context.colorScheme.backgroundColor,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: TableCalendar(
              locale: 'en_US',
              firstDay: model.getOneYearBack(),
              lastDay: model.getOneYearForward(),
              focusedDay: model.focusedDay,
              rowHeight: 25.h,
              daysOfWeekHeight: 20.h,
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
                titleTextStyle: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                formatButtonTextStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
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
                  color: context.colorScheme.secondarySectionColor,
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
          ),
        );
      },
    );
  }
}
