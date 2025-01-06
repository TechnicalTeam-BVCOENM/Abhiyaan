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
          color: context.colorScheme.accentColor,
        ),
        4.horizontalSpace,
        Text(
          location.length > 16 ? "${location.substring(0, 16)}..." : location,
          style: fontTheme.body(
            context,
            color: context.colorScheme.secondaryText,
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
          color: context.colorScheme.accentColor,
        ),
        4.horizontalSpace,
        SizedBox(
          width: 104.w,
          child: Text(
            name,
            overflow: TextOverflow.ellipsis,
            style: fontTheme.body(
              context,
              color: context.colorScheme.secondaryText,
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
          color: context.colorScheme.accentColor,
        ),
        4.horizontalSpace,
        Text(
          time,
          style: fontTheme.body(
            context,
            color: context.colorScheme.secondaryText,
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
        shadowColor: context.colorScheme.primaryText,
        color: context.colorScheme.card,
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
                        color: context.colorScheme.accentColor,
                        fontWeight: FontWeight.bold,
                      )
                    : fontTheme.title(
                        context,
                        color: context.colorScheme.accentColor,
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
                        color: context.colorScheme.primaryText,
                        fontWeight: FontWeight.w700,
                      )
                    : fontTheme.body(
                        context,
                        color: context.colorScheme.primaryText,
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
    return Container(
      color: context.colorScheme.card.withOpacity(0.5),
      height: 275.h,
      // width: double.infinity,
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
          // const Spacer(),
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
                          style: viewModel.fontTheme.title2(
                            context,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            viewModel.eventDetails.eventTime(
                              context,
                              "${model.startDate.toDate().hour}:${model.startDate.toDate().minute}",
                            ),
                            10.horizontalSpace,
                            viewModel.eventDetails.eventLocation(
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
                          color: context.colorScheme.accentColor,
                          boxShadow: [
                            BoxShadow(
                              color: context.colorScheme.accentColor
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
                            style: viewModel.fontTheme.caption(
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
        ],
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
          color: context.colorScheme.card,
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
                        color: context.colorScheme.accentColor,
                        boxShadow: [
                          BoxShadow(
                            color: context.colorScheme.accentColor
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
            color: context.colorScheme.card,
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
                  cachedHeight: 300,
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
    return Column(
      children: [
        15.verticalSpace,
        SizedBox(
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
        ),
        10.verticalSpace,
      ],
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
        color: context.colorScheme.card,
        child: Container(
            width: 190.w,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(20).r,
                    child: Container(
                      color: context.colorScheme.card,
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
                                  color: context.colorScheme.secondaryText)),
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
  final List<MemoriesModel> bestMemories;
  const BestMemories({super.key, required this.bestMemories});

  @override
  Widget build(BuildContext context) {
    return bestMemories.isEmpty
        ? const SizedBox()
        : StaggeredGrid.count(
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            children: [
              StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 2,
                child: MemoryCard(
                  imageUrl: bestMemories[0].imageUrl,
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 1,
                child: MemoryCard(
                  imageUrl: bestMemories[1].imageUrl,
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: MemoryCard(
                  imageUrl: bestMemories[2].imageUrl,
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: MemoryCard(
                  imageUrl: bestMemories[3].imageUrl,
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 4,
                mainAxisCellCount: 2,
                child: MemoryCard(
                  imageUrl: bestMemories[4].imageUrl,
                ),
              ),
            ],
          ).animate(delay: 2500.ms).shimmer();
  }
}

class MemoryCard extends StatelessWidget {
  final String? imageUrl;
  const MemoryCard({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            barrierColor: Colors.black.withOpacity(0.4),
            context: context,
            builder: (context) {
              return GestureDetector(
                onTap: () => Navigator.pop(context),
                child: InteractiveViewer(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 10,
                      sigmaY: 10,
                    ),
                    child: AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      titlePadding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 12),
                      content: ClipRRect(
                          borderRadius: BorderRadius.circular(20).r,
                          child: CachedNetworkImage(
                            imageUrl: imageUrl!,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) {
                              return const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularLoadingIndicator(),
                              );
                            },
                          )),
                    ),
                  ),
                ),
              );
            });
      },
      child: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.card,
          borderRadius: BorderRadius.all(
            const Radius.circular(12).r,
          ),
        ),
        padding: const EdgeInsets.all(8),
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              const Radius.circular(8).r,
            ),
          ),
          child: CachedNetworkImageWidget(
            imageUrl: imageUrl!,
            fit: BoxFit.cover,
            cachedHeight: 800,
          ),
        ),
      ),
    );
  }
}

class EventsTabview extends ViewModelWidget<EventViewModel> {
  const EventsTabview({super.key});

  @override
  Widget build(BuildContext context, EventViewModel viewModel) {
    final List<Tab> myTabs = <Tab>[
      const Tab(text: 'Events'),
      const Tab(text: 'Seminar'),
      const Tab(text: 'Workshop'),
      const Tab(text: 'Gallery'),
    ];

    final TabController tabController =
        TabController(length: myTabs.length, vsync: Scaffold.of(context));

    return SizedBox(
      height: 700.h,
      width: double.infinity,
      child: Scaffold(
        backgroundColor: context.colorScheme.scaffold,
        appBar: AppBar(
          backgroundColor: context.colorScheme.scaffold,
          toolbarHeight: 0,
          bottom: TabBar(
            controller: tabController,
            tabs: myTabs,
            labelColor: context.colorScheme.white,
            labelPadding: const EdgeInsets.all(0),
            padding: const EdgeInsets.symmetric(horizontal: 10).r,
            unselectedLabelColor:
                context.colorScheme.brightness == Brightness.light
                    ? context.colorScheme.black
                    : context.colorScheme.white,
            dividerColor: context.colorScheme.scaffold,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: FontThemeClass().caption(
              context,
              fontWeight: FontWeight.w600,
            ),
            indicator: BoxDecoration(
              color: context.colorScheme.accentColor,
              borderRadius: BorderRadius.circular(10).r,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 18).r,
          child: TabBarView(
            controller: tabController,
            physics: const NeverScrollableScrollPhysics(), // Disable swipe
            children: [
              const CategoryTabPage(),
              const Center(child: Text("Coming Soon...")),
              const Center(child: Text("Coming Soon...")),
              GalleryYearWiseView(
                gallery: viewModel.gallery,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTabPage extends ViewModelWidget<EventViewModel> {
  const CategoryTabPage({super.key});

  @override
  Widget build(BuildContext context, EventViewModel viewModel) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          viewModel.todayEvent?.length == 1
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Lottie.asset(
                            AnimationAssets.livePing,
                            repeat: true,
                            reverse: false,
                            frameRate: const FrameRate(60),
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SectionText(
                          title: "Ongoing Events",
                          height: 8,
                        ),
                      ],
                    ),
                    Card(
                      clipBehavior: Clip.hardEdge,
                      color: context.colorScheme.card,
                      shadowColor: context.colorScheme.card.withOpacity(0.8),
                      elevation: 2,
                      shape: ShapeBorder.lerp(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25).r,
                        ),
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25).r,
                        ),
                        1,
                      ),
                      child: Stack(
                        children: [
                          EventCardInfo(
                            model: viewModel.todayEvent![0],
                          ),
                          EventDateContainer(
                            right: 10.w,
                            top: 10.h,
                            height: 70.r,
                            width: 70.r,
                            timeFontSize: 30.sp,
                            textFontSize: 20.sp,
                            event: viewModel.todayEvent![0],
                            isUpcomming: false,
                          ),
                        ],
                      ),
                    ).animate(delay: 100.ms).fadeIn(),
                  ],
                )
              : viewModel.todayEvent!.isEmpty
                  ? 0.verticalSpace
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionText(title: "Ongoing Events"),
                        CarouselSlider.builder(
                          itemCount: viewModel._todayEvent.length,
                          options: viewModel.ongoingCarosoulOptions,
                          itemBuilder: (context, index, realIndex) {
                            return SizedBox(
                              child: Card(
                                clipBehavior: Clip.hardEdge,
                                shadowColor:
                                    context.colorScheme.card.withOpacity(0.8),
                                elevation: 2,
                                color: context.colorScheme.card,
                                shape: ShapeBorder.lerp(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25).r,
                                  ),
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25).r,
                                  ),
                                  1,
                                ),
                                child: Stack(
                                  children: [
                                    EventCardInfo(
                                      model: viewModel.todayEvent![index],
                                    ),
                                    EventDateContainer(
                                      top: 118.h,
                                      left: 10.w,
                                      height: 70.r,
                                      width: 70.r,
                                      timeFontSize: 30.sp,
                                      textFontSize: 20.sp,
                                      event: viewModel.todayEvent![index],
                                      isUpcomming: false,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ).animate(delay: 110.ms).fadeIn(),
                      ],
                    ),
          viewModel.sponsors.isEmpty
              ? SizedBox(
                  height: 145.h,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionText(title: "Sponsors"),
                    CarouselSlider.builder(
                      itemCount: viewModel.sponsors.length,
                      options: viewModel.sponsorsCarosoulOptions,
                      itemBuilder: (context, index, realIndex) {
                        return Sponsors(
                          model: viewModel.sponsors[index],
                        );
                      },
                    )
                  ],
                ).animate(delay: 130.ms).fadeIn(),
          viewModel.upcomingEvents.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionText(
                        title:
                            "Upcoming Events | ${viewModel.upcomingEvents.length}"),
                    viewModel.upcomingEvents.isEmpty
                        ? Container()
                        : CarouselSlider.builder(
                            itemCount: viewModel.upcomingEvents.length,
                            options: CarouselOptions(
                              scrollPhysics: const BouncingScrollPhysics(),
                              autoPlayCurve: Curves.easeInOutCubic,
                              enableInfiniteScroll: true,
                              autoPlay: true,
                              autoPlayInterval: 4.seconds,
                              autoPlayAnimationDuration: 1.seconds,
                              pauseAutoPlayOnTouch: true,
                              pauseAutoPlayInFiniteScroll: true,
                              viewportFraction: 0.65,
                            ),
                            itemBuilder: (context, index, realIndex) {
                              return SizedBox(
                                height: 210.h,
                                child: Card(
                                  clipBehavior: Clip.hardEdge,
                                  shadowColor:
                                      context.colorScheme.card.withOpacity(0.8),
                                  elevation: 1,
                                  shape: ShapeBorder.lerp(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18).r,
                                    ),
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18).r,
                                    ),
                                    1,
                                  ),
                                  child: Stack(
                                    children: [
                                      EventCardUpcoming(
                                        model: viewModel.upcomingEvents[index],
                                      ),
                                      EventDateContainer(
                                        top: 2.h,
                                        right: 2.w,
                                        height: 65.r,
                                        width: 60.r,
                                        timeFontSize: 30.sp,
                                        textFontSize: 20.sp,
                                        event: viewModel.upcomingEvents[index],
                                        isUpcomming: true,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ).animate(delay: 140.ms).fadeIn(),
                  ],
                )
              : 0.verticalSpace,
          4.verticalSpace,
          // viewModel.todayEvent!.isEmpty && viewModel.upcomingEvents.isEmpty
          //     ? Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           const SectionText(title: "Best Memories"),
          //           BestMemories(
          //             bestMemories: viewModel._bestMemories,
          //           )
          //         ],
          //       )
          //         .animate(delay: 1000.ms)
          //         .fadeIn(duration: const Duration(milliseconds: 1000))
          //     : 0.verticalSpace
        ],
      ),
    );
  }
}
