import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darpan/ui/common/common_component_model.dart';
import 'package:darpan/ui/common/shimmer.dart';
import 'package:darpan/services/firestore_service.dart';
import 'package:darpan/theme/responsive_utils.dart';
import 'package:intl/intl.dart';
import 'package:darpan/ui/common/cached_network_image.dart';
import 'package:darpan/file_exporter.dart';
part 'event_view_model.dart';
part 'event_view_components.dart';

class EventView extends StatelessWidget {
  const EventView({super.key});
  @override
  Widget build(BuildContext context) {
    FontThemeClass fontTheme = FontThemeClass();
    return ViewModelBuilder<EventViewModel>.reactive(
      viewModelBuilder: () => EventViewModel(),
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: context.colorScheme.backgroundColor,
          body: model.isBusy
              ? const ShimmerLoadingWidget()
              : SafeArea(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionText(title: "Ongoing Events"),
                        Card(
                          clipBehavior: Clip.hardEdge,
                          shadowColor: context.colorScheme.secondaryLPurpleColor
                              .withOpacity(0.8),
                          elevation: 4,
                          shape: ShapeBorder.lerp(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.sp),
                              ),
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.sp),
                              ),
                              1),
                          child: model.todayEvent != null
                              ? Stack(
                                  children: [
                                    EventCardInfo(
                                      model: model.todayEvent!,
                                    ),
                                    EventDateContainer(
                                      top: 120.sp,
                                      left: 20.sp,
                                      event: model.todayEvent!,
                                    ),
                                  ],
                                )
                              : SizedBox(
                                  height: 200.sp,
                                  width: ResponsiveUtils.screenWidth(context),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        CachedNetworkImageWidget(
                                          imageUrl:
                                              "https://imgs.search.brave.com/DGoVUPXpo3OwVAbBbgF3oGz3MUcz_cPZrzmfvO7iRrc/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9jZG5p/Lmljb25zY291dC5j/b20vaWxsdXN0cmF0/aW9uL3ByZW1pdW0v/dGh1bWIvc2VhcmNo/LXJlc3VsdC1ub3Qt/Zm91bmQtMjEzMDM1/NS0xODAwOTIwLnBu/Zz9mPXdlYnA",
                                          height: 150.sp,
                                          width: 150.sp,
                                          maxHeightDiskCache:
                                              ResponsiveUtils.screenWidth(
                                                  context),
                                        ),
                                        Text(
                                          "No Ongoing Events",
                                          style: fontTheme.heading(context,
                                              size: 20.sp,
                                              color: context.colorScheme
                                                  .secondarySectionColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                        const SectionText(title: "Sponsors"),
                        SizedBox(
                          height: 80.sp,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: model.sponsors.length,
                            itemBuilder: (context, index) {
                              return Sponsors(model: model.sponsors[index]);
                            },
                          ),
                        ),
                        const SectionText(title: "Upcoming Events"),
                        SizedBox(
                          height: 200.sp,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: model.remainigEvents.length,
                            itemBuilder: (context, index) {
                              return model.isBusy
                                  ? const ShimmerLoadingWidget()
                                  : Card(
                                      clipBehavior: Clip.hardEdge,
                                      shadowColor: context
                                          .colorScheme.secondaryLPurpleColor
                                          .withOpacity(0.8),
                                      elevation: 4,
                                      shape: ShapeBorder.lerp(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.sp),
                                          ),
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.sp),
                                          ),
                                          1),
                                      child: Stack(
                                        children: [
                                          EventCardUpcoming(
                                            model: model.remainigEvents[index],
                                          ),
                                          EventDateContainer(
                                            top: 8.sp,
                                            left: 8.sp,
                                            event: model.remainigEvents[index],
                                          ),
                                        ],
                                      ),
                                    );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
