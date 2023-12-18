import 'package:darpan/file_exporter.dart';
import 'package:darpan/ui/views/auth/onboarding/onboarding_view_component.dart';
part 'onboarding_view_model.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});
  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    return ViewModelBuilder<OnboardingViewModel>.reactive(
      viewModelBuilder: () => OnboardingViewModel(),
      builder: (context, model, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: context.colorScheme.backgroundColor,
            body: Stack(
              children: [
                PageView(
                  controller: pageController,
                  children: [
                    for (var onboardingPages
                        in OnboardingComponents.getOnboardingPages(context))
                      onboardingPages,
                  ],
                ),
                Container(
                  alignment: const Alignment(-0.65, 0.42),
                  child: SmoothPageIndicator(
                      effect: const WormEffect(dotHeight: 5),
                      onDotClicked: (index) {
                        pageController.jumpToPage(index);
                      },
                      controller: pageController,
                      count: 3),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    alignment: const Alignment(0, 0.85),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 60.r,
                          height: 60.r,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(0),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      300), // Rounded corners
                                ),
                              ),
                              onPressed: () {
                                pageController.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOutQuad);
                              },
                              child: const Icon(Icons.arrow_back)),
                        ),
                        SizedBox(
                          width: 60.r,
                          height: 60.r,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(0),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      300), // Rounded corners
                                ),
                              ),
                              onPressed: () {
                                pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOutQuad);
                              },
                              child: const Icon(Icons.arrow_forward)),
                        )
                      ],
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
