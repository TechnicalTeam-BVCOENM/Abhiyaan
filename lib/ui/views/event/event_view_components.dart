part of 'event_view.dart';

// Event Time and location component
class EventDetails {
  FontThemeClass fontTheme = FontThemeClass();


  Row _eventLocation(BuildContext context , String location) {
    return Row(
      children: [
        Icon(
          Icons.location_on,
          size: 18.wWise,
          color: context.colorScheme.primaryColor.withOpacity(0.8),
        ),
        SizedBox(
          width: 4.wWise,
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

  Row _eventTime(BuildContext context , String time) {
    return Row(
      children: [
        Icon(
          Icons.timer,
          size: 18.wWise,
          color: context.colorScheme.primaryColor.withOpacity(0.8),
        ),
        SizedBox(
          width: 4.wWise,
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
    return CachedNetworkImageWidget(
      imageUrl: imageUrl,
      height: height,
      width: width,
      maxHeightDiskCache: ResponsiveUtils.screenWidth(context),
    );
  }

  Padding eventTitle(BuildContext context, String title, EdgeInsets padding) {
    return Padding(
      padding: padding,
      child: Text(
        title,
        style: fontTheme.heading(context),
      ),
    );
  }

  get eventLocation => _eventLocation;
  get eventTime => _eventTime;
  get eventImage => _eventImage;
}

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
              event.month,
              textAlign: TextAlign.center,
              style: fontTheme.subHeading(
                  context, context.colorScheme.secondarySectionColor),
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
                              eventDetails.eventTime(context , event.time),
                              SizedBox(
                                width: 18.wWise,
                              ),
                              eventDetails.eventLocation(context, event.location),
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
