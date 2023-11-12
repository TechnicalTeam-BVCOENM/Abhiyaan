import 'package:carousel_slider/carousel_slider.dart';
import 'package:darpan/file_exporter.dart';
import 'package:darpan/services/auth_service.dart';
import 'package:darpan/theme/responsive_utils.dart';
part 'home_view_model.dart';
part 'home_view_component.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    FontThemeClass fontTheme = FontThemeClass();
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
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
                          splashRadius: 30,
                          splashColor: context.colorScheme.backgroundColor,
                          icon: Icon(
                            Icons.notifications_none_rounded,
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
                            itemCount: model.urlImages.length,
                            itemBuilder: (context, index, realIndex) {
                              return CarouselUtils.buildImage(
                                context,
                                model.urlImages[index],
                                index,
                              );
                            },
                            options: CarouselOptions(
                              height: 220.hWise,
                              onPageChanged: (index, reason) =>
                                  model.updateActiveIndex(index),
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              viewportFraction: 1,
                            ),
                          ),
                          SizedBox(
                            height: 20.hWise,
                          ),
                          CarouselUtils.buildIndicator(
                            context,
                            model.activeIndex,
                            model.urlImages.length,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Quick Links
                  const SectionText(title: "Quick Links"),
                  horizontalStoryRow(context, model.quickLinksList, 50),
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
                  for (var i = 0; i < model.departmentUpdatesList.length; i++)
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
