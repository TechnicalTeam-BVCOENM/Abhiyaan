import 'package:darpan/file_exporter.dart';
import 'package:table_calendar/table_calendar.dart';
import './utils.dart';
part 'timetable_view_model.dart';

class TimeTableView extends StatelessWidget {
  const TimeTableView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TimeTableViewModel>.reactive(
      viewModelBuilder: () => TimeTableViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Timetable',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.primaryColor,
              ),
            ),
            centerTitle: true,
            elevation: 1,
            // leading: const Icon(
            //   Icons.chevron_left_rounded,
            //   size: 56,
            // ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: TableCalendar(
              locale: 'en_US',
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: model.focusedDay,
              rowHeight: 40,
              daysOfWeekHeight: 24,
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
                titleTextStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                formatButtonTextStyle: const TextStyle(
                  fontSize: 15,
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
            ),
          ),
        );
      },
    );
  }
}
