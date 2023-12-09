import 'package:darpan/theme/responsive_utils.dart';
import 'package:intl/intl.dart';
import '../../../common/cached_network_image.dart';
import '../../../file_exporter.dart';
part 'event_view_model.dart';
part 'event_view_components.dart';

class EventView extends StatelessWidget {
  const EventView({super.key});

  @override
  Widget build(BuildContext context) {
    FontThemeClass fontTheme = FontThemeClass();
    return ViewModelBuilder<EventViewModel>.reactive(
      viewModelBuilder: () => EventViewModel(),
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, model, child) {
        var todaysEvent = model.todayEvent;
        return Scaffold(
          backgroundColor: context.colorScheme.backgroundColor,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionText(title: "Ongoing Events"),
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
                                top: 120.sp,
                                left: 20.sp,
                                event: todaysEvent,
                              ),
                            ],
                          )
                        : SizedBox(
                            height: 200.sp,
                            width: ResponsiveUtils.screenWidth(context),
                            child: Center(
                              child: Column(
                                children: [
                                  CachedNetworkImageWidget(
                                    imageUrl:
                                        "https://imgs.search.brave.com/DGoVUPXpo3OwVAbBbgF3oGz3MUcz_cPZrzmfvO7iRrc/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9jZG5p/Lmljb25zY291dC5j/b20vaWxsdXN0cmF0/aW9uL3ByZW1pdW0v/dGh1bWIvc2VhcmNo/LXJlc3VsdC1ub3Qt/Zm91bmQtMjEzMDM1/NS0xODAwOTIwLnBu/Zz9mPXdlYnA",
                                    height: 150.sp,
                                    width: 150.sp,
                                    maxHeightDiskCache:
                                        ResponsiveUtils.screenWidth(context),
                                  ),
                                  Text(
                                    "No Ongoing Events",
                                    style: fontTheme.heading(context,
                                        size: 20,
                                        color: context
                                            .colorScheme.secondarySectionColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                  const SectionText(title: "Sponsors"),
                  SizedBox(
                    height: 100.sp,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: model.brands.length,
                      itemBuilder: (context, index) {
                        return BrandCard(brand: model.brands[index]);
                        // Card(
                        //   clipBehavior: Clip.hardEdge,
                        //   shadowColor: context.colorScheme.secondaryLPurpleColor
                        //       .withOpacity(0.8),
                        //   elevation: 4,
                        //   shape: ShapeBorder.lerp(
                        //       RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(18),
                        //       ),
                        //       RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(18),
                        //       ),
                        //       1),
                        //   child: BrandCard(brand: model.brands[index]),
                        // );
                      },
                    ),
                  ),
                  const SectionText(title: "Upcoming Events"),
                  SizedBox(
                    height: 200.sp,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: model.remainigEvents.length,
                      itemBuilder: (context, index) {
                        return Card(
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
                          child: Stack(
                            children: [
                              // Event Image and Info
                              EventCardUpcoming(
                                model: model.remainigEvents[index],
                              ),
                              // Event Date
                              EventDateContainer(
                                top: 8.sp,
                                left: 8.sp,
                                event: model.remainigEvents[index],
                              ),
                            ],
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