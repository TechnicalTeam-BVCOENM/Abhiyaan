import 'package:darpan/file_exporter.dart';
import 'package:darpan/ui/sub_views/event/detailed_event_view_components.dart';
import 'package:darpan/ui/views/event/event_view.dart';

part 'detailed_event_view_model.dart';

class DetailedEventView extends StatelessWidget {
  final EventModel eventData;
  const DetailedEventView({super.key, required this.eventData});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DetailedEventViewModel>.reactive(
      viewModelBuilder: () => DetailedEventViewModel(eventData),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: context.colorScheme.backgroundColor,
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              DetailedEventAppBar(
                imageLink: eventData.imageUrl,
                eventLocation: eventData.location,
              ),
              DetailedEventData(
                eventName: eventData.title,
                eventInfo: eventData.about,
                eventStartDate: eventData.startDate.toDate(),
                eventEndDate: eventData.endDate.toDate(),
                eventContactName: eventData.cName,
                eventContactEmail: eventData.cEmail,
                eventContactNumber: eventData.cPhone,
              ),
            ],
          ),
          bottomNavigationBar: BottomNavBarDetailedPage(
            eventName: eventData.title,
            eventInfo: eventData.about,
            eventStartDate: eventData.startDate.toDate(),
            eventEndDate: eventData.endDate.toDate(),
            eventContactName: eventData.cName,
            eventContactEmail: eventData.cEmail,
            eventContactNumber: eventData.cPhone,
          ),
        );
      },
    );
  }
}
