import 'package:darpan/file_exporter.dart';
import 'package:darpan/ui/sub_views/event/detailed_event_view_components.dart';
import 'package:darpan/ui/views/event/event_view.dart';
// import 'package:darpan/theme/theme_service.dart';

part 'detailed_event_view_model.dart';
// part 'detailed_event_view_components.dart';

class DetailedEventView extends StatelessWidget {

  final EventModel eventData;
  const DetailedEventView({super.key,required this.eventData});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DetailedEventViewModel>.reactive(
      viewModelBuilder: () => DetailedEventViewModel(eventData),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: context.colorScheme.backgroundColor,
          body: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              DetailedEventAppBar(imageLink: eventData.imageUrl,),
              DetailedEventData(),
            ],
          ),
          bottomNavigationBar: BottomNavBarDetailedPage(),
        );
      },
    );
  }
}
