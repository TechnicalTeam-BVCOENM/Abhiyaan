import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darpan/common/shimmer.dart';
import 'package:darpan/file_exporter.dart';
import 'package:darpan/services/auth_service.dart';
import 'package:darpan/services/firestore_service.dart';
import 'package:darpan/theme/responsive_utils.dart';
import 'package:darpan/ui/views/event/event_view.dart';
import 'package:intl/intl.dart';

import '../../../common/common_component_model.dart';
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
          body: model.isBusy
              ? const ShimmerLoadingWidget()
              : SafeArea(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title Bar
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Hey ${model.user} 👋',
                                style: fontTheme.appBarText(context),
                              ),
                              IconButton(
                                splashRadius: 30.wWise,
                                splashColor:
                                    context.colorScheme.backgroundColor,
                                icon: ImageIcon(
                                  const AssetImage(
                                    "assets/images/Notification Bell.png",
                                  ),
                                  size: 24.hWise,
                                ),
                                onPressed: () {
                                  model.signOut();
                                },
                              )
                            ],
                          ),
                        ),

                        // Carousel
                        const SectionText(title: 'Highlights'),

                        SizedBox(
                          width: 460.wWise,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CarouselSlider.builder(
                                  itemCount: model.highlights.length,
                                  itemBuilder: (context, index, realIndex) {
                                    return CachedNetworkImage(
                                        imageUrl: model.highlights[index]
                                            ['imageUrl']);
                                  },
                                  options: CarouselOptions(
                                    height: 220.hWise,
                                    onPageChanged: (index, reason) =>
                                        model.updateActiveIndex(index),
                                    autoPlay: true,
                                    autoPlayInterval:
                                        const Duration(seconds: 3),
                                    viewportFraction: 1,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.hWise,
                                ),
                                CarouselUtils.buildIndicator(
                                  context,
                                  model.activeIndex,
                                  model.highlights.length,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Quick Links
                        const SectionText(title: "Quick Links"),
                        quickLinksList(context, model.quickLinksList),
                        // Activity
                        const SectionText(
                          title: "Activity",
                        ),
                        Container(
                          height: 135.hWise,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: context.colorScheme.secondaryWhiteColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        // Department Updates
                        const SectionText(
                          title: "Department Updates",
                        ),
                        for (var i = 0; i < model.departmentUpdates.length; i++)
                          updatesCard(model, i, context),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
