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
                style: FontThemeClass().caption(
                  context,
                  color: context.colorScheme.primaryDarkColor.withOpacity(0.8),
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

class HomePageShimmerEffect extends StatelessWidget {
  const HomePageShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 18).r,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0).r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerLoadingWidget(
                  height: 45.h,
                  width: 240.w,
                ),
                ShimmerLoadingWidget(
                  height: 45.h,
                  width: 45.w,
                ),
              ],
            ),
          ),
          16.verticalSpace,
          const SectionTextShimmerEffect(),
          4.verticalSpace,
          Center(
            child: ShimmerLoadingWidget(
              width: double.infinity,
              height: 230.h,
            ),
          ),
          8.verticalSpace,
          const SectionTextShimmerEffect(),
          4.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerLoadingWidget(
                height: 70.h,
                width: 70.w,
              ),
              ShimmerLoadingWidget(
                height: 70.h,
                width: 70.w,
              ),
              ShimmerLoadingWidget(
                height: 70.h,
                width: 70.w,
              ),
              ShimmerLoadingWidget(
                height: 70.h,
                width: 70.w,
              ),
            ],
          ),
          16.verticalSpace,
          const SectionTextShimmerEffect(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ShimmerLoadingWidget(
                width: double.infinity,
                height: 90.h,
              ),
              12.verticalSpace,
              ShimmerLoadingWidget(
                width: double.infinity,
                height: 90.h,
              ),
              12.verticalSpace,
              ShimmerLoadingWidget(
                width: double.infinity,
                height: 90.h,
              ),
            ],
          )
        ],
      ),
    ));
  }
}

class SectionTextShimmerEffect extends StatelessWidget {
  const SectionTextShimmerEffect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 18, bottom: 8).r,
      child: Row(
        children: [
          ShimmerLoadingWidget(
            width: 180.w,
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
