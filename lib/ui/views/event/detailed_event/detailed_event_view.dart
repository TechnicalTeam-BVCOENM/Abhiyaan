import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/services/firestore_service.dart';
import 'package:abhiyaan/ui/common/carousel_utils.dart';
import 'package:abhiyaan/ui/common/url_launcher.dart';
import 'package:abhiyaan/ui/views/event/event_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
part 'detailed_event_view_model.dart';
part 'detailed_event_view_components.dart';


class DetailedEventView extends StatelessWidget {
  final EventModel eventData;
  const DetailedEventView({super.key, required this.eventData});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DetailedEventViewModel>.reactive(
      viewModelBuilder: () => DetailedEventViewModel(eventData),
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, model, child) {
          final _analyticsService = locator<AnalyticsService>();

        return Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: FloatingActionButton(
                  backgroundColor: context.colorScheme.signInTextColor,
                  isExtended: true,
                  heroTag: "register",
                  mini: false,
                  onPressed: () {
                    _analyticsService.logEvent(eventName: "Register_Event", value: "${eventData.title} Event Register button clicked : ${eventData.docID}");
                    UrlLauncher().launchURL(eventData.registerUrl);
                  },
                  child: Text(
                    "Register",
                    style: FontThemeClass().title2(context,color:Colors.black,fontWeight: FontWeight.w600)
                  ),
                ),
              ),
              12.horizontalSpace,
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: FloatingActionButton(
                  backgroundColor: context.colorScheme.primaryColor,
                  heroTag: "share_event",
                  onPressed: () {
                    model.shareEvent(eventData);
                  },
                  child:  Text(
                      "Share",
                      style: FontThemeClass().title2(context,color: context.colorScheme.signInTextColor,fontWeight: FontWeight.w600)
                    ),
                ),
              ),
            ].animate(delay: 300.ms).fadeIn(),
          ),
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
        );
      },
    );
  }
}
