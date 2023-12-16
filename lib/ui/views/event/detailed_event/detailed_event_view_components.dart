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
            background: Image.network(
              imageLink,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 276.h,
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
                      style: fontTheme.title2(context,
                          color: context.colorScheme.primaryDarkColor,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          10.verticalSpace,
          Text(
            eventName,
            style: fontTheme.header(context),
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
                  color: context.colorScheme.primaryColor,
                ),
              ),
              Text(
                "${eventStartDate.day}-${eventEndDate.day} ${DateFormat('MMMM yyyy').format(eventEndDate)}",
                style: fontTheme.body(context,
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
                ),
              ),
              Text(
                "${eventStartDate.hour}:${eventStartDate.minute} AM",
                style: fontTheme.body(context,
                    color: context.colorScheme.secondarySectionColor,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          28.verticalSpace,
          Text(
            "About Event",
            style: fontTheme.header(context),
          ),
          8.verticalSpace,
          Text(
            eventInfo,
            style: fontTheme.body(
              context,
              color: context.colorScheme.secondaryBlackColor.withOpacity(0.8),
            ),
          ),
          20.verticalSpace,
          Divider(
            color: context.colorScheme.secondaryBlackColor.withOpacity(0.2),
            height: 1.h,
          ),
          20.verticalSpace,
          Text(
            "Contact Section",
            style: fontTheme.header(
              context,
            ),
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
                  size: 28.sp,
                  color: context.colorScheme.primaryColor,
                ),
              ),
              Text(eventContactName,
                  style: fontTheme.body(context, fontWeight: FontWeight.w500)),
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
                  size: 28.h,
                  color: context.colorScheme.primaryColor,
                ),
              ),
              Text(eventContactEmail,
                  style: fontTheme.body(context, fontWeight: FontWeight.w500)),
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
                  size: 28.h,
                  color: context.colorScheme.primaryColor,
                ),
              ),
              Text(eventContactNumber.toString(),
                  style: fontTheme.body(context, fontWeight: FontWeight.w500)),
            ],
          ),
          28.verticalSpace,
        ]),
      ),
    );
  }
}

class BottomNavBarDetailedPage extends ViewModelWidget<DetailedEventViewModel> {
  final String eventName;
  final DateTime eventStartDate;
  final DateTime eventEndDate;
  final String eventInfo;
  final String eventContactName;
  final String eventContactEmail;
  final int eventContactNumber;
  const BottomNavBarDetailedPage({
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

    return SizedBox(
      height: 80.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(160.w, 55.h),
              backgroundColor: context.colorScheme.secondaryWhiteColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  const Radius.circular(
                    50,
                  ).r,
                ),
              ),
              side: BorderSide(color: context.colorScheme.primaryColor),
            ),
            onPressed: () {
              Share.share(
                  "$eventName\n$eventInfo\nEvent Date: ${eventStartDate.day}${DateFormat('MMMM yyyy').format(eventEndDate)}\nTiming: ${eventStartDate.hour}:${eventStartDate.minute}\nContact $eventContactName for more details\nContact Number: $eventContactNumber");
            },
            child: Text(
              'Share',
              style: fontTheme.title(
                context,
                color: context.colorScheme.primaryColor,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(160.w, 55.h),
              backgroundColor: context.colorScheme.primaryColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  const Radius.circular(50).r,
                ),
                side: BorderSide(color: context.colorScheme.primaryColor),
              ),
            ),
            onPressed: () {
              UrlLauncher().launchURL(viewModel.eventData.registerUrl);
            },
            child: Text(
              'Register',
              style: fontTheme.title(context,
                  color: context.colorScheme.secondaryWhiteColor),
            ),
          ),
        ],
      ),
    );
  }
}
