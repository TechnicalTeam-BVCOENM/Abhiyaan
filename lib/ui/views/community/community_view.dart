import 'dart:async';
import 'package:abhiyaan/theme/responsive_utils.dart';
import 'package:abhiyaan/ui/common/circular_loading_indicator.dart';
import 'package:abhiyaan/ui/common/toast_message.dart';
import 'package:abhiyaan/ui/views/community/detailed_blogs/detailed_blogs_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/services/auth_service.dart';
import 'package:abhiyaan/services/firestore_service.dart';
import 'package:abhiyaan/ui/common/cached_network_image.dart';
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
        FontThemeClass fontThemeClass = FontThemeClass();
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
                            style: fontThemeClass.title(
                              context,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (model.universalClubsData.isEmpty)
                          QuoteCard(
                            quote: model.affirmation,
                            autherName: model.authorName,
                          )
                              .animate(
                                delay: 200.ms,
                              )
                              .fadeIn(
                                curve: Curves.easeInOutCubic,
                                duration: 600.ms,
                              ),
                        const SectionText(title: "Blogs"),
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
                                scrollPhysics: const BouncingScrollPhysics(),
                              ),
                              items: model.blogsData
                                  .map(
                                    (data) => GestureDetector(
                                      onTap: () {
                                        model.navigateToDetailedBlogPage(
                                            data, context);
                                      },
                                      child: CommunityBlogs(blogsData: data),
                                    ),
                                  )
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
                              activeDotColor: context.colorScheme.accentColor,
                              spacing: 4,
                            ),
                          ),
                        ),
                        if (model.departmentClubsData.isNotEmpty)
                          const SectionText(title: "Departmental Clubs")
                              .animate(
                                delay: 250.ms,
                              )
                              .fadeIn(
                                curve: Curves.easeInOutCubic,
                                duration: 600.ms,
                              ),
                        if (model.departmentClubsData.isNotEmpty)
                          SizedBox(
                            height: 120.h,
                            width: double.infinity,
                            child: CarouselSlider.builder(
                              itemCount: model.departmentClubsData.length,
                              options: model.clubsCarosoulOptions,
                              itemBuilder: (context, index, realIndex) {
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
                        if (model.universalClubsData.isNotEmpty)
                          const SectionText(title: "Universal Clubs")
                              .animate(
                                delay: 250.ms,
                              )
                              .fadeIn(
                                curve: Curves.easeInOutCubic,
                                duration: 600.ms,
                              ),
                        if (model.universalClubsData.isNotEmpty)
                          SizedBox(
                            height: 120.h,
                            width: double.infinity,
                            child: CarouselSlider.builder(
                              itemCount: model.universalClubsData.length,
                              options: model.clubsCarosoulOptions,
                              itemBuilder: (context, index, realIndex) {
                                return Padding(
                                  padding: index == 0
                                      ? const EdgeInsets.only(right: 0).r
                                      : const EdgeInsets.only(left: 8.0).r,
                                  child: UniversalClubs(
                                      data: model.universalClubsData[index]),
                                );
                              },
                            ),
                          ).animate(delay: 200.ms).fadeIn(
                              curve: Curves.easeInOutCubic, duration: 600.ms),
                        12.verticalSpace,
                      ].animate(delay: 100.ms, interval: 80.ms).fadeIn(),
                    ),
                  ),
                  // ],
                ),
        );
      },
    );
  }
}
