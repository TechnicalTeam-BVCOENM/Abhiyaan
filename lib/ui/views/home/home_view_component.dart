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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  handleQuickLinksNavigation(model, idx);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(200).r,
                  child: Container(
                    color: context.colorScheme.card,
                    height: 80.h,
                    width: 80.w,
                    child: Center(
                      child: Image.asset(
                        model[idx].imageUrl,
                        width: 80.w,
                        height: 80.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                model[idx].title.toString().toUpperCase(),
                style: FontThemeClass().small(
                  context,
                  color: context.colorScheme.primaryText.withOpacity(0.8),
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

Future showCelebrationModal(
    context, CelebrationData data, Function toggleCelebrationShown) async {
  FontThemeClass fontThemeClass = FontThemeClass();
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog.adaptive(
        clipBehavior: Clip.hardEdge,
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          child: IntrinsicHeight(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: Image.network(
                                data.image,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const CircularLoadingIndicator();
                                },
                              ).image,
                              fit: BoxFit.cover,
                            ),
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
                              borderRadius: BorderRadius.circular(100).r,
                            ),
                            color: context.colorScheme.card,
                            child: Icon(
                              Icons.close,
                              color: context.colorScheme.primaryText,
                              size: 30.0.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20).r,
                    width: 340.w,
                    child: Column(
                      children: [
                        Text(
                          data.title,
                          style: fontThemeClass.title(
                            context,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        10.verticalSpace,
                        Text(
                          data.description.length < 500
                              ? data.description
                              : "${data.description.substring(0, 500)}...",
                          textAlign: TextAlign.justify,
                          style: fontThemeClass.caption(
                            context,
                            color: context.colorScheme.secondaryText,
                          ),
                        ),
                        14.verticalSpace,
                        GestureDetector(
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
                              color: context.colorScheme.accentColor,
                              borderRadius: BorderRadius.circular(12).r,
                            ),
                            child: Center(
                              child: Text(
                                "Thank you!",
                                style: fontThemeClass.body(
                                  context,
                                  fontWeight: FontWeight.w600,
                                  color: context.colorScheme.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        14.verticalSpace,
                      ],
                    ),
                  ),
                  10.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

Future showWelcomPopUp(context,
    {required Function toggleisNewUser,
    required String username,
    required bool isCelebrationShown,
    required List<CelebrationData> celebrationData,
    required Function toggleCelebrationShown}) async {
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
            frameRate: const FrameRate(60),
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
              color: context.colorScheme.accentColor,
              borderRadius: BorderRadius.circular(12).r,
            ),
            width: double.infinity,
            child: TextButton(
              onPressed: () async {
                _analyticsService.logEvent(
                  eventName: "Welcome_Pop_Up",
                  value: "Closed Welcome Pop Up",
                );
                toggleisNewUser();
                Navigator.of(context).pop();
                if (isCelebrationShown == false && celebrationData.isNotEmpty) {
                  await showCelebrationModal(
                    context,
                    celebrationData[0],
                    toggleCelebrationShown,
                  );
                }
              },
              child: Text(
                "Let's Go!",
                style: fontThemeClass.body(
                  context,
                  color: context.colorScheme.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ).animate().fadeIn();
    },
  );
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
      backgroundColor: context.colorScheme.scaffold,
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      showDragHandle: true,
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10).r,
          decoration: BoxDecoration(
            color: context.colorScheme.scaffold,
            borderRadius: BorderRadius.circular(32).r,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.exit_to_app_rounded,
                size: 50.sp,
                color: context.colorScheme.accentColor,
              ),
              12.verticalSpace,
              Text(
                "Are you sure you want to exit ?",
                style: fontThemeClass.title2(
                  context,
                  fontWeight: FontWeight.w700,
                  color: context.colorScheme.primaryText,
                ),
              ).animate(delay: 300.ms).fadeIn(duration: 800.ms),
              Text(
                "Have a great day and see you next time! 👋",
                textAlign: TextAlign.center,
                style: fontThemeClass.caption(
                  context,
                  color: context.colorScheme.secondaryText,
                ),
              ).animate(delay: 300.ms).fadeIn(duration: 800.ms),
              4.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      _analyticsService.logEvent(
                        eventName: "App_Exit_Popup",
                        value: "Closed App Exit Popup",
                      );
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 120.w,
                      height: 45.h,
                      decoration: BoxDecoration(
                        color: context.colorScheme.accentColor,
                        borderRadius: BorderRadius.circular(12).r,
                      ),
                      child: Center(
                        child: Text(
                          "No",
                          style: FontThemeClass().body(
                            context,
                            fontWeight: FontWeight.w600,
                            color: context.colorScheme.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _analyticsService.logEvent(
                        eventName: "App_Exit_Popup",
                        value: "Exited App",
                      );
                      SystemNavigator.pop();
                    },
                    child: Container(
                      width: 120.w,
                      height: 45.h,
                      decoration: BoxDecoration(
                        color: context.colorScheme.white,
                        border: Border.all(
                          color: context.colorScheme.accentColor,
                          width: 2.w,
                        ),
                        borderRadius: BorderRadius.circular(12).r,
                      ),
                      child: Center(
                        child: Text(
                          "Yes",
                          style: FontThemeClass().body(
                            context,
                            color: context.colorScheme.black,
                            fontWeight: FontWeight.w600,
                          ),
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
      },
    );
  }
}

class HighlightCarouselWidget extends ViewModelWidget<HomeViewModel> {
  const HighlightCarouselWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    final FontThemeClass fontTheme = FontThemeClass();

    return SizedBox(
      width: 386.w,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            viewModel._highlights.isEmpty
                ? SizedBox(
                    height: 230.h,
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 8).r,
                      elevation: 0,
                      clipBehavior: Clip.hardEdge,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16).r,
                        side: BorderSide(
                          color: context.colorScheme.secondaryText,
                          width: 1.w,
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.info_rounded,
                              color: context.colorScheme.primaryText,
                            ),
                            10.horizontalSpace,
                            Text(
                              "No updates yet",
                              style: fontTheme.body(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : CarouselSlider.builder(
                    itemCount: viewModel.highlights.length,
                    itemBuilder: (context, index, realIndex) {
                      return CarouselUtils.buildImage(
                        context,
                        viewModel.highlights[index],
                        viewModel._activeIndex,
                      );
                    },
                    options: CarouselOptions(
                      height: 230.h,
                      onPageChanged: (index, reason) =>
                          viewModel.updateActiveIndex(index),
                      autoPlay: true,
                      autoPlayInterval: 4.seconds,
                      viewportFraction: 1,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: 1.seconds,
                      autoPlayCurve: Curves.easeInOut,
                      enlargeCenterPage: true,
                    ),
                  ),
            20.verticalSpace,
            if (viewModel._highlights.isNotEmpty)
              CarouselUtils.buildIndicator(
                context,
                viewModel.activeIndex,
                viewModel.highlights.length,
              ),
          ],
        ),
      ),
    );
  }
}

class UserGreetingsWidget extends ViewModelWidget<HomeViewModel> {
  const UserGreetingsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    FontThemeClass fontTheme = FontThemeClass();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0).r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 280.w,
            child: Text(
              overflow: TextOverflow.ellipsis,
              'Hey ${viewModel.splitusername()} 👋',
              style: fontTheme.title(
                context,
                color: context.colorScheme.primaryText,
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(),
          ),
        ],
      ),
    );
  }
}

Widget updatesCard(List updateList, int i, BuildContext context, viewModel) {
  FontThemeClass fontTheme = FontThemeClass();
  return ExpandableNotifier(
    initialExpanded: false,
    child: Expandable(
      collapsed: Card(
        margin: const EdgeInsets.only(bottom: 8).r,
        color: context.colorScheme.card,
        elevation: 0,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16).r,
          side: BorderSide(
            color: context.colorScheme.secondaryText.withOpacity(0.2),
            width: 1.w,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0).r,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CardTitle(title: updateList[i].title),
                  CardDate(date: updateList[i].date),
                ],
              ),
              2.verticalSpace,
              CollapsedDescription(description: updateList[i].description),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: ExpandableButton(
                      child: Text(
                        "Read More",
                        style: fontTheme.body(
                          context,
                          color: context.colorScheme.toggle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      expanded: Card(
        margin: const EdgeInsets.only(bottom: 8).r,
        color: context.colorScheme.card,
        elevation: 0,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16).r,
          side: BorderSide(
            color: context.colorScheme.secondaryText.withOpacity(0.2),
            width: 1.w,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CardTitle(title: updateList[i].title),
                  CardDate(date: updateList[i].date),
                ],
              ),
              2.verticalSpace,
              ExpandedDescription(
                description: updateList[i].description,
                url: updateList[i].url,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ExpandableButton(
                    child: Text(
                      "Read Less",
                      style: fontTheme.body(
                        context,
                        color: context.colorScheme.toggle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class CollapsedDescription extends StatelessWidget {
  final String description;
  const CollapsedDescription({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    FontThemeClass fontTheme = FontThemeClass();
    return Text(
      description,
      maxLines: 2,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.justify,
      style: fontTheme.caption(
        context,
        color: context.colorScheme.secondaryText,
      ),
    );
  }
}

class ExpandedDescription extends StatelessWidget {
  final String description;
  final String url;
  const ExpandedDescription({
    super.key,
    required this.description,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    FontThemeClass fontTheme = FontThemeClass();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          description,
          maxLines: 100,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.justify,
          style: fontTheme.caption(
            context,
            color: context.colorScheme.secondaryText,
          ),
        ),
        4.verticalSpace,
        Visibility(
          visible: url.isNotEmpty || url != "",
          child: Row(
            children: [
              const Text("For more details :-\t"),
              2.horizontalSpace,
              GestureDetector(
                onTap: () {
                  UrlLauncher().launchURL(url);
                },
                child: Text(
                  url.split("/").last,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: fontTheme.caption(
                    context,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CardDate extends StatelessWidget {
  final Timestamp date;
  const CardDate({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    FontThemeClass fontTheme = FontThemeClass();

    return Text(
      "Posted ${DateFormat("MMM d").format((date).toDate())}",
      style: fontTheme.caption(
        context,
        color: context.colorScheme.secondaryText,
      ),
    );
  }
}

class CardTitle extends StatelessWidget {
  final String title;
  const CardTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    FontThemeClass fontTheme = FontThemeClass();

    return Expanded(
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: fontTheme.body(
          context,
          color: context.colorScheme.toggle,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
