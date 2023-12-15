import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darpan/ui/common/cached_network_image.dart';
import 'package:darpan/ui/common/shimmer.dart';
import 'package:darpan/ui/common/update_component.dart';
import 'package:darpan/file_exporter.dart';
import 'package:darpan/services/firestore_service.dart';
import 'package:darpan/ui/views/home/Societies/societies_view.dart';
import 'package:intl/intl.dart';
import 'package:darpan/ui/common/common_component_model.dart';
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
                                style: fontTheme.display(
                                    context, context.colorScheme.headingColor),
                              ),
                              IconButton(
                                splashRadius: 30.sp,
                                splashColor:
                                    context.colorScheme.secondaryBlackColor,
                                icon: ImageIcon(
                                  const AssetImage(
                                    "assets/images/home/Notification Bell.png",
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
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                                child: quickLinksList(
                                    context, model.quickLinksList))),
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
                                    color: context.colorScheme.primaryColor
                                        .withOpacity(0.45),
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
                                          style: fontTheme.title2(
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
                                          style: fontTheme.title2(
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
                                          style: fontTheme.title2(
                                              context,
                                              context.colorScheme
                                                  .primaryDarkColor),
                                        ),
                                        SizedBox(height: 10.h),
                                        Text(
                                          model.activityList[0].profName,
                                          style: fontTheme.title2(
                                              context,
                                              context.colorScheme
                                                  .primaryDarkColor),
                                        ),
                                        SizedBox(height: 5.h),
                                        Text(
                                          model.activityList[0].location,
                                          style: fontTheme.title2(
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
                        60.verticalSpace,
                        Text(
                          "Innovate.",
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 40.sp,
                            textBaseline: TextBaseline.alphabetic,
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.secondarySectionColor
                                .withOpacity(0.5),
                          ),
                        ),
                        Text(
                          "Inspire. Achieve.",
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 40.sp,
                            textBaseline: TextBaseline.alphabetic,
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.secondarySectionColor
                                .withOpacity(0.5),
                          ),
                        ),
                        3.verticalSpace,
                        Text(
                          'Made with ❤️ by Technical Team',
                          style: fontTheme.title2(context).copyWith(
                                color: context.colorScheme.secondaryBlackColor
                                    .withOpacity(0.6),
                              ),
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
