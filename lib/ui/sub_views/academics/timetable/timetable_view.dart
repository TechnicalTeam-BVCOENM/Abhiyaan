import 'package:darpan/file_exporter.dart';
part 'timetable_view_model.dart';

class TimeTableView extends StatelessWidget {
  const TimeTableView({super.key});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TimeTableViewModel>.reactive(
        viewModelBuilder: () => TimeTableViewModel(),
        builder: (context, model, child) {
          return const Scaffold();
        });
  }
}
