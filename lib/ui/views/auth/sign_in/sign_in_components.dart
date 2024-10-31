import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/ui/views/auth/sign_in/sign_in_view.dart';

class SigninNavigateBack extends ViewModelWidget<SignInViewModel> {
  const SigninNavigateBack({super.key});

  @override
  Widget build(BuildContext context, SignInViewModel viewModel) {
    return InkWell(
      onTap: () => viewModel.navigateBack(),
      child: SizedBox(
        width: double.maxFinite,
        child: Container(
          width: 40.w,
          padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10).r,
          alignment: Alignment.centerLeft,
          child: const Icon(
            Icons.arrow_back_rounded,
            size: 25,
          ),
        ),
      ),
    );
  }
}
