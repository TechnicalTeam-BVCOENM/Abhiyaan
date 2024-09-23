import 'package:abhiyaan/file_exporter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:story/story_page_view.dart';

part 'auth_view_model.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final font = FontThemeClass();
    return ViewModelBuilder<AuthViewModel>.reactive(
      viewModelBuilder: () => AuthViewModel(),
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: context.colorScheme.white,
          body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Expanded(
                  child: StoryPageView(
                    indicatorDuration: const Duration(seconds: 2),
                    indicatorVisitedColor: Colors.transparent,
                    indicatorUnvisitedColor: Colors.transparent,
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
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.0.w),
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        text:
                                            "A place where you can connect, share and explore ",
                                        style: font.title(
                                          context,
                                          fontWeight: FontWeight.w500,
                                          color: context.colorScheme.black,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: model.story[storyIndex]
                                                .toLowerCase(),
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
                                  // Center(
                                  //   child: Text(
                                  //     model.story[storyIndex].toLowerCase(),
                                  //     style: font.title(
                                  //       context,
                                  //       fontWeight: FontWeight.w700,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    pageLength: 1,
                    storyLength: (int pageIndex) {
                      return model.story.length;
                    },
                    onPageLimitReached: () {},
                  ),
                ),

                // Login Buttons
                Container(
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
                      GestureDetector(
                        onTap: () {
                          model.toSignInPage(context);
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
                      ),
                      12.verticalSpace,
                      GestureDetector(
                        onTap: () {
                          model.toRegisterPage(context);
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
                      ),
                      const Spacer(),
                      Center(
                        child: Text(
                          "By continuing, you agree to our Terms of Service and Privacy Policy",
                          style: font.small(
                            context,
                            color: context.colorScheme.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
