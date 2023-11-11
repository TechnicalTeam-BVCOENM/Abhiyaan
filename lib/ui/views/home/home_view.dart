import 'package:carousel_slider/carousel_slider.dart';
import 'package:darpan/file_exporter.dart';
import 'package:darpan/theme/responsive_utils.dart';
import 'package:darpan/utils/extension.dart';
part 'home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) {
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Hey ${model.user} 👋',
                              style: model.fontTheme.appBarText(context)),
                          IconButton(
                            splashRadius: 30,
                            splashColor: context.colorScheme.backgroundColor,
                            icon: Icon(
                              Icons.notifications_none_rounded,
                              size: 24.hWise,
                            ),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                    const SectionText(
                      title: "Highlights",
                    ),
                    SizedBox(
                      height: 10.hWise,
                    ),
                    SizedBox(
                      width: 450.wWise,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CarouselSlider.builder(
                              itemCount: model.urlImages.length,
                              itemBuilder: (context, index, realIndex) {
                                final urlImage = model.urlImages[index];
                                // final carouselText = carouselTexts[index];
                                return CarouselUtils.buildImage(
                                    context, urlImage, index);
                              },
                              options: CarouselOptions(
                                  height: 220.hWise,
                                  onPageChanged: (index, reason) =>
                                      model.updateActiveIndex(index),
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 3),
                                  viewportFraction: 1),
                            ),
                            SizedBox(
                              height: 20.hWise,
                            ),
                            CarouselUtils.buildIndicator(context,
                                model.activeIndex, model.urlImages.length),
                          ],
                        ),
                      ),
                    ),
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
                    const SectionText(
                      title: "Department Updates",
                    ),
                    for (var i = 0; i < model.currentIndex; i++)
                      Container(
                        height: model.expandedHeight,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        width: ResponsiveUtils.screenWidth(context).wWise,
                        decoration: BoxDecoration(
                          color: context.colorScheme.secondaryWhiteColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            // Card Header
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    model.departmentUpdatesList[i].name,
                                    style: FontThemeClass().subHeading(context,
                                        context.colorScheme.primaryColor),
                                  ),
                                  Text(
                                    "Posted ${model.departmentUpdatesList[i].date}",
                                    style: FontThemeClass().smallSubHeading(
                                      context,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Card Body
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8),
                                child: InkWell(
                                  onTap: () => model.toggleExpand(),
                                  child: Text(
                                    model.departmentUpdatesList[1].description,
                                    maxLines: model.maxLines,
                                  ),
                                )),
                          ],
                        ),
                      ),
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
