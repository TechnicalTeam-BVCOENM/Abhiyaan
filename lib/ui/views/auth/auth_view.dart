import 'package:abhiyaan/file_exporter.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
          body: SafeArea(
            bottom: true,
            minimum: const EdgeInsets.symmetric(horizontal: 18).r,
            child: Column(
              children: [
                4.verticalSpace,
                Container(
                  width: double.infinity,
                  height: 500.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30).r,
                    color: context.colorScheme.accentColor.withOpacity(0.3),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        width: double.infinity.w,
                        image: const AssetImage(
                          'assets/images/abhiyaan_logo1.png',
                        ),
                      ),
                      Image(image: Image.asset(AssetImagePath.login).image),
                    ],
                  ),
                )
                    .animate(delay: 200.ms)
                    .slideY(
                      curve: Curves.easeInOut,
                      duration: 600.ms,
                    )
                    .fadeIn(
                      delay: 100.ms,
                      curve: Curves.easeInOut,
                      duration: 600.ms,
                    ),
                24.verticalSpace,
                Text(
                  "Discover College Events and Updates",
                  textAlign: TextAlign.center,
                  style: FontThemeClass().title(
                    context,
                    color: context.colorScheme.primaryText,
                    fontWeight: FontWeight.w500,
                  ),
                ).animate(delay: 200.ms).fadeIn(
                      delay: 100.ms,
                      curve: Curves.easeInOut,
                      duration: 700.ms,
                    ),
                model.showRegister ? 6.verticalSpace : 16.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0).r,
                  child: Text(
                    "Connect to access exclusive event details, college updates, and connect with the community. Sign in or register now to stay in the loop!",
                    textAlign: TextAlign.center,
                    style: FontThemeClass().caption(
                      context,
                      color: context.colorScheme.secondaryText,
                      fontWeight: FontWeight.w500,
                    ),
                  ).animate(delay: 200.ms).fadeIn(
                        delay: 100.ms,
                        curve: Curves.easeInOut,
                        duration: 700.ms,
                      ),
                ),
                model.showRegister ? 30.verticalSpace : 40.verticalSpace,
                GestureDetector(
                  onTap: () {
                    model.toSignInPage(context);
                  },
                  child: Container(
                    width: double.infinity.w,
                    padding: const EdgeInsets.all(8).r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15).r,
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
                ).animate(delay: 200.ms).fadeIn(
                      delay: 100.ms,
                      curve: Curves.easeInOut,
                      duration: 700.ms,
                    ),
                12.verticalSpace,
                model.showRegister
                    ? GestureDetector(
                        onTap: () {
                          model.toRegisterPage(context);
                        },
                        child: Container(
                          width: double.infinity.w,
                          padding: const EdgeInsets.all(8).r,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15).r,
                            border: Border.all(
                              width: 2,
                              color: context.colorScheme.accentColor,
                            ),
                            color: context.colorScheme.scaffold,
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
                      ).animate(delay: 200.ms).fadeIn(
                          delay: 100.ms,
                          curve: Curves.easeInOut,
                          duration: 700.ms,
                        )
                    : Container(),
                10.verticalSpace,
              ].animate(interval: 50.ms).fadeIn(
                    delay: 100.ms,
                    curve: Curves.easeInOut,
                    duration: 500.ms,
                  ),
            ),
          ),
        );
      },
    );
  }
}
