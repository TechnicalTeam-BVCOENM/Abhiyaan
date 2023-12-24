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
          16.verticalSpace,
          const SectionTextShimmerEffect(),
          8.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerLoadingWidget(
                height: 80.h,
                width: 80.w,
              ),
              ShimmerLoadingWidget(
                height: 80.h,
                width: 80.w,
              ),
              ShimmerLoadingWidget(
                height: 80.h,
                width: 80.w,
              ),
              ShimmerLoadingWidget(
                height: 80.h,
                width: 80.w,
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
                height: 110.h,
              ),
              12.verticalSpace,
              ShimmerLoadingWidget(
                width: double.infinity,
                height: 110.h,
              ),
              12.verticalSpace,
              ShimmerLoadingWidget(
                width: double.infinity,
                height: 110.h,
              ),
            ],
          )
        ],
      ),
    ));
  }
}

Future showCelebrationModal(BuildContext context, CelebrationData data,
    Function toggleCelebrationShown) async {
  FontThemeClass fontThemeClass = FontThemeClass();
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog.adaptive(
        clipBehavior: Clip.hardEdge,
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: IntrinsicHeight(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    height: 220.h,
                    width: 340.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: Image.network(
                          data.image,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                color: context.colorScheme.primaryColor,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ).image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0).r,
                    child: GestureDetector(
                      onTap: () {
                        toggleCelebrationShown();
                        Navigator.pop(context);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12).r,
                        ),
                        color: context.colorScheme.secondaryWhiteColor
                            .withOpacity(0.6),
                        child: Icon(
                          Icons.close,
                          color: context.colorScheme.signInTextColor,
                          size: 30.0.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              4.verticalSpace,
              Container(
                padding: const EdgeInsets.all(20).r,
                width: 340.w,
                child: Column(
                  children: [
                    Text(
                      data.title,
                      style: fontThemeClass.header(
                        context,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    10.verticalSpace,
                    Text(
                      data.description,
                      style: fontThemeClass.body(
                        context,
                        color: context.colorScheme.secondaryBlackColor
                            .withOpacity(0.8),
                      ),
                    ),
                    14.verticalSpace,
                    InkWell(
                      splashColor: context.colorScheme.primaryColor,
                      onTap: () {
                        toggleCelebrationShown();
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 340.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color:
                              context.colorScheme.primaryColor.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(12).r,
                        ),
                        child: Center(
                          child: Text(
                            "Thank you!",
                            style: fontThemeClass.body(context,
                                fontWeight: FontWeight.w600,
                                color: context.colorScheme.signInTextColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              10.verticalSpace,
            ],
          ),
        ),
      );
    },
  );
}

Future showWelcomPopUp(BuildContext context,
    {required Function toggleisNewUser, required String username}) async {
  FontThemeClass fontThemeClass = FontThemeClass();
  await showAdaptiveDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: context.colorScheme.secondaryWhiteColor,
          title: SizedBox(
            height: 100.h,
            width: 100.w,
            child: Lottie.asset(
              AnimationAssets.welcome,
              repeat: true,
              reverse: false,
              frameRate: FrameRate(60),
              fit: BoxFit.contain,
            ),
          ),
          content: IntrinsicHeight(
            child: Column(
              children: [
                Text(
                  username,
                  style: fontThemeClass.title(
                    context,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                10.verticalSpace,
                Row(
                  children: [
                    Image.asset(
                      AssetImagePath.community,
                      width: 40.w,
                      height: 40.h,
                    ).animate(delay: 300.ms).fadeIn().shake(
                          delay: 500.ms,
                          curve: Curves.easeInOut,
                          duration: 1000.ms,
                        ),
                    16.horizontalSpace,
                    Expanded(
                      child: Text(
                        "We are thrilled to have you join our digital community!",
                        style: fontThemeClass.body(context),
                      ),
                    ),
                  ],
                ),
                10.verticalSpace,
                Row(
                  children: [
                    Image.asset(
                      AssetImagePath.poper,
                      width: 40.w,
                      height: 40.h,
                    ).animate(delay: 300.ms).fadeIn().shake(
                          delay: 500.ms,
                          curve: Curves.easeInOut,
                          duration: 1000.ms,
                        ),
                    16.horizontalSpace,
                    Expanded(
                      child: Text(
                        "Explore events, from cultural festivals to academic seminars.",
                        style: fontThemeClass.body(context),
                      ),
                    ),
                  ],
                ),
                10.verticalSpace,
              ],
            ),
          ),
          actions: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: context.colorScheme.primaryColor.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12).r,
              ),
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  toggleisNewUser();
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Let's Go!",
                  style: fontThemeClass.body(
                    context,
                    color: context.colorScheme.signInTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ).animate().fadeIn();
      });
}
