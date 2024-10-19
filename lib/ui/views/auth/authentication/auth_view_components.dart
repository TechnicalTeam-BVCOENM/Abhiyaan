import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/ui/views/auth/authentication/auth_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:story/story_page_view.dart';

class OnboardingText extends ViewModelWidget<AuthViewModel> {
  const OnboardingText({super.key});

  @override
  Widget build(BuildContext context, AuthViewModel viewModel) {
    return Expanded(
      child: StoryPageView(
        indicatorVisitedColor: Colors.transparent,
        indicatorUnvisitedColor: Colors.transparent,
        indicatorDuration: const Duration(seconds: 2),
        indicatorPadding:
            EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
        itemBuilder: (context, pageIndex, storyIndex) {
          return Stack(
            children: [
              // App Name
              Positioned(
                top: 65.h,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "Abhiyaan",
                          style: viewModel.font.display(
                            context,
                            color: context.colorScheme.accentColor,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      45.verticalSpace,
                      Center(
                        child: SvgPicture.asset(
                          "assets/logo_c_dk.svg",
                          semanticsLabel: "Abhiyaan Logo",
                          height: 150.h,
                          width: 150.w,
                        ),
                      ),
                      45.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text:
                                "A place where you can connect, share and explore ",
                            style: viewModel.font.title(
                              context,
                              fontWeight: FontWeight.w500,
                              color: context.colorScheme.black,
                            ),
                            children: [
                              TextSpan(
                                text: viewModel.story[storyIndex].toLowerCase(),
                                style: viewModel.font.title(
                                  context,
                                  fontWeight: FontWeight.w800,
                                  color: context.colorScheme.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        pageLength: 1,
        storyLength: (int pageIndex) {
          return viewModel.story.length;
        },
        onPageLimitReached: () {},
      ),
    );
  }
}

class AuthOptions extends ViewModelWidget<AuthViewModel> {
  const AuthOptions({super.key});

  @override
  Widget build(BuildContext context, AuthViewModel viewModel) {
    return Container(
      padding: EdgeInsets.all(20.dg),
      decoration: BoxDecoration(
        color: context.colorScheme.black,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(30).r,
          topRight: const Radius.circular(30).r,
        ),
      ),
      height: 190.h,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          const LoginButton(),
          12.verticalSpace,
          const RegisterButton(),
          const Spacer(),
          Center(
            child: Text(
              "By continuing, you agree to our Terms of Service and Privacy Policy",
              style: viewModel.font.small(
                context,
                color: context.colorScheme.white,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}

class LoginButton extends ViewModelWidget<AuthViewModel> {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context, AuthViewModel viewModel) {
    return GestureDetector(
        onTap: () {
          viewModel.toSignInPage(context);
        },
        child: Container(
          width: double.infinity.w,
          padding: const EdgeInsets.all(8).r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12).r,
            color: context.colorScheme.accentColor,
          ),
          child: Center(
            child: Text(
              'Sign In',
              style: FontThemeClass().title2(
                context,
                color: context.colorScheme.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ));
  }
}

class RegisterButton extends ViewModelWidget<AuthViewModel> {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context, AuthViewModel viewModel) {
    return GestureDetector(
      onTap: () {
        viewModel.toRegisterPage(context);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8).r,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12).r,
          color: context.colorScheme.white,
        ),
        child: Center(
          child: Text(
            'Register',
            style: FontThemeClass().title2(
              context,
              color: context.colorScheme.primaryDarkText,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
