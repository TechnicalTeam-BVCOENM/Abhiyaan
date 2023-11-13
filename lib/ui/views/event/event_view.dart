import 'package:darpan/theme/responsive_utils.dart';
import '../../../file_exporter.dart';
part 'event_view_model.dart';
part 'event_view_components.dart';

class EventView extends StatelessWidget {
  const EventView({super.key});

  @override
  Widget build(BuildContext context) {
    EventDetails eventDetails = EventDetails();

    return ViewModelBuilder<EventViewModel>.reactive(
      viewModelBuilder: () => EventViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  const Align(
                      alignment: Alignment.bottomLeft,
                      child: SectionText(title: "Ongoing Events")),
                  Card(
                    clipBehavior: Clip.hardEdge,
                    shape: ShapeBorder.lerp(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        1),
                    child: Stack(
                      children: [
                        // Event Image and Info
                        Positioned(
                          child: SizedBox(
                            height: 250.hWise,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                // Event Image
                                 eventDetails.eventImage(
                                  context,
                                  "https://imgs.search.brave.com/y2ve9MehABcSRTFjQYPcwpiFeueug4jPMSBV80j3lew/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXRteXVuaS5j/b20vYXp1cmUvY29s/bGVnZS1pbWFnZS9i/aWcvYmhhcmF0aS12/aWR5YXBlZXRocy1p/bnN0aXR1dGUtb2Yt/bWFuYWdlbWVudC1z/dHVkaWVzLXJlc2Vh/cmNoLWJ2aW1zci1t/dW1iYWkuanBn",
                                  160.hWise,
                                  ResponsiveUtils.screenWidth(context),
                                ),
                                SizedBox(
                                  height: 28.hWise,
                                ),
                                // Event Info
                                const EventCardInfo(),
                              ],
                            ),
                          ),
                        ),
                        // Event Date
                        const EventDateContainer(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  
}


