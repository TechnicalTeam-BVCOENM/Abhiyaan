// ignore_for_file: unused_element

import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/ui/views/auth/onboarding/onboarding_view.dart';

class OnboardingComponents {
  static List<Widget> getOnboardingPages(BuildContext context) {
    return [
      onboardingPage(
        context,
        AssetImagePath.screen1,
        "Join the community, connect, and share ideas",
        "Become a part of vibrant community where students, teachers, and alumni connect, collaborate, and exchange ideas to enhance learning and growth.",
        isFirstPage: true,
      ),
      onboardingPage(
        context,
        AssetImagePath.screen2,
        "Stay updated with all the exciting events happening in campus",
        "Join various clubs and societies, participate in events, and showcase your talents. Explore opportunities, learn new skills, and grow as an individual.",
      ),
      onboardingPage(
        context,
        AssetImagePath.screen3,
        "Get notified and explore highlights",
        "Stay informed with important updates and announcements. Discover highlights that showcase your experiences and keep you engaged in campus activities and events.",
      ),
    ];
  }

  static Widget onboardingPage(
    BuildContext context,
    String imagePath,
    String quote,
    String description, {
    bool isFirstPage = false,
  }) {
    return Container(
      color: context.colorScheme.white,
      child: Column(
        children: [
          isFirstPage ? 0.verticalSpace : 34.verticalSpace,
          // IMAGE
          SizedBox(
            width: double.infinity,
            child: Image.asset(imagePath),
          ),
          32.verticalSpace,
          // TEXT
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  quote,
                  textAlign: TextAlign.center,
                  style: FontThemeClass().header(
                    context,
                    color: context.colorScheme.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                12.verticalSpace,
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: FontThemeClass().body(
                    context,
                    color: context.colorScheme.black.withOpacity(0.5),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class OnboardingPageView extends ViewModelWidget<OnboardingViewModel> {
  const OnboardingPageView({super.key});

  @override
  Widget build(BuildContext context, OnboardingViewModel viewModel) {
    return PageView(
      onPageChanged: (index) {
        viewModel.index(index);
      },
      controller: viewModel.pageController,
      children: [
        for (var onboardingPages
            in OnboardingComponents.getOnboardingPages(context))
          onboardingPages,
      ],
    );
  }
}

class PageIndicator extends ViewModelWidget<OnboardingViewModel> {
  const PageIndicator({super.key});

  @override
  Widget build(BuildContext context, OnboardingViewModel viewModel) {
    return Container(
      alignment: const Alignment(0, 0.65),
      child: SmoothPageIndicator(
          effect: const WormEffect(dotHeight: 10, dotWidth: 10),
          onDotClicked: (index) {
            viewModel.pageController.jumpToPage(index);
          },
          controller: viewModel.pageController,
          count: 3),
    );
  }
}

class PageControllerIcons extends ViewModelWidget<OnboardingViewModel> {
  const PageControllerIcons({super.key});

  @override
  Widget build(BuildContext context, OnboardingViewModel viewModel) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 40),
        alignment: const Alignment(0, 0.85),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: 60.r,
                height: 60.r,
                child: viewModel.activeindex != 0
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(300), // Rounded corners
                          ),
                        ),
                        onPressed: () {
                          viewModel.updateindex(
                              context, false, viewModel.activeindex);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: context.colorScheme.secondaryText,
                        ))
                    : Container()),
            SizedBox(
              width: 60.r,
              height: 60.r,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(300), // Rounded corners
                    ),
                  ),
                  onPressed: () {
                    viewModel.updateindex(context, true, viewModel.activeindex);
                  },
                  child: viewModel.activeindex != 2
                      ? Icon(
                          Icons.arrow_forward,
                          color: context.colorScheme.secondaryText,
                        )
                      : const Icon(
                          Icons.done_rounded,
                          color: Colors.green,
                        )),
            )
          ],
        ));
  }
}
