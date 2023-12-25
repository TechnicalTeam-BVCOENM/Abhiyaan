import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:math';
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
        onViewModelReady: (viewModel) => viewModel.init(context),
        builder: (context, model, child) {
          FontThemeClass fontThemeClass = FontThemeClass();
          return model.isBusy
              ? const CommunityPageShimmerEffect()
              : Scaffold(
                  appBar: AppBar(
                    backgroundColor: context.colorScheme.backgroundColor,
                    elevation: 0,
                    title: Text(
                      "Community",
                      style: fontThemeClass.title(context,
                          color: context.colorScheme.secondaryBlackColor),
                    ),
                    centerTitle: true,
                  ),
                  backgroundColor: context.colorScheme.backgroundColor,
                  body: RefreshIndicator(
                    strokeWidth: 3.0,
                    onRefresh: () async {
                      await Future.delayed(const Duration(seconds: 1));
                      model.setBusy(true);
                      await model.fetchAffirmation();
                      model.setBusy(false);
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SafeArea(
                        minimum: const EdgeInsets.symmetric(horizontal: 18).r,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                      .map((data) =>
                                          CommunityBlogs(blogsData: data))
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

                            const SectionText(title: "Departmental Clubs"),
                            // Add Departmental Clubs here
                            const SectionText(title: "Quote of the day"),
                            // Add Qoute of the day here
                            QuoteCard(
                              quote: model.affirmation,
                              autherName: model.authorName,
                            ),

                            Container(
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.center,
                                child: Text(
                                  "Scroll Up To Refresh",
                                  style: FontThemeClass().caption(context,
                                      color: context
                                          .colorScheme.secondarySectionColor,
                                      fontWeight: FontWeight.w600),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
        });
  }
}
