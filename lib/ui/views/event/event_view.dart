import 'dart:ui';

import 'package:abhiyaan/ui/common/circular_loading_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:abhiyaan/ui/common/url_launcher.dart';
import 'package:abhiyaan/services/firestore_service.dart';
import 'package:abhiyaan/theme/responsive_utils.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:abhiyaan/ui/common/cached_network_image.dart';
import 'package:abhiyaan/file_exporter.dart';

part 'event_view_model.dart';
part 'event_view_components.dart';

class EventView extends StatelessWidget {
  const EventView({super.key});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EventViewModel>.reactive(
      viewModelBuilder: () => EventViewModel(),
      disposeViewModel: false,
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: context.colorScheme.scaffold,
          body: model.events.isEmpty
              ? const CircularLoadingIndicator()
              : SafeArea(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 18.0).r,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          18.verticalSpace,
                          Center(
                            child: Text(
                              "Events",
                              style: FontThemeClass().title(
                                context,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          model.todayEvent?.length == 1
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SectionText(title: "Ongoing Events"),
                                    Card(
                                      clipBehavior: Clip.hardEdge,
                                      color: context.colorScheme.card,
                                      shadowColor: context.colorScheme.card
                                          .withOpacity(0.8),
                                      elevation: 2,
                                      shape: ShapeBorder.lerp(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25).r,
                                        ),
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25).r,
                                        ),
                                        1,
                                      ),
                                      child: Stack(
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
                                            isUpcomming: false,
                                          ),
                                        ],
                                      ),
                                    ).animate(delay: 100.ms).fadeIn(),
                                  ],
                                )
                              : model.todayEvent!.isEmpty
                                  ? 0.verticalSpace
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SectionText(
                                            title: "Ongoing Events"),
                                        CarouselSlider.builder(
                                          itemCount: model._todayEvent.length,
                                          options: model.ongoingCarosoulOptions,
                                          itemBuilder:
                                              (context, index, realIndex) {
                                            return SizedBox(
                                              child: Card(
                                                clipBehavior: Clip.hardEdge,
                                                shadowColor: context
                                                    .colorScheme.card
                                                    .withOpacity(0.8),
                                                elevation: 2,
                                                color: context.colorScheme.card,
                                                shape: ShapeBorder.lerp(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                                25)
                                                            .r,
                                                  ),
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                                25)
                                                            .r,
                                                  ),
                                                  1,
                                                ),
                                                child: Stack(
                                                  children: [
                                                    EventCardInfo(
                                                      model: model
                                                          .todayEvent![index],
                                                    ),
                                                    EventDateContainer(
                                                      top: 118.h,
                                                      left: 10.w,
                                                      height: 70.r,
                                                      width: 70.r,
                                                      timeFontSize: 30.sp,
                                                      textFontSize: 20.sp,
                                                      event: model
                                                          .todayEvent![index],
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
                          model.sponsors.isEmpty
                              ? SizedBox(
                                  height: 145.h,
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SectionText(title: "Sponsors"),
                                    CarouselSlider.builder(
                                      itemCount: model.sponsors.length,
                                      options: model.sponsorsCarosoulOptions,
                                      itemBuilder: (context, index, realIndex) {
                                        return Sponsors(
                                          model: model.sponsors[index],
                                        );
                                      },
                                    )
                                  ],
                                ).animate(delay: 130.ms).fadeIn(),
                          model.upcomingEvents.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SectionText(
                                        title:
                                            "Upcoming Events | ${model.upcomingEvents.length}"),
                                    model.upcomingEvents.isEmpty
                                        ? Container()
                                        : CarouselSlider.builder(
                                            itemCount:
                                                model.upcomingEvents.length,
                                            options: CarouselOptions(
                                              scrollPhysics:
                                                  const BouncingScrollPhysics(),
                                              autoPlayCurve:
                                                  Curves.easeInOutCubic,
                                              enableInfiniteScroll: true,
                                              autoPlay: true,
                                              autoPlayInterval: 4.seconds,
                                              autoPlayAnimationDuration:
                                                  1.seconds,
                                              pauseAutoPlayOnTouch: true,
                                              pauseAutoPlayInFiniteScroll: true,
                                              viewportFraction: 0.65,
                                            ),
                                            itemBuilder:
                                                (context, index, realIndex) {
                                              return SizedBox(
                                                height: 210.h,
                                                child: Card(
                                                  clipBehavior: Clip.hardEdge,
                                                  shadowColor: context
                                                      .colorScheme.card
                                                      .withOpacity(0.8),
                                                  elevation: 1,
                                                  shape: ShapeBorder.lerp(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                                  18)
                                                              .r,
                                                    ),
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                                  18)
                                                              .r,
                                                    ),
                                                    1,
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                      EventCardUpcoming(
                                                        model: model
                                                                .upcomingEvents[
                                                            index],
                                                      ),
                                                      EventDateContainer(
                                                        top: 2.h,
                                                        right: 2.w,
                                                        height: 65.r,
                                                        width: 60.r,
                                                        timeFontSize: 30.sp,
                                                        textFontSize: 20.sp,
                                                        event: model
                                                                .upcomingEvents[
                                                            index],
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
                          model.gallery.isNotEmpty
                              ? const SectionText(title: "Gallery")
                                  .animate(delay: 800.ms)
                                  .fadeIn()
                              : 0.verticalSpace,
                          model.gallery.isNotEmpty
                              ? GalleryYearWiseView(
                                  gallery: model.gallery,
                                ).animate(delay: 800.ms).fadeIn()
                              : 0.verticalSpace,
                          model.todayEvent!.isEmpty &&
                                  model.upcomingEvents.isEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SectionText(title: "Best Memories"),
                                    BestMemories(
                                      bestMemories: model._bestMemories,
                                    )
                                  ],
                                ).animate(delay: 1000.ms).fadeIn(
                                  duration: const Duration(milliseconds: 1000))
                              : 0.verticalSpace
                        ].animate(delay: 100.ms, interval: 40.ms).fadeIn()),
                  ),
                ),
        );
      },
    );
  }
}
