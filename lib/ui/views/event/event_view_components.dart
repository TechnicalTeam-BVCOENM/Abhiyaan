part of 'event_view.dart';

final _analyticsService = locator<AnalyticsService>();

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
          color: context.colorScheme.switchColor.withOpacity(0.8),
        ),
        4.horizontalSpace,
        Text(
          location.length > 10 ? "${location.substring(0, 10)}..." : location,
          style: fontTheme.body(
            context,
            color: context.colorScheme.switchColor.withOpacity(0.8),
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
          color: context.colorScheme.switchColor.withOpacity(0.8),
        ),
        4.horizontalSpace,
        Text(
          time,
          style: fontTheme.body(
            context,
            color: context.colorScheme.switchColor.withOpacity(0.8),
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

  Padding eventTitle(BuildContext context, String title, EdgeInsets padding) {
    return Padding(
      padding: padding,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: fontTheme.header(context),
      ),
    );
  }

  get eventLocation => _eventLocation;
  get eventTime => _eventTime;
  get eventImage => _eventImage;
}

class EventDateContainer extends ViewModelWidget<EventViewModel> {
  final double? top;
  final double? bottom;
  final double? right;
  final double? left;
  final double height;
  final double width;
  final EventModel event;
  final double timeFontSize;
  final double textFontSize;

  const EventDateContainer({
    super.key,
    this.top,
    this.right,
    this.bottom,
    this.left,
    this.timeFontSize = 28,
    this.textFontSize = 14,
    required this.height,
    required this.width,
    required this.event,
  });

  @override
  Widget build(BuildContext context, EventViewModel viewModel) {
    FontThemeClass fontTheme = FontThemeClass();
    return Positioned(
      top: top,
      left: left,
      bottom: bottom,
      right: right,
      child: Card(
        shadowColor: context.colorScheme.secondarySectionColor,
        child: Column(
          children: [
            SizedBox(
              width: width,
              height: (height / 2),
              child: Text(
                event.startDate.toDate().day.toString().trim(),
                textAlign: TextAlign.center,
                style: fontTheme.title(context,
                    color: context.colorScheme.switchColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: width,
              height: (height / 2),
              child: Text(
                viewModel
                    .getMonthName(event.startDate.toDate().month,
                        event.startDate.toDate().year)
                    .trim(),
                textAlign: TextAlign.center,
                style: fontTheme.body(context,
                    color: context.colorScheme.secondaryBlackColor,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventCardInfo extends ViewModelWidget<EventViewModel> {
  final EventModel model;

  const EventCardInfo({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context, EventViewModel viewModel) {
    double spreadRadius = 0;
    double blurRadius = 0;
    if (context.colorScheme.brightness == Brightness.light) {
      spreadRadius = 1;
      blurRadius = 2;
    } else {
      spreadRadius = 0;
      blurRadius = 0;
    }
    FontThemeClass fontTheme = FontThemeClass();
    EventDetails eventDetails = EventDetails();
    return Positioned(
      child: Container(
        color: context.colorScheme.secondaryWhiteColor.withOpacity(0.5),
        height: 275.h,
        width: double.infinity,
        child: Column(
          children: [
            Hero(
              tag: "eventImage+${model.imageUrl}-${model.title}",
              child: CachedNetworkImageWidget(
                imageUrl: model.imageUrl,
                height: 178.h,
                width: double.infinity,
                fit: BoxFit.cover,
                maxHeightDiskCache: 400,
              ),
            ),
            6.verticalSpace,
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0).r,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          8.verticalSpace,
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0).r,
                            child: Text(
                              model.title,
                              style: fontTheme.eventCard(context,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18).r,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                eventDetails.eventTime(context,
                                    "${model.startDate.toDate().hour}:${model.startDate.toDate().minute}"),
                                10.horizontalSpace,
                                eventDetails.eventLocation(
                                    context, model.location),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Event Button
                      Padding(
                        padding: const EdgeInsets.only(right: 18).r,
                        child: GestureDetector(
                          onTap: () {
                            _analyticsService.logEvent(
                                eventName: "Event_Screen",
                                value: " ${model.title} Event Opened");
                            viewModel._navigationService
                                .navigateToDetailedEventView(eventData: model);
                          },
                          child: Container(
                            height: 40.h,
                            width: 95.w,
                            decoration: BoxDecoration(
                              color: context.colorScheme.switchColor
                                  .withOpacity(0.8),
                              boxShadow: [
                                BoxShadow(
                                  color: context
                                      .colorScheme.secondarySectionColor
                                      .withOpacity(0.4),
                                  spreadRadius: spreadRadius,
                                  blurRadius: blurRadius,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                "Open",
                                style: fontTheme.title2(context,
                                    color: context.colorScheme.signInTextColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
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
    double spreadRadius = 0;
    double blurRadius = 0;
    if (context.colorScheme.brightness == Brightness.light) {
      spreadRadius = 1;
      blurRadius = 2;
    } else {
      spreadRadius = 0;
      blurRadius = 0;
    }
    EventDetails eventDetails = EventDetails();
    return Positioned(
      child: Container(
        color: context.colorScheme.secondaryWhiteColor.withOpacity(0.5),
        height: 220.h,
        width: 232.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Hero(
              tag: "eventImage+${model.imageUrl}-${model.title}",
              child: CachedNetworkImageWidget(
                imageUrl: model.imageUrl,
                height: 135.h,
                maxHeightDiskCache: MediaQuery.of(context).size.width * 0.65,
                width: ResponsiveUtils.screenWidth(context),
                fit: BoxFit.cover,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 16).r,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      eventDetails.eventTime(
                        context,
                        "${model.startDate.toDate().hour}:${model.startDate.toDate().minute}",
                      ),
                      2.verticalSpace,
                      eventDetails.eventLocation(
                        context,
                        model.location,
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 10).r,
                    child: GestureDetector(
                      onTap: () {
                        viewModel._navigationService
                            .navigateToDetailedEventView(eventData: model);
                      },
                      child: Container(
                        height: 30.h,
                        width: 62.w,
                        decoration: BoxDecoration(
                          color:
                              context.colorScheme.switchColor.withOpacity(0.8),
                          boxShadow: [
                            BoxShadow(
                              color: context.colorScheme.secondarySectionColor
                                  .withOpacity(0.4),
                              spreadRadius: spreadRadius,
                              blurRadius: blurRadius,
                              offset: const Offset(0, 1),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(12).r,
                        ),
                        child: Center(
                          child: Text(
                            "Open",
                            style: FontThemeClass().body(context,
                                color: context.colorScheme.signInTextColor),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
            2.verticalSpace
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
    UrlLauncher urlLauncher = UrlLauncher();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0).r,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18.0).r,
        child: Container(
          decoration:
              BoxDecoration(color: context.colorScheme.secondaryWhiteColor),
          width: 80.w,
          height: 80.h,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  _analyticsService.logEvent(
                      eventName: "Sponsor_Screen",
                      value: " ${model.title} Sponsor Opened");
                  urlLauncher.launchURL(model.url);
                },
                child: CachedNetworkImageWidget(
                  imageUrl: model.imageUrl,
                  height: 80.h,
                  width: 80.w,
                  maxHeightDiskCache: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate(
          delay: 300.ms,
        )
        .shimmer(
          padding: 0,
          delay: 200.ms,
          duration: 1000.ms,
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
          44.verticalSpace,
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
                height: 260.h,
              )),
          44.verticalSpace,
          SizedBox(
            height: 80.h,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 25.0).r,
                  child: ShimmerLoadingWidget(
                    height: 70.sp,
                    width: 70.sp,
                  ),
                );
              },
            ),
          ),
          44.verticalSpace,
          SizedBox(
            height: 200.h,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              itemBuilder: (context, index) {
                return ShimmerLoadingWidget(
                  height: 200.h,
                  width: 240.h,
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
