import 'package:abhiyaan/file_exporter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:story/story_page_view.dart';

part 'auth_view_model.dart';
part 'auth_view_components.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});
  @override
  Widget build(BuildContext context) {
    final font = FontThemeClass();
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
          body: SafeArea(
            child: Column(
              children: [
                // LOGO AND INFO
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
                          buildInfoWidget(context, font, model, storyIndex),
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

                // LOGIN AND REGISTER BUTTONS
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
                      buildLoginButton(model, context),
                      12.verticalSpace,
                      buildRegisterButton(model, context),
                      const Spacer(),
                      Center(
                        child: Text(
                          "By continuing, you agree to our Terms of Service and Privacy Policy", // TODO: Add Terms of Service and Privacy Policy links
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
