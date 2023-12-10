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

class EventDateContainer extends ViewModelWidget<EventViewModel> {
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
    this.fontSize = 28,
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
              height: 30.h,
              child: Text(
                event.startDate.toDate().day.toString().trim(),
                textAlign: TextAlign.center,
                style: fontTheme.heading(
                  context,
                  color: context.colorScheme.primaryColor,
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 30.h,
              child: Text(
                viewModel
                    .getMonthName(event.startDate.toDate().month,
                        event.startDate.toDate().year)
                    .trim(),
                textAlign: TextAlign.center,
                style: fontTheme.subHeading2(
                    context, context.colorScheme.secondaryBlackColor),
              ),
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
        height: 265.h,
        width: double.infinity,
        child: Column(
          children: [
            eventDetails.eventImage(
              context,
              model.imageUrl,
              179.h,
              ResponsiveUtils.screenWidth(context),
            ),
            8.verticalSpace,
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Event Info
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        4.verticalSpace,
                        eventDetails.eventTitle(
                          context,
                          model.title,
                          const EdgeInsets.only(left: 18).r,
                        ),
                        2.verticalSpace,
                        Padding(
                          padding: const EdgeInsets.only(left: 18).r,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              eventDetails.eventTime(context,
                                  "${model.startDate.toDate().hour}:${model.startDate.toDate().minute}"),
                              18.horizontalSpace,
                              eventDetails.eventLocation(
                                  context, model.location),
                            ],
                          ),
                        )
                      ],
                    ),
                    // Event Button
                    Padding(
                      padding: const EdgeInsets.only(right: 18).r,
                      child: Container(
                        height: 40.h,
                        width: 95.w,
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
                            style: FontThemeClass().subHeading2(
                                context, context.colorScheme.signInTextColor,
                                fontSize: 18.sp, fontWeight: FontWeight.w900),
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
        height: 200.h,
        width: 202.w,
        child: Column(
          children: [
            eventDetails.eventImage(
              context,
              model.imageUrl,
              135.h,
              ResponsiveUtils.screenWidth(context),
            ),
            2.verticalSpace,
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
                    padding: EdgeInsets.only(right: 10.sp),
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
                          style: FontThemeClass().subHeading2(
                              context, context.colorScheme.signInTextColor,
                              fontWeight: FontWeight.w900, fontSize: 16.sp),
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
              InkWell(
                onTap: () => UrlLauncher().launchURL(model.url),
                child: Image.network(
                  model.imageUrl,
                  height: 80.h,
                  width: 80.w,
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
                ),
              ),
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
