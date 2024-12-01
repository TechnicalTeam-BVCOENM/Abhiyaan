part of 'auth_view.dart';

GestureDetector buildLoginButton(AuthViewModel model, BuildContext context) {
  return GestureDetector(
    onTap: () {
      model.navigateToSignInPage(context);
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
    ),
  );
}

GestureDetector buildRegisterButton(AuthViewModel model, BuildContext context) {
  return GestureDetector(
    onTap: () {
      model.navigateToRegisterPage(context);
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
            color: context.colorScheme.primaryText,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}

Positioned buildInfoWidget(BuildContext context, FontThemeClass font,
    AuthViewModel model, int storyIndex) {
  return Positioned(
    top: 65.h,
    width: MediaQuery.of(context).size.width,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: Column(
        children: [
          Center(
            child: Text(
              "Abhiyaan",
              style: font.display(
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
                text: "A place where you can connect, share and explore ",
                style: font.title(
                  context,
                  fontWeight: FontWeight.w500,
                  color: context.colorScheme.black,
                ),
                children: [
                  TextSpan(
                    text: model.story[storyIndex].toLowerCase(),
                    style: font.title(
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
  );
}

class AuthLogoInfo extends ViewModelWidget<AuthViewModel> {
  const AuthLogoInfo({super.key});

  @override
  Widget build(BuildContext context, AuthViewModel viewModel) {
    return Expanded(
      child: StoryPageView(
        indicatorDuration: const Duration(seconds: 2),
        indicatorVisitedColor: Colors.transparent,
        indicatorUnvisitedColor: Colors.transparent,
        indicatorPadding:
            EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
        itemBuilder: (context, pageIndex, storyIndex) {
          return Stack(
            children: [
              buildInfoWidget(context, viewModel.font, viewModel, storyIndex),
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

class AuthButtons extends ViewModelWidget<AuthViewModel> {
  const AuthButtons({super.key});

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
          buildLoginButton(viewModel, context),
          12.verticalSpace,
          buildRegisterButton(viewModel, context),
          const Spacer(),
          Center(
            child: Text(
              "By continuing, you agree to our Terms of Service and Privacy Policy", // TODO: Add Terms of Service and Privacy Policy links
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
