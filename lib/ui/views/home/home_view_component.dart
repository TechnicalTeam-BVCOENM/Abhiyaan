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
        margin: const EdgeInsets.symmetric(horizontal: 7),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child: Stack(
            children: [
              CachedNetworkImageWidget(
                imageUrl: urlImage,
                height: 1500.h,
                width: double.infinity,
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
Widget quickLinksList(BuildContext context, List model,
    [double? borderRadius]) {
  return SizedBox(
    height: 110.h,
    width: 386.w,
    child: ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: model.length,
      // itemExtent: 98.w,
      itemBuilder: (context, idx) {
        return Padding(
          padding: EdgeInsets.only(right: 22.w, left: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  debugPrint("Tapped $idx");
                  handleQuickLinksNavigation(model, idx);
                },
                child: Container(
                  height: 80.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    color: context.colorScheme.secondaryLPurpleColor,
                    borderRadius: BorderRadius.circular(borderRadius ?? 18).r,
                  ),
                  child: Image.asset(
                    model[idx].imageUrl,
                    width: 40.w,
                    height: 40.h,
                  ),
                ),
              ),
              // const SizedBox(height: 18),
              Text(
                model[idx].title.toString().toUpperCase(),
                style: FontThemeClass()
                    .title2(
                      context,
                      context.colorScheme.primaryDarkColor,
                    )
                    .copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                textAlign: TextAlign.center,
                softWrap: false,
              ),
            ],
          ),
        );
      },
    ),
  );
}
