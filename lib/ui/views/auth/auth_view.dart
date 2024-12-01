import 'package:abhiyaan/file_exporter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:story/story_page_view.dart';

part 'auth_view_model.dart';
part 'auth_view_components.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthViewModel>.reactive(
      viewModelBuilder: () => AuthViewModel(),
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, model, child) {
        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
        );
        return Scaffold(
          backgroundColor: context.colorScheme.white,
          body: const SafeArea(
            child: Column(
              children: [
                // LOGO AND INFO
                AuthLogoInfo(),
                // LOGIN AND REGISTER BUTTONS
                AuthButtons(),
              ],
            ),
          ),
        );
      },
    );
  }
}
