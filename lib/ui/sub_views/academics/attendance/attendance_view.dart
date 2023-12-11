import 'package:darpan/file_exporter.dart';
part 'attendance_view_model.dart';

class AttendanceView extends StatelessWidget {
  const AttendanceView({super.key});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AttendanceViewModel>.reactive(
        viewModelBuilder: () => AttendanceViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: context
                    .colorScheme.secondaryBlackColor, //change your color here
              ),
              backgroundColor: context.colorScheme.backgroundColor,
              elevation: 0,
              title: Text(
                'Student Section',
                style: FontThemeClass().heading2(context),
              ),
              centerTitle: true,
            ),
            backgroundColor:
                context.colorScheme.backgroundColor, // Background color
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Coming Soon !',
                    style: FontThemeClass().heading(context,
                        color: context.colorScheme.primaryColor),
                  ),
                  4.verticalSpace,
                  Text(
                    'Amazingness in progress. Stay tuned !',
                    style: FontThemeClass().subHeading2(
                        context, context.colorScheme.secondarySectionColor),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
