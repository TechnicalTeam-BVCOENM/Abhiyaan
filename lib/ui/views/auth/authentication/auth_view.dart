import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/ui/views/auth/authentication/auth_view_components.dart';

part 'auth_view_model.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthViewModel>.reactive(
      viewModelBuilder: () => AuthViewModel(),
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: context.colorScheme.scaffold,
          body: const SafeArea(
            bottom: false,
            child: Column(
              children: [
                // Onboarding Text
                OnboardingText(),
                // Auth Buttons
                AuthOptions()
              ],
            ),
          ),
        );
      },
    );
  }
}
