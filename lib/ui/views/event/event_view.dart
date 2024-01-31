import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:abhiyaan/ui/common/url_launcher.dart';
import 'package:abhiyaan/ui/common/shimmer.dart';
import 'package:abhiyaan/services/firestore_service.dart';
import 'package:abhiyaan/theme/responsive_utils.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:abhiyaan/ui/common/cached_network_image.dart';
import 'package:abhiyaan/file_exporter.dart';
part 'event_view_model.dart';
part 'event_view_components.dart';

class EventView extends StatelessWidget {
  const EventView({super.key});
  @override
  Widget build(BuildContext context) {
    FontThemeClass fontTheme = FontThemeClass();
    return ViewModelBuilder<EventViewModel>.reactive(
      viewModelBuilder: () => EventViewModel(),
      disposeViewModel: false,
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: context.colorScheme.backgroundColor,
          body: model.events.isEmpty
              ? const EventShimmerEffect()
              : SafeArea(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 18.0).r,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionText(title: "Ongoing Events"),
                        model.todayEvent?.length == 1 ||
                                model.todayEvent!.isEmpty
                            ? Card(
                                clipBehavior: Clip.hardEdge,
                                shadowColor: context
                                    .colorScheme.secondaryWhiteColor
                                    .withOpacity(0.8),
                                elevation: 2,
                                shape: ShapeBorder.lerp(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18).r,
                                    ),
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18).r,
                                    ),
                                    1),
                                color: context.colorScheme.secondaryWhiteColor,
                                child: model.todayEvent?.length == 1
                                    ? Stack(
                                        children: [
                                          EventCardInfo(
                                            model: model.todayEvent![0],
                                          ),
                                          EventDateContainer(
                                            top: 118.h,
                                            left: 10.w,
                                            height: 70.r,
                                            width: 70.r,
                                            timeFontSize: 30.sp,
                                            textFontSize: 20.sp,
                                            event: model.todayEvent![0],
                                          ),
                                        ],
                                      )
                                    : Center(
                                        child: Container(
                                          color: context
                                              .colorScheme.secondaryWhiteColor
                                              .withOpacity(0.5),
                                          height: 261.h,
                                          width: ResponsiveUtils.screenWidth(
                                              context),
                                          child: Column(
                                            children: [
                                              CachedNetworkImageWidget(
                                                imageUrl:
                                                    "https://imgs.search.brave.com/DGoVUPXpo3OwVAbBbgF3oGz3MUcz_cPZrzmfvO7iRrc/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9jZG5p/Lmljb25zY291dC5j/b20vaWxsdXN0cmF0/aW9uL3ByZW1pdW0v/dGh1bWIvc2VhcmNo/LXJlc3VsdC1ub3Qt/Zm91bmQtMjEzMDM1/NS0xODAwOTIwLnBu/Zz9mPXdlYnA",
                                                height: 200.h,
                                                width: 200.w,
                                                fit: BoxFit.cover,
                                                maxHeightDiskCache: 400,
                                              ),
                                              Text(
                                                "No Ongoing Events",
                                                style: fontTheme.title2(context,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                              )
                            : CarouselSlider.builder(
                                itemCount: model._todayEvent.length,
                                options: model.ongoingCarosoulOptions,
                                itemBuilder: (context, index, realIndex) {
                                  return SizedBox(
                                    child: Card(
                                        clipBehavior: Clip.hardEdge,
                                        shadowColor: context
                                            .colorScheme.secondaryWhiteColor
                                            .withOpacity(0.8),
                                        elevation: 2,
                                        color: context
                                            .colorScheme.secondaryWhiteColor,
                                        child: Stack(
                                          children: [
                                            EventCardInfo(
                                              model: model.todayEvent![index],
                                            ),
                                            EventDateContainer(
                                              top: 118.h,
                                              left: 10.w,
                                              height: 70.r,
                                              width: 70.r,
                                              timeFontSize: 30.sp,
                                              textFontSize: 20.sp,
                                              event: model.todayEvent![index],
                                            ),
                                          ],
                                        )),
                                  );
                                },
                              ),
                        model.sponsors.isEmpty
                            ? Container()
                            : const SectionText(title: "Sponsors"),
                        SizedBox(
                          height: 80.h,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: model.sponsors.length,
                            itemBuilder: (context, index) {
                              return Sponsors(
                                model: model.sponsors[index],
                              );
                            },
                          ),
                        ).animate(delay: 200.ms).fadeIn(),
                        const SectionText(title: "Upcoming Events"),
                        CarouselSlider.builder(
                          itemCount: model.upcomingEvents.length,
                          options: model.upcommingCarosoulOptions,
                          itemBuilder: (context, index, realIndex) {
                            return SizedBox(
                              height: 210.h,
                              child: Card(
                                clipBehavior: Clip.hardEdge,
                                shadowColor: context
                                    .colorScheme.secondaryLPurpleColor
                                    .withOpacity(0.8),
                                elevation: 2,
                                shape: ShapeBorder.lerp(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18).r,
                                    ),
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18).r,
                                    ),
                                    1),
                                child: Stack(
                                  children: [
                                    EventCardUpcoming(
                                      model: model.upcomingEvents[index],
                                    ),
                                    EventDateContainer(
                                      top: 2.h,
                                      right: 2.w,
                                      height: 65.r,
                                      width: 60.r,
                                      timeFontSize: 30.sp,
                                      textFontSize: 20.sp,
                                      event: model.upcomingEvents[index],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        4.verticalSpace,
                      ].animate(delay: 100.ms, interval: 40.ms).fadeIn(),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
