import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darpan/ui/common/cached_network_image.dart';
import 'package:darpan/ui/common/shimmer.dart';
import 'package:darpan/ui/common/update_component.dart';
import 'package:darpan/file_exporter.dart';
import 'package:darpan/services/firestore_service.dart';
import 'package:intl/intl.dart';
import 'package:darpan/ui/common/common_component_model.dart';
import 'package:darpan/ui/sub_views/home/Societies/societies_view.dart';
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
                                'Hey ${model.user} 👋', // Update according to loal storage
                                style: fontTheme.appBarText(
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
                        quickLinksList(context, model.quickLinksList),
                        // Activity
                        // const SectionText(
                        //   title: "Activity",
                        // ),
                        // Container(
                        //   height: 135.sp,
                        //   width: MediaQuery.of(context).size.width,
                        //   decoration: BoxDecoration(
                        //     color: context.colorScheme.secondaryWhiteColor,
                        //     borderRadius: BorderRadius.circular(12),
                        //   ),
                        // ),
                        const SectionText(
                          title: "Department Updates",
                        ),
                        for (var i = 0;
                            i < model.departmentUpdates.length;
                            i++) ...[
                          updatesCard(
                              model._departmentUpdates, i, context, model),
                        ],
                        SizedBox(height: 20.h),
                        Center(
                          child: Text(
                            'Made with ❤️ by Technical Team',
                            style: fontTheme.smallSubHeading(context),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
