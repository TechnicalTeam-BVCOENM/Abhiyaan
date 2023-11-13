import 'package:darpan/theme/responsive_utils.dart';
import 'package:intl/intl.dart';
import '../../../file_exporter.dart';
part 'event_view_model.dart';
part 'event_view_components.dart';

class EventView extends StatelessWidget {
  const EventView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EventViewModel>.reactive(
      viewModelBuilder: () => EventViewModel(),
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, model, child) {
        var todaysEvent = model.todayEvent;
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: SectionText(title: "Ongoing Events"),
                  ),
                  Card(
                    clipBehavior: Clip.hardEdge,
                    shadowColor: context.colorScheme.secondaryLPurpleColor
                        .withOpacity(0.8),
                    elevation: 4,
                    shape: ShapeBorder.lerp(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        1),
                    child: todaysEvent != null
                        ? Stack(
                            children: [
                              EventCardInfo(
                                event: todaysEvent,
                              ),
                              EventDateContainer(
                                top: 120.wWise,
                                left: 20.wWise,
                                event: todaysEvent,
                              ),
                            ],
                          )
                        : const CircularLoadingIndicator(
                            height: 200,
                          ),
                  ),
                  const Align(
                      alignment: Alignment.bottomLeft,
                      child: SectionText(title: "Sponsors")),
                  const Align(
                      alignment: Alignment.bottomLeft,
                      child: SectionText(title: "Upcoming Events")),
                  SizedBox(
                    height: 200.hWise,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
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
                                const EventCardUpcoming(),
                                // Event Date
                                EventDateUContainer(
                                  top: 6.wWise,
                                  left: 6.wWise,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}





// todayEvent != null
//               ? OngoingEventContainer(event: todayEvent)
//               : Container(
//                   width: 200,
//                   height: 200,
//                   color: Colors.grey,
//                 ),