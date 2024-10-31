import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/ui/views/auth/register/register_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_animate/flutter_animate.dart';

class RegisterNavigateBack extends ViewModelWidget<RegisterViewModel> {
  const RegisterNavigateBack({super.key});

  @override
  Widget build(BuildContext context, RegisterViewModel viewModel) {
    return InkWell(
      onTap: () => viewModel.navigateBack(),
      child: Container(
        width: 40.w,
        padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10).r,
        alignment: Alignment.centerLeft,
        child: const Icon(
          Icons.arrow_back_rounded,
          size: 25,
        ),
      ),
    );
  }
}

class RegisterLogoQuote extends ViewModelWidget<RegisterViewModel> {
  const RegisterLogoQuote({super.key});

  @override
  Widget build(BuildContext context, RegisterViewModel viewModel) {
    return Column(
      children: [
        Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: context.colorScheme.primary,
                      spreadRadius: -45,
                      blurRadius: 70.0, // Adjust for desired fade
                    ),
                  ],
                ),
                child: SizedBox(
                  width: 180.w,
                  height: 180.h,
                  child: Image.asset(
                    AssetImagePath.logoImg,
                  ),
                )).animate(delay: 100.ms).fadeIn(
              delay: 100.ms,
              curve: Curves.easeInOut,
              duration: 700.ms,
            ),
        Text("Abhiyaan",
                textAlign: TextAlign.center,
                style: FontThemeClass().header(
                  context,
                )).animate(delay: 100.ms).fadeIn(
              delay: 200.ms,
              curve: Curves.easeInOut,
              duration: 500.ms,
            ),
        Text("Connect with Students, Teachers & Alumni",
                textAlign: TextAlign.center,
                style: FontThemeClass().body(
                  context,
                  color: context.colorScheme.secondaryText,
                  fontWeight: FontWeight.w500,
                )).animate(delay: 200.ms).fadeIn(
              delay: 100.ms,
              curve: Curves.easeInOut,
              duration: 500.ms,
            ),
        40.verticalSpace,
      ],
    );
  }
}

class RegisterForm extends ViewModelWidget<RegisterViewModel> {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context, RegisterViewModel viewModel) {
    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          cursorColor: context.colorScheme.accentColor,
          controller: viewModel.emailIdTextController,
          onChanged: (value) {
            viewModel.emailIdTextController.text =
                viewModel.emailIdTextController.text.trim();
          },
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 15).r,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                const Radius.circular(150).r,
              ),
              borderSide: BorderSide.none,
            ),
            fillColor: context.colorScheme.card,
            filled: true,
            focusColor: context.colorScheme.card,
            hintText: 'Email ID',
            errorText:
                viewModel.isEmailIdValid ? null : viewModel.emailIdErrorText,
            hintStyle: viewModel.fontTheme.caption(
              context,
              color: context.colorScheme.secondaryText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ).animate(delay: 300.ms).fadeIn(
              delay: 100.ms,
              curve: Curves.easeInOut,
              duration: 700.ms,
            ),
        15.verticalSpace,
        TextFormField(
          cursorColor: context.colorScheme.accentColor,
          controller: viewModel.userNameController,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 15).r,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                const Radius.circular(150).r,
              ),
              borderSide: BorderSide.none,
            ),
            fillColor: context.colorScheme.card,
            filled: true,
            focusColor: context.colorScheme.card,
            hintText: 'Username',
            errorText:
                viewModel.isEmailIdValid ? null : viewModel.emailIdErrorText,
            hintStyle: viewModel.fontTheme.caption(
              context,
              color: context.colorScheme.secondaryText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ).animate(delay: 400.ms).fadeIn(
              delay: 100.ms,
              curve: Curves.easeInOut,
              duration: 700.ms,
            ),
        15.verticalSpace,
        TextFormField(
          keyboardType: TextInputType.visiblePassword,
          cursorColor: context.colorScheme.accentColor,
          controller: viewModel.createpasswordTextController,
          obscureText: viewModel.isCreatePasswordVisible ? false : true,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 15).r,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  const Radius.circular(150).r,
                ),
                borderSide: BorderSide.none),
            fillColor: context.colorScheme.card,
            filled: true,
            focusColor: context.colorScheme.card,
            suffixIcon: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                viewModel.toggleCreatePasswordVisibility();
              },
              child: viewModel.isCreatePasswordVisible
                  ? Icon(
                      Icons.visibility_off,
                      color: context.colorScheme.secondaryText,
                    )
                  : Icon(
                      Icons.visibility,
                      color: context.colorScheme.secondaryText,
                    ),
            ),
            hintText: 'Create Password',
            hintStyle: viewModel.fontTheme.caption(
              context,
              color: context.colorScheme.secondaryText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ).animate(delay: 500.ms).fadeIn(
              delay: 100.ms,
              curve: Curves.easeInOut,
              duration: 700.ms,
            ),
        15.verticalSpace,
        TextFormField(
          keyboardType: TextInputType.visiblePassword,
          cursorColor: context.colorScheme.accentColor,
          controller: viewModel.confirmpasswordTextController,
          obscureText: viewModel.isConfirmPasswordVisible ? false : true,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 15).r,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                const Radius.circular(150).r,
              ),
              borderSide: BorderSide.none,
            ),
            fillColor: context.colorScheme.card,
            filled: true,
            focusColor: context.colorScheme.card,
            suffixIcon: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                viewModel.toggleConfirmPasswordVisibility();
              },
              child: viewModel.isConfirmPasswordVisible
                  ? Icon(
                      Icons.visibility_off,
                      color: context.colorScheme.secondaryText,
                    )
                  : Icon(
                      Icons.visibility,
                      color: context.colorScheme.secondaryText,
                    ),
            ),
            hintText: 'Confirm Password',
            hintStyle: viewModel.fontTheme.caption(
              context,
              color: context.colorScheme.secondaryText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ).animate(delay: 600.ms).fadeIn(
              delay: 100.ms,
              curve: Curves.easeInOut,
              duration: 700.ms,
            ),
        25.verticalSpace,
      ],
    );
  }
}

class RegisterButton extends ViewModelWidget<RegisterViewModel> {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context, RegisterViewModel viewModel) {
    return Column(
      children: [
        TextButton(
          onPressed: () async {
            viewModel.register(context);
          },
          style: ButtonStyle(
            minimumSize:
                const WidgetStatePropertyAll(Size(double.infinity, 50)),
            backgroundColor:
                WidgetStatePropertyAll(context.colorScheme.accentColor),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0).r,
              ),
            ),
          ),
          child: Text(
            'Register',
            style: FontThemeClass().title2(
              context,
              color: context.colorScheme.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ).animate(delay: 700.ms).fadeIn(
              delay: 100.ms,
              curve: Curves.easeInOut,
              duration: 700.ms,
            ),
        10.verticalSpace,
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Already have an account? ',
            style: FontThemeClass().caption(
              context,
              color: context.colorScheme.secondaryText,
              fontWeight: FontWeight.w500,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'Sign In',
                style: FontThemeClass().caption(
                  context,
                  color: context.colorScheme.accentColor,
                  fontWeight: FontWeight.w500,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    viewModel.navigateToSignIn();
                  },
              ),
            ],
          ),
        ).animate(delay: 800.ms).fadeIn(
              delay: 100.ms,
              curve: Curves.easeInOut,
              duration: 700.ms,
            ),
      ],
    );
  }
}

class RegsiterClosed extends ViewModelWidget<RegisterViewModel> {
  const RegsiterClosed({super.key});

  @override
  Widget build(BuildContext context, RegisterViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        320.verticalSpace,
        Image.asset(
          "assets/images/auth/road_closure.png",
          width: 100.w,
        ),
        20.verticalSpace,
        Text(
          "We're sorry, this feature is currently not available.".toUpperCase(),
          textAlign: TextAlign.center,
          style: viewModel.font.body(
            context,
            color: context.colorScheme.primaryText,
            fontWeight: FontWeight.w800,
          ),
        ),
        10.verticalSpace,
        Text(
          "Please try again later.".toUpperCase(),
          textAlign: TextAlign.center,
          style: viewModel.font.small(
            context,
            color: context.colorScheme.primaryText.withOpacity(0.5),
            fontWeight: FontWeight.w600,
          ),
        ),
        10.verticalSpace,
        TextButton(
            onPressed: () {
              viewModel.navigateToAuth();
            },
            child: Text("Go Back",
                style: viewModel.font.caption(
                  context,
                  color: context.colorScheme.accentColor,
                  fontWeight: FontWeight.w500,
                ))),
      ],
    );
  }
}

class ProblemWithRegister extends ViewModelWidget<RegisterViewModel> {
  final bool isRegister;
  const ProblemWithRegister({super.key, required this.isRegister});

  @override
  Widget build(BuildContext context, RegisterViewModel viewModel) {
    if (isRegister) {
      return GestureDetector(
        onTap: () => viewModel.navigateToHelpSupport(),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Problem with Registration? ',
            style: FontThemeClass().caption(
              context,
              color: context.colorScheme.secondaryText,
              fontWeight: FontWeight.w500,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'Report Issue',
                style: FontThemeClass().caption(
                  context,
                  color: context.colorScheme.accentColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ).animate(delay: 900.ms).fadeIn(
            delay: 100.ms,
            curve: Curves.easeInOut,
            duration: 700.ms,
          );
    } else {
      return const SizedBox();
    }
  }
}

class AppVersion extends ViewModelWidget<RegisterViewModel> {
  const AppVersion({super.key});

  @override
  Widget build(BuildContext context, RegisterViewModel viewModel) {
    return Column(
      children: [
        10.verticalSpace,
        Center(
          child: Text(
            'Abhiyaan v${AppConstants.appVersion}',
            textAlign: TextAlign.center,
            style: FontThemeClass().caption(
              context,
              color: context.colorScheme.secondaryText,
              fontWeight: FontWeight.w500,
            ),
          ).animate(delay: 1000.ms).fadeIn(
                delay: 100.ms,
                curve: Curves.easeInOut,
                duration: 700.ms,
              ),
        ),
        10.verticalSpace,
      ],
    );
  }
}
