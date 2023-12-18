import 'package:darpan/file_exporter.dart';
part 'notification_view_model.dart';

class NotificationView extends StatelessWidget {
  final String id;
  const NotificationView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationViewModel>.reactive(
      viewModelBuilder: () => NotificationViewModel(),
      builder: (context, model, child) {
        FontThemeClass fontTheme = FontThemeClass();
        return Scaffold(
          backgroundColor: context.colorScheme.backgroundColor,
          appBar: AppBar(
            title: Text(
              "Notifications",
              style: fontTheme.title(context,
                  color: context.colorScheme.secondaryBlackColor),
            ),
            centerTitle: true,
          ),
          body: Center(child: Text("Id is: $id")),
        );
      },
    );
  }
}
