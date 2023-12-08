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

class EventDateContainer extends StatelessWidget {
  final double? top;

  final double? bottom;
  final double? right;
  final double? left;
  final EventModel event;

  const EventDateContainer({
    super.key,
    this.top,
    this.right,
    this.bottom,
    this.left,
    required this.event,
  });

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
              event.startDate.toDate().day.toString(),
              textAlign: TextAlign.center,
              style: fontTheme.large(context, FontWeight.w800),
            ),
            Text(
              model.getMonthName(event.startDate.toDate().month, event.startDate.toDate().year),
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
  final EventModel model;

  const EventCardInfo({
    super.key,
    required this.model,
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
              model.imageUrl,
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
                          model.title,
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
                              eventDetails.eventTime(context, "${model.startDate.toDate().hour}:${model.startDate.toDate().minute}"),
                              SizedBox(
                                width: 18.sp,
                              ),
                              eventDetails.eventLocation(
                                  context, model.location),
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
                        "${model.startDate.toDate().hour}:${model.startDate.toDate().minute}",
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

class Sponsors extends ViewModelWidget<EventViewModel> {
  final SponsorsModel model;

   const Sponsors({super.key, required this.model});

  @override
  Widget build(BuildContext context , EventViewModel viewModel) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Container(
          decoration:
              BoxDecoration(color: context.colorScheme.secondaryWhiteColor),
          width: 80.sp,
          height: 80.sp,
          child: Column(
            children: [
              InkWell(
                onTap: () => UrlLauncher().launchURL(model.url),
                child: Image.network(
                  model.imageUrl,
                  height: 80.sp,
                  width: 80.sp,
                  fit: BoxFit.cover,
                  frameBuilder: (context, child, frame, wasSynchronouslyLoaded) => wasSynchronouslyLoaded ? child : AnimatedOpacity(
                    opacity: frame == null ? 0 : 1,
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeOut,
                    child: child,
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
