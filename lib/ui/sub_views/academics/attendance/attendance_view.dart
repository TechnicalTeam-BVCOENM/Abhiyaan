import 'package:darpan/file_exporter.dart';
part 'attendance_view_model.dart';

class AttendanceView extends StatelessWidget {
  const AttendanceView({super.key});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AttendanceViewModel>.reactive(
        viewModelBuilder: () => AttendanceViewModel(),
        builder: (context, model, child) {
          return const Scaffold();
        });
  }
}
