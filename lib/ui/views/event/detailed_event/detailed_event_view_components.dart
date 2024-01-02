part of '../detailed_event/detailed_event_view.dart';

class DetailedEventAppBar extends ViewModelWidget<DetailedEventViewModel> {
  final String imageLink;
  final String eventLocation;
  const DetailedEventAppBar(
      {super.key, required this.imageLink, required this.eventLocation});

  @override
  Widget build(BuildContext context, DetailedEventViewModel viewModel) {
    FontThemeClass fontTheme = FontThemeClass();
    return SliverAppBar(
      foregroundColor: context.colorScheme.signInTextColor,
      backgroundColor: context.colorScheme.backgroundColor,
      elevation: 0.0,
      pinned: false,
      stretch: true,
      expandedHeight: 276.h,
      flexibleSpace: Stack(
        children: [
          FlexibleSpaceBar(
            background: Hero(
              transitionOnUserGestures: true,
              tag: "eventImage+$imageLink",
              child: Image.network(
                imageLink,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 276.h,
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
                color: context.colorScheme.backgroundColor,
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
                  color: context.colorScheme.secondaryWhiteColor,
                  borderRadius: BorderRadius.circular(10).r,
                ),
                height: 60.h,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.pin_drop,
                      color: context.colorScheme.primaryColor,
                    ),
                    4.horizontalSpace,
                    Text(
                      eventLocation,
                      textAlign: TextAlign.center,
                      style: fontTheme.body(context,
                          color: context.colorScheme.primaryDarkColor,
                          fontWeight: FontWeight.w700),
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
  final String eventName;
  final DateTime eventStartDate;
  final DateTime eventEndDate;
  final String eventInfo;
  final String eventContactName;
  final String eventContactEmail;
  final int eventContactNumber;
  const DetailedEventData({
    super.key,
    required this.eventName,
    required this.eventStartDate,
    required this.eventInfo,
    required this.eventEndDate,
    required this.eventContactName,
    required this.eventContactEmail,
    required this.eventContactNumber,
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
              Text(
                eventName,
                style: fontTheme.title(context, fontWeight: FontWeight.w700),
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
                      color: context.colorScheme.primaryColor,
                    ),
                  ),
                  Text(
                    "${eventStartDate.day}-${eventEndDate.day} ${DateFormat('MMMM yyyy').format(eventEndDate)}",
                    style: fontTheme.caption(context,
                        color: context.colorScheme.secondarySectionColor,
                        fontWeight: FontWeight.w500),
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
                      color: context.colorScheme.primaryColor,
                      size: 20,
                    ),
                  ),
                  Text(
                    "${eventStartDate.hour}:${eventStartDate.minute} AM",
                    style: fontTheme.caption(context,
                        color: context.colorScheme.secondarySectionColor,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              28.verticalSpace,
              Text(
                "About Event",
                style:
                    fontTheme.paragraph(context, fontWeight: FontWeight.w600),
              ),
              8.verticalSpace,
              Text(
                eventInfo,
                textAlign: TextAlign.justify,
                style: fontTheme.caption(
                  context,
                  color:
                      context.colorScheme.secondaryBlackColor.withOpacity(0.8),
                ),
              ),
              20.verticalSpace,
              Divider(
                color: context.colorScheme.secondaryBlackColor.withOpacity(0.2),
                height: 1.h,
              ),
              20.verticalSpace,

              viewModel._bestMoments.isEmpty
                  ? Container(
                      height: 230.h,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Card(
                        margin: const EdgeInsets.only(bottom: 8).r,
                        elevation: 0,
                        clipBehavior: Clip.hardEdge,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16).r,
                          side: BorderSide(
                            color: context.colorScheme.secondaryLPurpleColor,
                            width: 1.0,
                          ),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.info_rounded,
                                color: context.colorScheme.secondaryBlackColor,
                              ),
                              10.horizontalSpace,
                              Text("Stay Tuned Comming Soon !",
                                  style:
                                      viewModel.fontThemeClass.body(context)),
                            ],
                          ),
                        ),
                      ),
                    )
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
              Center(
                child: CarouselUtils.buildIndicator(
                  context,
                  viewModel.activeIndex,
                  viewModel._bestMoments.length,
                ),
              ),

              Text(
                "Contact Section",
                style:
                    fontTheme.paragraph(context, fontWeight: FontWeight.w700),
              ),
              20.verticalSpace,
              Row(
                children: [
                  Container(
                    height: 28.h,
                    width: 28.w,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 8.0).r,
                    child: Icon(
                      Icons.account_circle,
                      size: 24.sp,
                      color: context.colorScheme.primaryColor,
                    ),
                  ),
                  Text(eventContactName, style: fontTheme.caption(context)),
                ],
              ),
              8.verticalSpace,
              Row(
                children: [
                  Container(
                    height: 28.h,
                    width: 28.w,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.email,
                      size: 24.h,
                      color: context.colorScheme.primaryColor,
                    ),
                  ),
                  Text(eventContactEmail,
                      style: fontTheme.caption(
                        context,
                      )),
                ],
              ),
              8.verticalSpace,
              Row(
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
                      color: context.colorScheme.primaryColor,
                    ),
                  ),
                  Text(eventContactNumber.toString(),
                      style: fontTheme.caption(context)),
                ],
              ),
              40.verticalSpace,
              const Text(""),
              32.verticalSpace,

            ]
                .animate(delay: 0.ms, interval: 100.ms)
                .fadeIn(curve: Curves.easeIn)),

      ),
    );
  }
}
