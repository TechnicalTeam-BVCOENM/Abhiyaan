import '../../../file_exporter.dart';
part 'event_view_model.dart';


class EventView extends StatelessWidget {
  const EventView({super.key});

  @override
  Widget build(BuildContext context) {
    FontThemeClass fontTheme = FontThemeClass();
    return ViewModelBuilder<EventViewModel>.reactive(
      viewModelBuilder: () => EventViewModel(),
      builder: (context, model, child) {
        return const SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: Text("Event Page"),
            ),
          ),
        );
      },
    );
  }
}
