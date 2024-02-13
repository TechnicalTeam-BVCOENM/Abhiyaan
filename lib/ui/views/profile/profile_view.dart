import 'package:abhiyaan/ui/common/circular_loading_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/ui/common/url_launcher.dart';

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
            ? context.colorScheme.scaffoldBackgroundColor
            : Colors.transparent,
        statusBarIconBrightness: themeService.brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
      ),
    );
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: context.colorScheme.scaffoldBackgroundColor,
          body: model.isBusy
              ? const CircularLoadingIndicator()
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20).r,
                    child: Column(
                      children: [
                        const AppBarWidget(),
                        16.verticalSpace,
                        const ProfileCard(),
                        16.verticalSpace,
                        const DarkModeTile(),
                        // 16.verticalSpace,
                        // model.localStorageService.read('userProfile') == "Explorer" || model.localStorageService.read('userProfile') == "Faculty"
                        //     ? const SizedBox()
                        //     : const Cerificatation(),
                        16.verticalSpace,
                        const HelpSupportTile(),
                        16.verticalSpace,
                        const PrivacyPolicyTile(),
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
                ),
        );
      },
    );
  }
}
