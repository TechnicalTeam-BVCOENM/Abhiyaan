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
          backgroundColor: context.colorScheme.scaffold,
          body: const SafeArea(
            child: Stack(
              children: [
                OnboardingPageView(),
                PageIndicator(),
                PageControllerIcons()
              ],
            ),
          ),
        );
      },
    );
  }
}
