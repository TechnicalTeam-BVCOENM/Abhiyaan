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
          color: context.colorScheme.primaryAccentColor,
        ),
        4.horizontalSpace,
        Text(
          location.length > 16 ? "${location.substring(0, 16)}..." : location,
          style: fontTheme.body(
            context,
            color: context.colorScheme.secondaryTextColor,
          ),
        ),
      ],
    );
  }

  Row _eventName(
    BuildContext context,
    String name,
  ) {
    assert(name.isNotEmpty, "Name should not be null or empty");

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.event,
          size: 18.sp,
          color: context.colorScheme.primaryAccentColor,
        ),
        4.horizontalSpace,
        SizedBox(
          width: 104.w,
          child: Text(
            name,
            overflow: TextOverflow.ellipsis,
            style: fontTheme.body(
              context,
              color: context.colorScheme.secondaryTextColor,
            ),
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
          color: context.colorScheme.primaryAccentColor,
        ),
        4.horizontalSpace,
        Text(
          time,
          style: fontTheme.body(
            context,
            color: context.colorScheme.secondaryTextColor,
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
  final bool? isUpcomming;

  const EventDateContainer({
    super.key,
    this.top,
    this.right,
    this.bottom,
    this.left,
    this.timeFontSize = 28,
    this.textFontSize = 14,
    required this.isUpcomming,
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
        shadowColor: context.colorScheme.primaryTextColor,
        color: context.colorScheme.primaryCardColor,
        child: Column(
          children: [
            SizedBox(
              width: isUpcomming! ? (width * 0.9) : width,
              height: isUpcomming! ? (height / 2.3) : (height / 2),
              child: Text(
                event.startDate.toDate().day.toString().trim(),
                textAlign: TextAlign.center,
                style: isUpcomming!
                    ? fontTheme.title2(
                        context,
                        color: context.colorScheme.primaryAccentColor,
                        fontWeight: FontWeight.bold,
                      )
                    : fontTheme.title(
                        context,
                        color: context.colorScheme.primaryAccentColor,
                        fontWeight: FontWeight.bold,
                      ),
              ),
            ),
            SizedBox(
              width: isUpcomming! ? (width * 0.9) : width,
              height: isUpcomming! ? (height / 2.3) : (height / 2),
              child: Text(
                viewModel
                    .getMonthName(
                      event.startDate.toDate().month,
                      event.startDate.toDate().year,
                    )
                    .trim(),
                textAlign: TextAlign.center,
                style: isUpcomming!
                    ? fontTheme.caption(
                        context,
                        color: context.colorScheme.primaryTextColor,
                        fontWeight: FontWeight.w700,
                      )
                    : fontTheme.body(
                        context,
                        color: context.colorScheme.primaryTextColor,
                        fontWeight: FontWeight.w700,
                      ),
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
        color: context.colorScheme.primaryCardColor.withOpacity(0.5),
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
            const Spacer(),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18).r,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          8.verticalSpace,
                          Text(
                            model.title.length > 15
                                ? "${model.title.substring(0, 15)}.."
                                : model.title,
                            style: fontTheme.title2(
                              context,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              eventDetails.eventTime(
                                context,
                                "${model.startDate.toDate().hour}:${model.startDate.toDate().minute}",
                              ),
                              10.horizontalSpace,
                              eventDetails.eventLocation(
                                context,
                                model.location,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Event Button
                    Padding(
                      padding: const EdgeInsets.only(right: 18).r,
                      child: GestureDetector(
                        onTap: () {
                          _analyticsService.logEvent(
                            eventName: "Event_Screen",
                            value: " ${model.title} Event Opened",
                          );
                          viewModel._navigationService
                              .navigateToDetailedEventView(eventData: model);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8).r,
                          decoration: BoxDecoration(
                            color: context.colorScheme.primaryAccentColor,
                            boxShadow: [
                              BoxShadow(
                                color: context.colorScheme.primaryAccentColor
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
                              "Dive Deeper",
                              style: fontTheme.caption(
                                context,
                                color: context.colorScheme.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            const Spacer(),
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
      child: GestureDetector(
        onTap: () {
          viewModel._navigationService.navigateToDetailedEventView(
            eventData: model,
          );
        },
        child: Container(
          color: context.colorScheme.primaryCardColor,
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
                        eventDetails._eventName(
                          context,
                          model.title,
                        ),
                        2.verticalSpace,
                        eventDetails.eventTime(
                          context,
                          "${model.startDate.toDate().hour}:${model.startDate.toDate().minute}",
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10).r,
                    child: Container(
                      height: 30.h,
                      width: 62.w,
                      decoration: BoxDecoration(
                        color: context.colorScheme.primaryAccentColor,
                        boxShadow: [
                          BoxShadow(
                            color: context.colorScheme.primaryAccentColor
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
                          style: FontThemeClass().body(
                            context,
                            color: context.colorScheme.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              2.verticalSpace
            ],
          ),
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
          decoration: BoxDecoration(
            color: context.colorScheme.primaryCardColor,
          ),
          width: 80.w,
          height: 80.h,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  _analyticsService.logEvent(
                    eventName: "Sponsor_Screen",
                    value: " ${model.title} Sponsor Opened",
                  );
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
    );
    // .animate(
    //   delay: 80.ms,
    // )
    // .shimmer(
    //   padding: 0,
    //   duration: 1000.ms,
    // );
  }
}

class GalleryYearWiseView extends StatelessWidget {
  final List<GalleryModel> gallery;
  const GalleryYearWiseView({super.key, required this.gallery});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: gallery.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
                NavigationService().navigateTo(Routes.galleryTabView,
                    arguments:
                        GalleryTabViewArguments(gallery: gallery[index]));
              },
              child: GalleryYearWiseCards(
                gallery: gallery,
                index: index,
              ));
        },
      ),
    );
  }
}

class GalleryYearWiseCards extends StatelessWidget {
  final List<GalleryModel> gallery;
  final int index;
  const GalleryYearWiseCards(
      {super.key, required this.gallery, required this.index});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20).r,
        ),
        margin: const EdgeInsets.only(right: 20, bottom: 10).r,
        color: context.colorScheme.primaryCardColor,
        child: Container(
            width: 190.w,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(20).r,
                    child: Container(
                      color: context.colorScheme.primaryCardColor,
                      child: CachedNetworkImage(
                        imageUrl: gallery[index].logoUrl,
                        height: 113.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0).r,
                            child: const CircularLoadingIndicator(),
                          );
                        },
                      ),
                    )),
                5.verticalSpace,
                Padding(
                  padding: const EdgeInsets.only(left: 5).r,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(gallery[index].year.toString(),
                              style: FontThemeClass().paragraph(context,
                                  fontWeight: FontWeight.w600,
                                  color: context.colorScheme.primary)),
                          Text(gallery[index].themeName,
                              style: FontThemeClass().small(context,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      context.colorScheme.secondaryTextColor)),
                        ],
                      ),
                      const Spacer(),
                      Image(
                          width: 35.w,
                          height: 35.h,
                          image: const AssetImage(
                              "assets/images/gallery/bookmark.png")),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}

class BestMemories extends StatelessWidget {
  const BestMemories({super.key});

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: Container(
            color: Colors.green,
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: Container(
            color: Colors.green,
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Container(
            color: Colors.green,
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Container(
            color: Colors.green,
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 4,
          mainAxisCellCount: 2,
          child: Container(
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}
