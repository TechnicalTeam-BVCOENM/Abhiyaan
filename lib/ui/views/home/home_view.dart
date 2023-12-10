import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darpan/ui/common/cached_network_image.dart';
import 'package:darpan/ui/common/shimmer.dart';
import 'package:darpan/ui/common/update_component.dart';
import 'package:darpan/file_exporter.dart';
import 'package:darpan/services/firestore_service.dart';
import 'package:intl/intl.dart';
import 'package:darpan/ui/common/common_component_model.dart';
import 'package:darpan/ui/views/event/event_view.dart';
part 'home_view_model.dart';
part 'home_view_component.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    FontThemeClass fontTheme = FontThemeClass();
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (viewModel) => viewModel.loadData(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: context.colorScheme.backgroundColor,
          body: model.isBusy
              ? const ShimmerLoadingWidget()
              : SafeArea(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 18.0).r,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Hey ${model.firstname[0]} 👋', // Update according to loal storage
                                style: fontTheme.appBarText(
                                    context, context.colorScheme.headingColor),
                              ),
                              IconButton(
                                splashRadius: 30.sp,
                                splashColor:
                                    context.colorScheme.secondaryBlackColor,
                                icon: ImageIcon(
                                  const AssetImage(
                                    "assets/images/Notification Bell.png",
                                  ),
                                  size: 24.sp,
                                ),
                                onPressed: () {},
                              )
                            ],
                          ),
                        ),
                        const SectionText(title: 'Highlights'),
                        SizedBox(
                          width: 386.w,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CarouselSlider.builder(
                                  itemCount: model.highlights.length,
                                  itemBuilder: (context, index, realIndex) {
                                    return CarouselUtils.buildImage(
                                        context,
                                        model.highlights[index]['imageUrl'],
                                        model._activeIndex);
                                  },
                                  options: CarouselOptions(
                                    height: 230.h,
                                    onPageChanged: (index, reason) =>
                                        model.updateActiveIndex(index),
                                    autoPlay: true,
                                    autoPlayInterval:
                                        const Duration(seconds: 3),
                                    viewportFraction: 1,
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                CarouselUtils.buildIndicator(
                                  context,
                                  model.activeIndex,
                                  model.highlights.length,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SectionText(title: "Quick Links"),
                        quickLinksList(context, model.quickLinksList),
                        // Activity
                        const SectionText(
                          title: "Activity",
                        ),
                        Container(
                          height: 135.h,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: context.colorScheme.secondaryWhiteColor,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: context
                                        .colorScheme.secondaryLPurpleColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12.r),
                                      bottomLeft: Radius.circular(12.r),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.r, vertical: 8.r),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          model.activityList[0].startTime
                                              .format(context),
                                          style: fontTheme.subHeading(
                                              context,
                                              context.colorScheme
                                                  .primaryDarkColor),
                                        ),
                                        SizedBox(
                                          width: 10.r,
                                          child: Divider(
                                            color: context
                                                .colorScheme.primaryDarkColor,
                                            thickness: 2.r,
                                            height: 10.r,
                                          ),
                                        ),
                                        Text(
                                          model.activityList[0].endTime
                                              .format(context),
                                          style: fontTheme.subHeading(
                                              context,
                                              context.colorScheme
                                                  .primaryDarkColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        context.colorScheme.secondaryWhiteColor,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(12.r),
                                      bottomRight: Radius.circular(12.r),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.r, vertical: 8.r),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          model.activityList[0].subName,
                                          style: fontTheme.subHeading(
                                              context,
                                              context.colorScheme
                                                  .primaryDarkColor),
                                        ),
                                        SizedBox(height: 10.h),
                                        Text(
                                          model.activityList[0].profName,
                                          style: fontTheme.smallSubHeading(
                                              context,
                                              context.colorScheme
                                                  .primaryDarkColor),
                                        ),
                                        SizedBox(height: 5.h),
                                        Text(
                                          model.activityList[0].location,
                                          style: fontTheme.smallSubHeading(
                                              context,
                                              context.colorScheme
                                                  .primaryDarkColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SectionText(
                          title: "Department Updates",
                        ),
                        for (var i = 0;
                            i < model.departmentUpdates.length;
                            i++) ...[
                          updatesCard(
                              model._departmentUpdates, i, context, model),
                        ],
                        40.verticalSpace,
                        Text(
                          "Innovate.",
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            shadows: [
                              Shadow(
                                blurRadius: 8,
                                color: context.colorScheme.primaryColor
                                    .withOpacity(0.2),
                                offset: const Offset(0, 3),
                              ),
                            ],
                            letterSpacing: 0.01,
                            fontSize: 40.sp,
                            wordSpacing: 0.2,
                            textBaseline: TextBaseline.alphabetic,
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.primaryDarkColor
                                .withOpacity(0.5),
                          ),
                        ),
                        Text(
                          "Inspire. Achieve.",
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            shadows: [
                              Shadow(
                                blurRadius: 8,
                                color: context.colorScheme.primaryColor
                                    .withOpacity(0.2),
                                offset: const Offset(0, 3),
                              ),
                            ],
                            letterSpacing: 0.01,
                            fontSize: 40.sp,
                            wordSpacing: 0.2,
                            textBaseline: TextBaseline.alphabetic,
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.primaryDarkColor
                                .withOpacity(0.5),
                          ),
                        ),
                        12.verticalSpace,
                        Text(
                          'Made with ❤️ by Technical Team',
                          style: fontTheme.smallSubHeading(context),
                        ),
                        12.verticalSpace,
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
