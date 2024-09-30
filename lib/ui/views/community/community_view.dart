import 'dart:async';
import 'package:abhiyaan/theme/responsive_utils.dart';
import 'package:abhiyaan/ui/common/circular_loading_indicator.dart';
import 'package:abhiyaan/ui/common/toast_message.dart';
import 'package:abhiyaan/ui/common/url_launcher.dart';
import 'package:abhiyaan/ui/views/community/detailed_blogs/detailed_blogs_view.dart';
import 'package:abhiyaan/utils/firebase_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/services/auth_service.dart';
import 'package:abhiyaan/services/firestore_service.dart';
import 'package:abhiyaan/ui/common/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';

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
        FontThemeClass font = FontThemeClass();
        return Scaffold(
          backgroundColor: context.colorScheme.scaffold,
          body: model.isBusy
              ? const CircularLoadingIndicator()
              : SafeArea(
                  minimum: const EdgeInsets.symmetric(horizontal: 18).r,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          18.verticalSpace,
                          Center(
                            child: Text(
                              "Community",
                              style: font.title(
                                context,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (model.universalClubsData.isEmpty &&
                              model.departmentClubsData.isEmpty)
                            QuoteCard(
                              quote: model.affirmation,
                              autherName: model.authorName,
                            ),
                          if (model.departmentClubsData.isNotEmpty)
                            const SectionText(
                                title: "Departmental Clubs", showArrow: true),
                          if (model.departmentClubsData.isNotEmpty)
                            SizedBox(
                              height: 110.h,
                              width: double.infinity,
                              child: CarouselSlider.builder(
                                itemCount: model.departmentClubsData.length,
                                options: CarouselOptions(
                                  height: 110.h,
                                  viewportFraction: 0.658.w,
                                  autoPlay: true,
                                  padEnds: false,
                                  autoPlayAnimationDuration: 900.milliseconds,
                                  autoPlayCurve: Curves.easeInOutCubic,
                                  autoPlayInterval: 4.seconds,
                                  enableInfiniteScroll: true,
                                  pauseAutoPlayOnTouch: true,
                                  scrollPhysics: const ClampingScrollPhysics(),
                                ),
                                itemBuilder:
                                    (BuildContext context, int index, _) {
                                  return ClubsViewWidget(
                                      data: model.departmentClubsData[index]);
                                },
                              ),
                            ),
                          18.verticalSpace,
                          const CommunityInviteCard(),
                          if (model.universalClubsData.isNotEmpty)
                            const SectionText(
                                title: "Universal Clubs", showArrow: true),
                          if (model.universalClubsData.isNotEmpty)
                            SizedBox(
                              height: 110.h,
                              width: double.infinity,
                              child: CarouselSlider.builder(
                                itemCount: model.universalClubsData.length,
                                options: CarouselOptions(
                                  height: 110.h,
                                  viewportFraction: 0.658.w,
                                  padEnds: false,
                                  autoPlay: true,
                                  autoPlayAnimationDuration: 900.milliseconds,
                                  autoPlayCurve: Curves.easeInOutCubic,
                                  autoPlayInterval: 4.seconds,
                                  enableInfiniteScroll: false,
                                  pauseAutoPlayOnTouch: true,
                                  scrollPhysics: const ClampingScrollPhysics(),
                                ),
                                itemBuilder:
                                    (BuildContext context, int index, _) {
                                  return ClubsViewWidget(
                                    data: model.universalClubsData[index],
                                  );
                                },
                              ),
                            ),
                          12.verticalSpace,
                          if (model.blogsData.isNotEmpty)
                            const SectionText(title: "Community Blogs"),
                          if (model.blogsData.isNotEmpty)
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
                                      .map(
                                        (data) => GestureDetector(
                                          onTap: () {
                                            model.navigateToDetailedBlogPage(
                                                data, context);
                                          },
                                          child:
                                              CommunityBlogs(blogsData: data),
                                        ),
                                      )
                                      .toList()),
                            ),
                          if (model.blogsData.isNotEmpty)
                            Center(
                              child: AnimatedSmoothIndicator(
                                activeIndex: model.currentBlogIndex,
                                count: model.blogsData.length,
                                effect: JumpingDotEffect(
                                  dotHeight: 8,
                                  dotWidth: 8,
                                  dotColor: context.colorScheme.accentColor
                                      .withOpacity(0.4),
                                  activeDotColor:
                                      context.colorScheme.accentColor,
                                  spacing: 4,
                                ),
                              ),
                            ),
                          38.verticalSpace,
                        ]),
                  ),
                  // ],
                ),
        );
      },
    );
  }
}
