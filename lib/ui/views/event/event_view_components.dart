part of 'event_view.dart';

// Event Time and location component
class EventDetails {
  FontThemeClass fontTheme = FontThemeClass();

  Row _eventLocation(
    BuildContext context,
    String location,
  ) {
    assert(location.isNotEmpty, "Time should not be null or empty");

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.location_on,
          size: 18.sp,
          color: context.colorScheme.primaryColor.withOpacity(0.8),
        ),
        const SizedBox(
          width: 2,
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

  Row _eventTime(BuildContext context, String time) {
    assert(time.isNotEmpty, "Time should not be null or empty");
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.timer,
          size: 18.sp,
          color: context.colorScheme.primaryColor.withOpacity(0.8),
        ),
        const SizedBox(
          width: 2,
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

  CachedNetworkImageWidget _eventImage(BuildContext context, String imageUrl, double height, double width) {
    assert(imageUrl.isNotEmpty, "Time should not be null or empty");
    assert(height != 0 && width != 0 && height < width, "Height should be greater than 0");

    return CachedNetworkImageWidget(
      imageUrl: imageUrl,
      height: height,
      width: width,
      maxHeightDiskCache: ResponsiveUtils.screenWidth(context),
    );
  }

  Padding eventTitle(BuildContext context, String title, EdgeInsets padding, {double fontSize = 26}) {
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
//           size: 12.sp,
//           color: context.colorScheme.primaryColor.withOpacity(0.8),
//         ),
//         SizedBox(
//           width: 4.sp,
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
//           size: 12.sp,
//           color: context.colorScheme.primaryColor.withOpacity(0.8),
//         ),
//         SizedBox(
//           width: 4.sp,
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
        height: 60.sp,
        width: 60.sp,
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
              model.getMonthName(event.month, event.year),
              style: fontTheme.subHeading2(context, context.colorScheme.secondaryBlackColor),
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
        height: 250.sp,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            // Event Image
            eventDetails.eventImage(
              context,
              event.imageUrl,
              160.sp,
              ResponsiveUtils.screenWidth(context),
            ),
            SizedBox(
              height: 28.sp,
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
                        eventDetails.eventTitle(
                          context,
                          event.title,
                          EdgeInsets.only(left: 22.sp),
                        ),
                        SizedBox(
                          height: 4.sp,
                        ),
                        //  Event Time and Location
                        Padding(
                          padding: EdgeInsets.only(left: 20.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              eventDetails.eventTime(context, event.time),
                              SizedBox(
                                width: 18.sp,
                              ),
                              eventDetails.eventLocation(context, event.location),
                            ],
                          ),
                        )
                      ],
                    ),
                    // Event Button
                    Padding(
                      padding: EdgeInsets.only(right: 8.sp),
                      child: Transform.rotate(
                        angle: 180 * 314 / 22,
                        child: IconButton(
                          onPressed: () {},
                          splashRadius: 20.sp,
                          tooltip: "Details",
                          icon: Icon(
                            Icons.send_rounded,
                            size: 36.sp,
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
        height: 200.sp,
        width: 200.sp,
        child: Column(
          children: [
            // Event Image
            eventDetails.eventImage(
              context,
              model.imageUrl,
              130.sp,
              ResponsiveUtils.screenWidth(context),
            ),
            SizedBox(
              height: 8.sp,
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
                  EdgeInsets.only(left: 15.sp),
                  fontSize: 18.0,
                ),

                //  Event Time and Location
                Padding(
                  padding: EdgeInsets.only(left: 12.sp, right: 16.sp),
                  child: Column(
                    children: [
                      // Time
                      eventDetails.eventTime(
                        context,
                        model.time,
                      ),
                      SizedBox(
                        height: 6.sp,
                      ),
                      // Location
                      eventDetails.eventLocation(
                        context,
                        model.location,
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

class BrandCard extends StatelessWidget {
  final BrandModel brand;

  const BrandCard({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SizedBox(
        width: 80,
        height: 80,
        child: Column(
          children: [
            SizedBox(
              height: 80.0, // Adjust the height as needed
              child: Image.network(
                brand.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
