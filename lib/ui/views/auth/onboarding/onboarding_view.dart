import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/ui/views/auth/onboarding/onboarding_view_component.dart';
part 'onboarding_view_model.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnboardingViewModel>.reactive(
      viewModelBuilder: () => OnboardingViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: context.colorScheme.backgroundColor,
          body: SafeArea(
            child: Stack(
              children: [
                PageView(
                  onPageChanged: (index) {
                    model.index(index);
                  },
                  controller: model.pageController,
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
                        model.pageController.jumpToPage(index);
                      },
                      controller: model.pageController,
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
                            child: model.activeindex != 0
                                ? ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(0),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            300), // Rounded corners
                                      ),
                                    ),
                                    onPressed: () {
                                      model.updateindex(
                                          context, false, model.activeindex);
                                    },
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: context
                                          .colorScheme.secondarySectionColor,
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
                                  borderRadius: BorderRadius.circular(
                                      300), // Rounded corners
                                ),
                              ),
                              onPressed: () {
                                model.updateindex(
                                    context, true, model.activeindex);
                              },
                              child: model.activeindex != 2
                                  ? Icon(
                                      Icons.arrow_forward,
                                      color: context
                                          .colorScheme.secondarySectionColor,
                                    )
                                  : const Icon(
                                      Icons.done_rounded,
                                      color: Colors.green,
                                    )),
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
