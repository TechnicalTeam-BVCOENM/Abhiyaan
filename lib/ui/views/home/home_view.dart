import 'dart:async';
import 'package:abhiyaan/services/notification_service.dart';
import 'package:abhiyaan/ui/common/carousel_utils.dart';
import 'package:abhiyaan/ui/common/toast_message.dart';
import 'package:abhiyaan/ui/views/home/celebration/celebration_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:abhiyaan/ui/common/shimmer.dart';
import 'package:abhiyaan/ui/common/update_component.dart';
import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/services/firestore_service.dart';
import 'package:abhiyaan/ui/views/home/Societies/societies_view.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:abhiyaan/ui/common/url_launcher.dart';
import 'package:lottie/lottie.dart';
import 'package:upgrader/upgrader.dart';
part 'home_view_model.dart';
part 'home_view_component.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    FontThemeClass fontTheme = FontThemeClass();
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      disposeViewModel: false,
      onViewModelReady: (viewModel) {
        viewModel.init(context).then(
              (value) =>viewModel.afterInit(context)
            );
      },
      builder: (context, model, child) {
        return UpgradeAlert(
          upgrader: Upgrader(
            durationUntilAlertAgain: const Duration(days: 2),
            showIgnore: false,
            showReleaseNotes: false,
          ),
          child: Scaffold(
            backgroundColor: context.colorScheme.backgroundColor,
            body: model.isBusy
                ? const HomePageShimmerEffect()
                : SafeArea(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 18.0).r,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(vertical: 8.0).r,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 280.w,
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    'Hey ${model.splitusername()} 👋', // Update according to loal storage
                                    style: fontTheme.title(context,
                                        color: context.colorScheme.headingColor,
                                        fontWeight: FontWeight.w600),
                                  ).animate().fadeIn(),
                                ),
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
                                  model._highlights.isEmpty
                                      ? SizedBox(
                                          height: 230.h,
                                          child: Card(
                                            margin:
                                                const EdgeInsets.only(bottom: 8)
                                                    .r,
                                            elevation: 0,
                                            clipBehavior: Clip.hardEdge,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16).r,
                                              side: BorderSide(
                                                color: context.colorScheme
                                                    .secondaryLPurpleColor,
                                                width: 1.0,
                                              ),
                                            ),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.info_rounded,
                                                    color: context.colorScheme
                                                        .secondaryBlackColor,
                                                  ),
                                                  10.horizontalSpace,
                                                  Text("No updates yet",
                                                      style: fontTheme
                                                          .body(context)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : CarouselSlider.builder(
                                          itemCount: model.highlights.length,
                                          itemBuilder:
                                              (context, index, realIndex) {
                                            return CarouselUtils.buildImage(
                                              context,
                                              model.highlights[index]
                                                  ['imageUrl'],
                                              model._activeIndex,
                                            );
                                          },
                                          options: CarouselOptions(
                                            height: 230.h,
                                            onPageChanged: (index, reason) =>
                                                model.updateActiveIndex(index),
                                            autoPlay: true,
                                            autoPlayInterval: 4.seconds,
                                            viewportFraction: 1,
                                            enableInfiniteScroll: true,
                                            autoPlayAnimationDuration:
                                                1.seconds,
                                            autoPlayCurve: Curves.easeInOut,
                                            enlargeCenterPage: true,
                                          ),
                                        ),
                                  20.verticalSpace,
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
                          10.verticalSpace,
                          const SectionText(
                            title: "College Updates",
                          ),
                          model.collegeUpdates.isEmpty
                              ? SizedBox(
                                  height: 120.h,
                                  child: Card(
                                      margin:
                                          const EdgeInsets.only(bottom: 8).r,
                                      elevation: 0,
                                      clipBehavior: Clip.hardEdge,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16).r,
                                        side: BorderSide(
                                          color: context.colorScheme
                                              .secondaryLPurpleColor,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.info_rounded,
                                            color: context.colorScheme
                                                .secondaryBlackColor,
                                          ),
                                          10.horizontalSpace,
                                          Text(
                                            "No updates yet, Stay Tuned",
                                            style: fontTheme.body(context),
                                          ),
                                        ],
                                      )).animate().fadeIn(),
                                )
                              : ListView.builder(
                                  itemBuilder: (context, index) {
                                    return updatesCard(model.collegeUpdates,
                                        index, context, model);
                                  },
                                  itemCount: model.collegeUpdates.length,
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                ).animate().fadeIn(),
                          60.verticalSpace,
                          Text("Innovate",
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: fontTheme.display(context,
                                  fontWeight: FontWeight.bold,
                                  color: context
                                      .colorScheme.secondarySectionColor
                                      .withOpacity(0.8))),
                          Text("Achieve Inspire",
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: fontTheme.display(context,
                                  fontWeight: FontWeight.bold,
                                  color: context
                                      .colorScheme.secondarySectionColor
                                      .withOpacity(0.8))),
                          3.verticalSpace,
                          Text('Made with ❤️ by Technical Team',
                              style: fontTheme.caption(context,
                                  color: context.colorScheme.secondaryBlackColor
                                      .withOpacity(0.8),
                                  fontWeight: FontWeight.w500)),
                          12.verticalSpace,
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
