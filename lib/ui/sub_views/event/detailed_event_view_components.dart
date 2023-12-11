import 'package:darpan/file_exporter.dart';
import 'package:darpan/ui/common/common_component_model.dart';
import 'package:darpan/ui/sub_views/event/detailed_event_view.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class DetailedEventAppBar extends ViewModelWidget<DetailedEventViewModel> {
  final String imageLink;
  final String eventLocation;
  const DetailedEventAppBar(
      {super.key, required this.imageLink, required this.eventLocation});

  @override
  Widget build(BuildContext context, DetailedEventViewModel viewModel) {
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
            bottom: -1,
            left: 0,
            right: 0,
            child: Container(
              height: 30.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: context.colorScheme.backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.h),
                  topRight: Radius.circular(15.h),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 2.r,
            right: 20.r,
            child: Material(
              elevation: 2.h,
              borderRadius: BorderRadius.circular(10.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 15.h),
                decoration: BoxDecoration(
                  color: context.colorScheme.secondaryWhiteColor,
                  borderRadius: BorderRadius.circular(10.h),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.pin_drop,
                      color: context.colorScheme.primaryColor,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      eventLocation,
                      style: FontThemeClass().heading3(
                          context,
                          context.colorScheme.primaryDarkColor,
                          FontWeight.w700),
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
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          10.h.verticalSpace,
          Text(
            eventName,
            style: FontThemeClass().heading(context,
                size: 35.sp, color: context.colorScheme.primaryDarkColor),
          ),
          10.h.verticalSpace,
          Row(
            children: [
              Container(
                height: 24.r,
                width: 24.r,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(right: 8.0).r,
                child: Icon(
                  Icons.calendar_month,
                  color: context.colorScheme.primaryColor,
                ),
              ),
              Text(
                "${eventStartDate.day}-${eventEndDate.day} ${DateFormat('MMMM yyyy').format(eventEndDate)}",
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: context.colorScheme.secondarySectionColor),
              ),
            ],
          ),
          SizedBox(
            height: 7.h,
          ),
          Row(
            children: [
              Container(
                height: 24.h,
                width: 24.h,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.timer,
                  color: context.colorScheme.primaryColor,
                ),
              ),
              Text(
                "${eventStartDate.hour}:${eventStartDate.minute}",
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: context.colorScheme.secondarySectionColor),
              ),
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          Text(
            "About Event",
            style: FontThemeClass().heading(context,
                size: 25.sp, color: context.colorScheme.primaryDarkColor),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            eventInfo,
            style: FontThemeClass().paragraph(
              context,
              size: 16.sp,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Divider(
            color: Colors.black12,
            height: 1.h,
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "Contact Section",
            style: FontThemeClass().heading(context,
                size: 25.sp, color: context.colorScheme.primaryDarkColor),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              Container(
                height: 28.h,
                width: 28.w,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.account_circle,
                  size: 28.h,
                  color: context.colorScheme.primaryColor,
                ),
              ),
              Text(
                eventContactName,
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: context.colorScheme.primaryDarkColor),
              ),
            ],
          ),
          SizedBox(
            height: 7.h,
          ),
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
              Text(
                eventContactEmail,
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: context.colorScheme.primaryDarkColor),
              ),
            ],
          ),
          SizedBox(
            height: 7.h,
          ),
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
              Text(
                eventContactNumber.toString(),
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: context.colorScheme.primaryDarkColor),
              ),
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
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
    return SizedBox(
      height: 80.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(160.w, 55.h),
              backgroundColor: Colors.white,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    50,
                  ),
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
              style: FontThemeClass().heading2(
                context,
                context.colorScheme.primaryColor,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(160.w, 55.h),
              backgroundColor: context.colorScheme.primaryColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(50),
                ),
                side: BorderSide(color: context.colorScheme.primaryColor),
              ),
            ),
            onPressed: () {
              UrlLauncher().launchURL(viewModel.eventData.registerUrl);
            },
            child: Text(
              'Register',
              style: FontThemeClass().heading2(context, Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
