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
        style: fontTheme.heading(context,
            size: fontSize.sp, color: context.colorScheme.secondaryBlackColor),
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
  final double height;
  final double width;
  final double fontSize;
  final EventModel event;

  const EventDateContainer({
    super.key,
    this.top,
    this.right,
    this.bottom,
    this.left,
    this.fontSize = 30,
    required this.height,
    required this.width,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    FontThemeClass fontTheme = FontThemeClass();
    EventViewModel model = EventViewModel();
    return Positioned(
      top: top?.sp,
      left: left?.sp,
      bottom: bottom?.sp,
      right: right?.sp,
      child: Container(
        height: height.h,
        width: width.w,
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
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              event.startDate.toDate().day.toString(),
              textAlign: TextAlign.center,
              style: fontTheme.heading(context,
                  size: fontSize.sp, color: context.colorScheme.primaryColor),
            ),
            Text(
              model.getMonthName(event.startDate.toDate().month,
                  event.startDate.toDate().year),
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
        height: 205.h,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            // Event Image
            eventDetails.eventImage(
              context,
              model.imageUrl,
              128.h,
              ResponsiveUtils.screenWidth(context),
            ),
            SizedBox(
              height: 18.h,
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
                          EdgeInsets.only(left: 18.sp),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        //  Event Time and Location
                        Padding(
                          padding: EdgeInsets.only(left: 18.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              eventDetails.eventTime(context,
                                  "${model.startDate.toDate().hour}:${model.startDate.toDate().minute}"),
                              SizedBox(
                                width: 18.w,
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
                      padding: EdgeInsets.only(right: 18.sp),
                      child: Container(
                        height: 35.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                          color:
                              context.colorScheme.primaryColor.withOpacity(0.8),
                          boxShadow: [
                            BoxShadow(
                              color: context.colorScheme.secondarySectionColor
                                  .withOpacity(0.4),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            "Open".toUpperCase(),
                            style: FontThemeClass().subHeading2(context,
                                context.colorScheme.secondaryWhiteColor,
                                fontSize: 16.sp, fontWeight: FontWeight.w900),
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

class EventCardUpcoming extends ViewModelWidget<EventViewModel> {
  final EventModel model;
  const EventCardUpcoming({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context, EventViewModel viewModel) {
    EventDetails eventDetails = EventDetails();
    return Positioned(
      child: SizedBox(
        height: 200.h,
        width: 200.w,
        child: Column(
          children: [
            // Event Image
            eventDetails.eventImage(
              context,
              model.imageUrl,
              110.h,
              ResponsiveUtils.screenWidth(context),
            ),
            SizedBox(
              height: 8.h,
            ),
            // Event Info
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 12.sp, right: 16.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Time
                      eventDetails.eventTime(
                        context,
                        "${model.startDate.toDate().hour}:${model.startDate.toDate().minute}",
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      // Location
                      eventDetails.eventLocation(
                        context,
                        model.location,
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(right: 10.sp),
                    child: InkWell(
                      onTap: () {
                        viewModel._navigationService
                            .navigateToDetailedEventView(eventData: model);
                      },
                      child: Container(
                        height: 30.h,
                        width: 62.w,
                        decoration: BoxDecoration(
                          color:
                              context.colorScheme.primaryColor.withOpacity(0.8),
                          boxShadow: [
                            BoxShadow(
                              color: context.colorScheme.secondarySectionColor
                                  .withOpacity(0.4),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            "Open".toUpperCase(),
                            style: FontThemeClass().subHeading2(context,
                                context.colorScheme.secondaryWhiteColor,
                                fontWeight: FontWeight.w900, fontSize: 16.sp),
                          ),
                        ),
                      ),
                    ))
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
  Widget build(BuildContext context, EventViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Container(
          decoration:
              BoxDecoration(color: context.colorScheme.secondaryWhiteColor),
          width: 60.sp,
          height: 60.sp,
          child: Column(
            children: [
              InkWell(
                  onTap: () => UrlLauncher().launchURL(model.url),
                  child: Image.network(
                    model.imageUrl,
                    height: 60.sp,
                    width: 60.sp,
                    fit: BoxFit.cover,
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) =>
                            wasSynchronouslyLoaded
                                ? child
                                : AnimatedOpacity(
                                    opacity: frame == null ? 0 : 1,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.easeOut,
                                    child: child,
                                  ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class EventShimmerEffect extends StatelessWidget {
  const EventShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 44,
          ),
          Card(
              clipBehavior: Clip.hardEdge,
              shadowColor:
                  context.colorScheme.secondaryLPurpleColor.withOpacity(0.8),
              elevation: 4,
              shape: ShapeBorder.lerp(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.sp),
                  ),
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.sp),
                  ),
                  1),
              child: ShimmerLoadingWidget(
                height: 200.h,
              )),
          // const SectionText(title: "Sponsors"),
          const SizedBox(
            height: 44,
          ),
          SizedBox(
            height: 60.sp,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 14.0),
                  child: ShimmerLoadingWidget(
                    height: 70.sp,
                    width: 70.sp,
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 44,
          ),
          SizedBox(
            height: 200.sp,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              itemBuilder: (context, index) {
                return ShimmerLoadingWidget(
                  height: 200.sp,
                  width: 200.sp,
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
