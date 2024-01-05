part of 'home_view.dart';

final AnalyticsService _analyticsService = locator<AnalyticsService>();

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
                        _analyticsService.logEvent(
                            eventName: "Celebration_PopUp",
                            value: "Closed Celebration Modal");
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
                  _analyticsService.logEvent(
                      eventName: "Welcome_Pop_Up",
                      value: "Closed Welcome Pop Up");
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

class ShowAppExitPopUp {
  static Future showAppExitPopUp(BuildContext context) {
    FontThemeClass fontThemeClass = FontThemeClass();

    return showModalBottomSheet(
        useSafeArea: true,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height / 3,
          minWidth: double.infinity,
        ),
        backgroundColor: context.colorScheme.backgroundColor,
        clipBehavior: Clip.hardEdge,
        elevation: 0,
        showDragHandle: true,
        context: context,
        builder: (context) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10).r,
            decoration: BoxDecoration(
              color: context.colorScheme.backgroundColor,
              borderRadius: BorderRadius.circular(32).r,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.exit_to_app_rounded,
                  size: 50.sp,
                  color: context.colorScheme.primaryColor,
                ),
                12.verticalSpace,
                Text(
                  "Are you sure you want to exit ?",
                  style: fontThemeClass.title2(context,
                      fontWeight: FontWeight.w700,
                      color: context.colorScheme.secondaryBlackColor),
                ).animate(delay: 300.ms).fadeIn(duration: 800.ms),
                Text(
                  "Have a great day and see you next time! 👋",
                  textAlign: TextAlign.center,
                  style: fontThemeClass.caption(context,
                      color: context.colorScheme.secondaryBlackColor
                          .withOpacity(0.8)),
                ).animate(delay: 300.ms).fadeIn(duration: 800.ms),
                4.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        _analyticsService.logEvent(
                            eventName: "App_Exit_Popup",
                            value: "Closed App Exit Popup");
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 120.w,
                        height: 45.h,
                        decoration: BoxDecoration(
                          color:
                              context.colorScheme.primaryColor.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(12).r,
                        ),
                        child: Center(
                          child: Text(
                            "No",
                            style: FontThemeClass().body(context,
                                fontWeight: FontWeight.w600,
                                color: context.colorScheme.signInTextColor),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _analyticsService.logEvent(
                            eventName: "App_Exit_Popup",
                            value: "Exited App");
                        SystemNavigator.pop();
                      },
                      child: Container(
                        width: 120.w,
                        height: 45.h,
                        decoration: BoxDecoration(
                          color: context.colorScheme.secondaryWhiteColor,
                          border: Border.all(
                            color: context.colorScheme.primaryColor
                                .withOpacity(0.8),
                            width: 2.w,
                          ),
                          borderRadius: BorderRadius.circular(12).r,
                        ),
                        child: Center(
                          child: Text(
                            "Yes",
                            style: FontThemeClass()
                                .body(context, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ]
                      .animate(delay: 300.ms, interval: 200.ms)
                      .fadeIn(curve: Curves.easeInCubic),
                ),
              ],
            ),
          );
        });
  }
}
