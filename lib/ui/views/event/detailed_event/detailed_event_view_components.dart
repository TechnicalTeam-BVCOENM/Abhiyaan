part of 'detailed_event_view.dart';

class DetailedEventAppBar extends ViewModelWidget<DetailedEventViewModel> {
  final String imageLink;
  final String eventLocation;
  final String eventName;
  const DetailedEventAppBar(
      {super.key,
      required this.imageLink,
      required this.eventLocation,
      required this.eventName});

  @override
  Widget build(BuildContext context, DetailedEventViewModel viewModel) {
    FontThemeClass fontTheme = FontThemeClass();
    return SliverAppBar(
      foregroundColor: context.colorScheme.primaryText,
      backgroundColor: context.colorScheme.scaffold,
      elevation: 0.0,
      pinned: false,
      stretch: true,
      expandedHeight: 276.h,
      flexibleSpace: Stack(
        children: [
          FlexibleSpaceBar(
            background: Hero(
              transitionOnUserGestures: true,
              tag: "eventImage+$imageLink-$eventName",
              child: CachedNetworkImageWidget(
                imageUrl: imageLink,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 276.h,
                maxHeightDiskCache: MediaQuery.of(context).size.width * 0.65,
              ).animate().shimmer(duration: 1000.ms, padding: 0),
            ),
            stretchModes: const [
              StretchMode.blurBackground,
              StretchMode.zoomBackground
            ],
          ),
          Positioned(
            bottom: -1.r,
            left: 0.r,
            right: 0.r,
            child: Container(
              height: 30.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: context.colorScheme.card,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ).r,
              ),
            ),
          ),
          Positioned(
            bottom: 2.r,
            right: 20.r,
            child: Material(
              elevation: 2.h,
              borderRadius: BorderRadius.circular(10).r,
              child: Container(
                padding: const EdgeInsets.all(15).r,
                decoration: BoxDecoration(
                  color: context.colorScheme.card.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10).r,
                ),
                height: 60.h,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.pin_drop,
                      color: context.colorScheme.accentColor,
                    ),
                    4.horizontalSpace,
                    Text(
                      eventLocation,
                      textAlign: TextAlign.center,
                      style: fontTheme.body(
                        context,
                        color: context.colorScheme.primaryText,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ).animate().shimmer(duration: 1000.ms, padding: 0),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailedEventData extends ViewModelWidget<DetailedEventViewModel> {
  final EventModel eventData;
  const DetailedEventData({
    super.key,
    required this.eventData,
  });

  @override
  Widget build(BuildContext context, DetailedEventViewModel viewModel) {
    FontThemeClass fontTheme = FontThemeClass();

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.verticalSpace,
            Row(
              children: [
                Text(
                  eventData.title.length > 20
                      ? "${eventData.title.substring(0, 20)}..."
                      : eventData.title,
                  style: fontTheme.title(context, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            10.verticalSpace,
            Row(
              children: [
                Container(
                  height: 24.h,
                  width: 24.w,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(right: 8.0).r,
                  child: Icon(
                    Icons.calendar_month,
                    size: 20,
                    color: context.colorScheme.accentColor,
                  ),
                ),
                Text(
                  "${eventData.startDate.toDate().day}-${eventData.endDate.toDate().day} ${DateFormat('MMMM yyyy').format(eventData.startDate.toDate())}",
                  style: fontTheme.caption(
                    context,
                    color: context.colorScheme.primaryText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            6.verticalSpace,
            Row(
              children: [
                Container(
                  height: 24.h,
                  width: 24.w,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(right: 8.0).r,
                  child: Icon(
                    Icons.timer,
                    color: context.colorScheme.accentColor,
                    size: 20,
                  ),
                ),
                Text(
                  "${eventData.startDate.toDate().hour}:${eventData.startDate.toDate().minute} AM",
                  style: fontTheme.caption(
                    context,
                    color: context.colorScheme.primaryText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            28.verticalSpace,
            Text(
              "About Event",
              style: fontTheme.paragraph(
                context,
                fontWeight: FontWeight.w600,
              ),
            ),
            8.verticalSpace,
            Text(
              eventData.about,
              textAlign: TextAlign.justify,
              style: fontTheme.caption(
                context,
                color: context.colorScheme.primaryText.withOpacity(0.8),
              ),
            ),
            12.verticalSpace,
            GestureDetector(
              onTap: () {
                viewModel.addEventToCalender(eventData);
              },
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      context.colorScheme.accentColor.withOpacity(0.7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10).r,
                  ),
                ),
                onPressed: () {
                  viewModel.addEventToCalender(eventData);
                },
                child: Text(
                  "Add to Calender",
                  style: fontTheme.body(
                    context,
                    color: context.colorScheme.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            20.verticalSpace,
            Divider(
              color: context.colorScheme.primaryText.withOpacity(0.2),
              height: 1.h,
            ),
            20.verticalSpace,
            viewModel._bestMoments.isEmpty
                ? Container()
                : SizedBox(
                    height: 230.h,
                    width: double.infinity,
                    child: CarouselSlider.builder(
                      itemCount: viewModel._bestMoments.length,
                      itemBuilder: (context, index, realIndex) {
                        return CarouselUtils.buildImage(
                          context,
                          viewModel._bestMoments[index]['imageUrl'],
                          viewModel.activeIndex,
                        );
                      },
                      options: CarouselOptions(
                        height: 230.h,
                        onPageChanged: (index, reason) =>
                            viewModel.updateActiveIndex(index),
                        autoPlay: true,
                        autoPlayInterval: 4.seconds,
                        viewportFraction: 1,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: 1.seconds,
                        autoPlayCurve: Curves.easeInOut,
                        enlargeCenterPage: true,
                      ),
                    ),
                  ),
            12.verticalSpace,
            viewModel._bestMoments.isEmpty
                ? Container()
                : Center(
                    child: CarouselUtils.buildIndicator(
                      context,
                      viewModel.activeIndex,
                      viewModel._bestMoments.length,
                    ),
                  ),
            Text(
              "Contact Section",
              style: fontTheme.paragraph(context, fontWeight: FontWeight.w700),
            ),
            20.verticalSpace,
            eventData.cName.isNotEmpty
                ? Row(
                    children: [
                      Container(
                        height: 28.h,
                        width: 28.w,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(right: 8.0).r,
                        child: Icon(
                          Icons.account_circle,
                          size: 24.sp,
                          color: context.colorScheme.accentColor,
                        ),
                      ),
                      Text(
                        eventData.cName,
                        style: fontTheme.caption(context),
                      ),
                    ],
                  )
                : const SizedBox(),
            8.verticalSpace,
            eventData.cEmail.isNotEmpty
                ? Row(
                    children: [
                      Container(
                        height: 28.h,
                        width: 28.w,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.email,
                          size: 24.h,
                          color: context.colorScheme.accentColor,
                        ),
                      ),
                      Text(eventData.cEmail,
                          style: fontTheme.caption(
                            context,
                          )),
                    ],
                  )
                : const SizedBox(),
            8.verticalSpace,
            eventData.cPhone.toString().isNotEmpty
                ? Row(
                    children: [
                      Container(
                        height: 28.h,
                        width: 28.w,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(right: 8.0),
                        // decoration: BoxDecoration(
                        //   shape: BoxShape.circle,
                        //   color: Colors.white,
                        // ),
                        child: Icon(
                          Icons.phone_in_talk_rounded,
                          size: 24.sp,
                          color: context.colorScheme.accentColor,
                        ),
                      ),
                      Text(
                        eventData.cPhone.toString(),
                        style: fontTheme.caption(context),
                      ),
                    ],
                  )
                : const SizedBox(),
            40.verticalSpace,
            const Text(""),
            32.verticalSpace,
          ].animate(delay: 0.ms, interval: 100.ms).fadeIn(curve: Curves.easeIn),
        ),
      ),
    );
  }
}
