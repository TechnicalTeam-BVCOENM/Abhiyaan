part of 'home_view.dart';

// Carousel
class CarouselUtils {
  static Widget buildIndicator(
          BuildContext context, int activeIndex, int length) =>
      AnimatedSmoothIndicator(
        effect: JumpingDotEffect(
          dotHeight: 8.sp,
          dotWidth: 8.sp,
          dotColor: context.colorScheme.secondarySectionColor,
          activeDotColor: context.colorScheme.primaryColor,
        ),
        activeIndex: activeIndex,
        count: length,
      );

  static Widget buildImage(BuildContext context, String urlImage, int index) =>
      Container(
        width: MediaQuery.of(context).size.width * 1,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              CachedNetworkImageWidget(
                imageUrl: urlImage,
                height: 1500,
                width: 350,
                maxHeightDiskCache: 1000,
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.4),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

// Quick Links
Row quickLinksList(BuildContext context, List model, [double? borderRadius]) {
  FontThemeClass fontTheme = FontThemeClass();
  return Row(
    children: [
      Expanded(
        child: GridView.builder(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
          ),
          itemCount: model.length,
          itemBuilder: (context, idx) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    debugPrint("Tapped$idx");
                    handleQuickLinksNavigation(model, idx);
                  },
                  child: Container(
                    height: 60.sp,
                    width: 60.sp,
                    decoration: BoxDecoration(
                      color: context.colorScheme.secondaryLPurpleColor,
                      borderRadius: BorderRadius.circular(borderRadius ?? 18),
                    ),
                    child: Image.asset(
                      model[idx].imageUrl,
                      width: 36.sp,
                      height: 36.sp,
                    ),
                  ),
                ),
                Text(
                  model[idx].title,
                  style: fontTheme
                      .subHeading2(
                        context,
                        context.colorScheme.secondarySectionColor,
                      )
                      .copyWith(fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                  softWrap: false,
                ),
              ],
            );
          },
        ),
      ),
    ],
  );
}
