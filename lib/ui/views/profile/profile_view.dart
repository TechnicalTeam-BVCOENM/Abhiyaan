import 'package:cached_network_image/cached_network_image.dart';
import 'package:abhiyaan/file_exporter.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:abhiyaan/ui/common/url_launcher.dart';
part 'profile_view_model.dart';
part "profile_view_component.dart";

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.nonReactive(
        viewModelBuilder: () => ProfileViewModel(),
        onViewModelReady: (viewModel) => viewModel.init(),
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: context.colorScheme.backgroundColor,
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: AppBarWidget(),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20).r,
                child: Column(
                  children: [
                    const ProfileCard(),
                    16.verticalSpace,
                    const DarkModeTile(),
                    16.verticalSpace,
                    model.localStorageService.read('userProfile') ==
                                "Explorer" ||
                            model.localStorageService.read('userProfile') ==
                                "Faculty"
                        ? const SizedBox()
                        : const Cerificatation().animate(delay: 200.ms).fadeIn(
                              delay: 100.ms,
                              curve: Curves.easeInOut,
                              duration: 300.ms,
                            ),
                    model.localStorageService.read('userProfile') ==
                                "Explorer" ||
                            model.localStorageService.read('userProfile') ==
                                "Faculty"
                        ? 0.verticalSpace
                        : 16.verticalSpace,
                    const HelpSupportTile(),
                    16.verticalSpace,
                    const PrivacyPolicyTile(),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SocialLinks(
                          iconpath: AssetImagePath.instagramImg,
                          url: AssetUrls.instagramUrl,
                        ),
                        const SocialLinks(
                          iconpath: AssetImagePath.linkedinImg,
                          url: AssetUrls.linkedinUrl,
                        ),
                        const SocialLinks(
                          iconpath: AssetImagePath.xImg,
                          url: AssetUrls.twitterUrl,
                        ),
                      ].animate(delay: 200.ms, interval: 100.ms).fadeIn(
                            delay: 100.ms,
                            curve: Curves.easeInOut,
                            duration: 400.ms,
                          ),
                    ),
                    20.verticalSpace,
                  ],
                ),
              ),
            ),
          );
        });
  }
}
