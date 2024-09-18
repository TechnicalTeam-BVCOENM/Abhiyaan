import 'package:abhiyaan/ui/common/circular_loading_indicator.dart';
import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/ui/common/toast_message.dart';
import 'package:abhiyaan/ui/common/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:in_app_review/in_app_review.dart';
import 'dart:io' show Platform;
part 'profile_view_model.dart';
part "profile_view_component.dart";

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = locator<ThemeService>();

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: themeService.brightness == Brightness.light
            ? context.colorScheme.scaffold
            : Colors.transparent,
        statusBarIconBrightness: themeService.brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
      ),
    );
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => locator<ProfileViewModel>(),
      onViewModelReady: (viewModel) => viewModel.init(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: context.colorScheme.scaffold,
          body: model.isBusy
              ? const CircularLoadingIndicator()
              : SafeArea(
                  minimum: const EdgeInsets.symmetric(horizontal: 33).r,
                  child: Column(
                    children: [
                      const ProfileImageWidget(),
                      // Container(
                      // width: double.infinity,
                      // decoration: BoxDecoration(
                      //     color: context.colorScheme.scaffold,
                      //     image: const DecorationImage(
                      //         image: AssetImage(
                      //             AssetImagePath.profileBackLines),
                      //         fit: BoxFit.cover)),
                      // child: const ProfileImageWidget()),

                      // Settings
                      const ProfileSectionText(title: 'Settings'),
                      16.verticalSpace,
                      const ProfileCard(),
                      16.verticalSpace,
                      const DarkModeTile(),
                      16.verticalSpace,

                      // Others
                      const ProfileSectionText(title: 'Others'),
                      16.verticalSpace,
                      const RateAppTile(),
                      16.verticalSpace,
                      const HelpSupportTile(),
                      16.verticalSpace,
                      const PrivacyPolicyTile(),

                      // Socials
                      const Spacer(),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SocialLinks(
                            iconpath: AssetImagePath.instagramImg,
                            url: AssetUrls.instagramUrl,
                          ),
                          SocialLinks(
                            iconpath: AssetImagePath.linkedinImg,
                            url: AssetUrls.linkedinUrl,
                          ),
                          SocialLinks(
                            iconpath: AssetImagePath.xImg,
                            url: AssetUrls.twitterUrl,
                          ),
                        ],
                      ),
                      20.verticalSpace,
                    ],
                  ),
                ),
        );
      },
    );
  }
}
