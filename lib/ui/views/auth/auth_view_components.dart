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

//TODO: Move to components
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
