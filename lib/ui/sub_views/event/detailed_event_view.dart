import 'package:darpan/file_exporter.dart';
import 'package:darpan/ui/sub_views/event/detailed_event_view_components.dart';
// import 'package:darpan/theme/theme_service.dart';

part 'detailed_event_view_model.dart';
// part 'detailed_event_view_components.dart';

class DetailedEventView extends StatelessWidget {
  const DetailedEventView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DetailedEventViewModel>.reactive(
      viewModelBuilder: () => DetailedEventViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: context.colorScheme.backgroundColor,
          body: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              DetailedEventAppBar(),
              DetailedEventData(),
            ],
          ),
          bottomNavigationBar: BottomNavBarDetailedPage(),
        );
      },
    );
  }
}
