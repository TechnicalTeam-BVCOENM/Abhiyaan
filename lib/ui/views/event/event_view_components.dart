part of 'event_view.dart';

// Event Time and location component
class EventDetails {
  FontThemeClass fontTheme = FontThemeClass();

  Row _eventLocation(BuildContext context, String location, {double gap = 4}) {
    assert(location.isNotEmpty, "Time should not be null or empty");

    return Row(
      children: [
        Icon(
          Icons.location_on,
          size: 18.wWise,
          color: context.colorScheme.primaryColor.withOpacity(0.8),
        ),
        SizedBox(
          width: gap.wWise,
        ),
        Text(
          location,
          style: fontTheme.subHeading2(
            context,
            context.colorScheme.primaryColor.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Row _eventTime(BuildContext context, String time, {double gap = 4}) {
    assert(time.isNotEmpty, "Time should not be null or empty");
    return Row(
      children: [
        Icon(
          Icons.timer,
          size: 18.wWise,
          color: context.colorScheme.primaryColor.withOpacity(0.8),
        ),
        SizedBox(
          width: gap.wWise,
        ),
        Text(
          time,
          style: fontTheme.subHeading2(
            context,
            context.colorScheme.primaryColor.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  CachedNetworkImageWidget _eventImage(
      BuildContext context, String imageUrl, double height, double width) {
    assert(imageUrl.isNotEmpty, "Time should not be null or empty");
    assert(height != 0 && width != 0 && height < width,
        "Height should be greater than 0");

    return CachedNetworkImageWidget(
      imageUrl: imageUrl,
      height: height,
      width: width,
      maxHeightDiskCache: ResponsiveUtils.screenWidth(context),
    );
  }

  Padding eventTitle(BuildContext context, String title, EdgeInsets padding,
      {double fontSize = 26}) {
    return Padding(
      padding: padding,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: fontTheme.heading(context, size: fontSize),
      ),
    );
  }

  get eventLocation => _eventLocation;
  get eventTime => _eventTime;
  get eventImage => _eventImage;
}

//UC
// class UCEventDetails {
//   FontThemeClass fontTheme = FontThemeClass();

//   Row _eventLocation(BuildContext context) {
//     return Row(
//       children: [
//         Icon(
//           Icons.location_on,
//           size: 12.wWise,
//           color: context.colorScheme.primaryColor.withOpacity(0.8),
//         ),
//         SizedBox(
//           width: 4.wWise,
//         ),
//         Text(
//           "Qudrangle",
//           style: fontTheme.smallSubHeading(
//             context,
//             context.colorScheme.primaryColor.withOpacity(0.8),
//           ),
//         ),
//       ],
//     );
//   }

//   Row _eventTime(BuildContext context) {
//     return Row(
//       children: [
//         Icon(
//           Icons.timer,
//           size: 12.wWise,
//           color: context.colorScheme.primaryColor.withOpacity(0.8),
//         ),
//         SizedBox(
//           width: 4.wWise,
//         ),
//         Text(
//           "11:00 AM",
//           style: fontTheme.smallSubHeading(
//             context,
//             context.colorScheme.primaryColor.withOpacity(0.8),
//           ),
//         ),
//       ],
//     );
//   }

//   CachedNetworkImageWidget _eventImage(
//       BuildContext context, String imageUrl, double height, double width) {
//     return CachedNetworkImageWidget(
//       imageUrl: imageUrl,
//       height: height,
//       width: width,
//       maxHeightDiskCache: ResponsiveUtils.screenWidth(context),
//     );
//   }

//   Padding eventTitle(BuildContext context, String title, EdgeInsets padding) {
//     return Padding(
//       padding: padding,
//       child: Text(
//         title,
//         style: fontTheme.heading(context),
//       ),
//     );
//   }

//   Padding eventUTitle(BuildContext context, String title, EdgeInsets padding) {
//     return Padding(
//       padding: padding,
//       child: Text(
//         title,
//         style: fontTheme.profileheading(context),
//       ),
//     );
//   }

//   get eventLocation => _eventLocation;
//   get eventTime => _eventTime;
//   get eventImage => _eventImage;
// }

class EventDateContainer extends StatelessWidget {
  final double? top;

  final double? bottom;
  final double? right;
  final double? left;
  final EventModel event;

  const EventDateContainer({
    Key? key,
    this.top,
    this.right,
    this.bottom,
    this.left,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FontThemeClass fontTheme = FontThemeClass();
    EventViewModel model = EventViewModel();
    return Positioned(
      top: top,
      left: left,
      bottom: bottom,
      right: right,
      child: Container(
        height: 60.hWise,
        width: 60.wWise,
        decoration: BoxDecoration(
          color: context.colorScheme.secondaryWhiteColor,
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.secondarySectionColor.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        // Event Date
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              event.day.toString(),
              textAlign: TextAlign.center,
              style: fontTheme.large(context, FontWeight.w800),
            ),
            Text(
             model.getMonthName(event.month, event.year) ,
              style: fontTheme.subHeading2(
                  context, context.colorScheme.secondaryBlackColor),
            ),
          ],
        ),
      ),
    );
  }
}

class EventCardInfo extends StatelessWidget {
  final EventModel event;

  const EventCardInfo({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    EventDetails eventDetails = EventDetails();
    return Positioned(
      child: SizedBox(
        height: 250.hWise,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            // Event Image
            eventDetails.eventImage(
              context,
              event.imageUrl,
              160.hWise,
              ResponsiveUtils.screenWidth(context),
            ),
            SizedBox(
              height: 28.hWise,
            ),
            // Event Info
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Event Info
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Event Title
                        eventDetails.eventTitle(context, event.title,
                            EdgeInsets.only(left: 22.padL.left)),
                        SizedBox(
                          height: 4.hWise,
                        ),
                        //  Event Time and Location
                        Padding(
                          padding: EdgeInsets.only(left: 20.padL.left),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              eventDetails.eventTime(context, event.time),
                              SizedBox(
                                width: 18.wWise,
                              ),
                              eventDetails.eventLocation(
                                  context, event.location),
                            ],
                          ),
                        )
                      ],
                    ),
                    // Event Button
                    Padding(
                      padding: EdgeInsets.only(right: 8.padR.right),
                      child: Transform.rotate(
                        angle: 180 * 314 / 22,
                        child: IconButton(
                          onPressed: () {},
                          splashRadius: 20.wWise,
                          tooltip: "Details",
                          icon: Icon(
                            Icons.send_rounded,
                            size: 36.wWise,
                            color: context.colorScheme.primaryColor,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EventCardUpcoming extends StatelessWidget {
  final EventModel model;

  const EventCardUpcoming({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    EventDetails eventDetails = EventDetails();
    return Positioned(
      child: SizedBox(
        height: 180.hWise,
        width: 260.wWise,
        child: Column(
          children: [
            // Event Image
            eventDetails.eventImage(
              context,
              model.imageUrl,
              130.hWise,
              ResponsiveUtils.screenWidth(context),
            ),
            SizedBox(
              height: 8.hWise,
            ),
            // Event Info
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Event Title
                eventDetails.eventTitle(
                  context,
                  model.title,
                  EdgeInsets.only(left: 15.padL.left),
                  fontSize: 26.0,
                ),
              
                //  Event Time and Location
                Padding(
                  padding: EdgeInsets.only(left: 12.padL.left , right: 16.padR.right),
                  child: Column(
                    children: [
                      // Time
                      eventDetails.eventTime(
                        context,
                        gap: 10.0,
                        model.time,
                      ),
                      SizedBox(
                        height: 6.wWise,
                      ),
                      // Location
                      eventDetails.eventLocation(
                        context,
                        model.location,
                        gap: 2.0,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
