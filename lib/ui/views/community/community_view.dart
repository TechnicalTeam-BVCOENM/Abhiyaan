import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:abhiyaan/ui/common/toast_message.dart';
import 'package:abhiyaan/ui/views/community/detailed_blogs/detailed_blogs_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/services/auth_service.dart';
import 'package:abhiyaan/services/firestore_service.dart';
import 'package:abhiyaan/ui/common/cached_network_image.dart';
import 'package:abhiyaan/ui/common/shimmer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_animate/flutter_animate.dart';
part "community_view_components.dart";
part "community_view_model.dart";

class CommunityView extends StatelessWidget {
  const CommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CommunityViewModel>.reactive(
        viewModelBuilder: () => CommunityViewModel(),
        disposeViewModel: false,
        onViewModelReady: (viewModel) => viewModel.init(context),
        builder: (context, model, child) {
          final analyticsService = locator<AnalyticsService>();
          FontThemeClass fontThemeClass = FontThemeClass();
          return model.isBusy
              ? const CommunityPageShimmerEffect()
              : Scaffold(
                  backgroundColor: context.colorScheme.backgroundColor,
                  body: RefreshIndicator(
                    strokeWidth: 3.0,
                    onRefresh: () async {
                      analyticsService.logEvent(
                          eventName: "Qoute_Refreshed",
                          value: "Refresh Qoute drag down");
                      await Future.delayed(const Duration(seconds: 1));
                      await model.fetchAffirmation();
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SafeArea(
                        minimum: const EdgeInsets.symmetric(horizontal: 18).r,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                "Community",
                                style: fontThemeClass.title(context,
                                    color: context
                                        .colorScheme.secondaryBlackColor),
                              ),
                            ),
                            const SectionText(title: "Blogs"),
                            // Add Blogs here
                            SizedBox(
                              height: 270.h,
                              width: double.infinity,
                              child: CarouselSlider(
                                  options: CarouselOptions(
                                    onPageChanged: (index, reason) {
                                      model.updateBlogIndex(index);
                                    },
                                    height: 270.h,
                                    viewportFraction: 1,
                                    autoPlay: true,
                                    initialPage: 0,
                                    autoPlayAnimationDuration: 900.milliseconds,
                                    autoPlayCurve: Curves.easeInOutCubic,
                                    autoPlayInterval: 4.seconds,
                                    pauseAutoPlayOnTouch: true,
                                    scrollPhysics:
                                        const BouncingScrollPhysics(),
                                  ),
                                  items: model.blogsData
                                      .map((data) => GestureDetector(
                                          onTap: () {
                                            model.navigateToDetailedBlogPage(
                                                data, context);
                                          },
                                          child:
                                              CommunityBlogs(blogsData: data)))
                                      .toList()),
                            ),
                            12.verticalSpace,
                            Center(
                              child: AnimatedSmoothIndicator(
                                activeIndex: model.currentBlogIndex,
                                count: model.blogsData.length,
                                effect: JumpingDotEffect(
                                  dotHeight: 8,
                                  dotWidth: 8,
                                  dotColor:
                                      context.colorScheme.secondarySectionColor,
                                  activeDotColor:
                                      context.colorScheme.primaryColor,
                                  spacing: 4,
                                ),
                              ),
                            ),
                            model.departmentClubsData.isEmpty
                                ? Container()
                                : const SectionText(title: "Departmental Clubs")
                                    .animate(delay: 250.ms)
                                    .fadeIn(
                                        curve: Curves.easeInOutCubic,
                                        duration: 600.ms),
                            SizedBox(
                              height: 120.h,
                              width: double.infinity,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: model.departmentClubsData.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: index == 0
                                        ? const EdgeInsets.only(right: 0).r
                                        : const EdgeInsets.only(left: 8.0).r,
                                    child: DepartmentClubs(
                                        data: model.departmentClubsData[index]),
                                  );
                                },
                              ),
                            ).animate(delay: 200.ms).fadeIn(
                                curve: Curves.easeInOutCubic, duration: 600.ms),

                            const SectionText(title: "Quote of the day"),
                            QuoteCard(
                              quote: model.affirmation,
                              autherName: model.authorName,
                            ),

                            Container(
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.center,
                                child: Text(
                                  "Scroll Down To Refresh",
                                  style: FontThemeClass().caption(context,
                                      color: context
                                          .colorScheme.secondarySectionColor,
                                      fontWeight: FontWeight.w600),
                                )),
                          ].animate(delay: 100.ms, interval: 80.ms).fadeIn(),
                        ),
                      ),
                    ),
                  ),
                );
        });
  }
}
