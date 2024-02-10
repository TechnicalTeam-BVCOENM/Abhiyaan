import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/services/auth_service.dart';
import 'package:abhiyaan/ui/common/circular_loading_indicator.dart';
import 'package:abhiyaan/ui/common/toast_message.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'preferences_view_model.dart';
part 'preferences_view_components.dart';

class PreferencesView extends StatelessWidget {
  const PreferencesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PreferencesViewModel>.nonReactive(
      viewModelBuilder: () => PreferencesViewModel(),
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: context.colorScheme.scaffoldBackgroundColor,
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                model._navigationService.back();
              },
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: context.colorScheme.primaryTextColor,
              ),
            ),
            backgroundColor: context.colorScheme.scaffoldBackgroundColor,
            centerTitle: true,
            elevation: 0,
            title: Text(
              "My Details",
              style: model.fontTheme.title(
                context,
                color: context.colorScheme.primaryTextColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20).r,
              child: Column(
                children: [
                  35.verticalSpace,
                  Hero(
                    tag: "profileImage",
                    child: ClipOval(
                      child: CachedNetworkImage(
                        width: 100.r,
                        height: 100.r,
                        fit: BoxFit.cover,
                        imageUrl: AssetUrls.dummyImageUrl,
                        placeholder: (context, url) => const Center(
                          child: CircularLoadingIndicator(),
                        ),
                        errorWidget: (context, url, error) {
                          return const Icon(Icons.error);
                        },
                      ),
                    ),
                  ),
                  8.verticalSpace,
                  Text(
                    model.localStorageService.read('userName'),
                    style: model.fontTheme.title2(
                      context,
                      color: context.colorScheme.primaryTextColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  2.verticalSpace,
                  Text(
                    model.localStorageService.read('userProfile'),
                    style: model.fontTheme.body(
                      context,
                      color: context.colorScheme.secondarySectionColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  30.verticalSpace,
                  model.localStorageService.read('userProfile') == "Explorer" ||
                          model.localStorageService.read('userProfile') ==
                              "Faculty"
                      ? Container()
                      : const MisNumberTile(),
                  model.localStorageService.read('userProfile') == "Explorer" ||
                          model.localStorageService.read('userProfile') ==
                              "Faculty"
                      ? 0.verticalSpace
                      : 16.verticalSpace,
                  const EmailAdressTile(),
                  16.verticalSpace,
                  const PasswordChangeTile(),
                  const Spacer(),
                  const LogoutButton(),
                  22.verticalSpace,
                  Text(
                    'Abhiyaan v.1.0.3',
                    style: model.fontTheme.paragraph(
                      context,
                      color: context.colorScheme.secondarySectionColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Made with ❤️ by Technical Team ',
                    style: model.fontTheme.caption(
                      context,
                      color: context.colorScheme.secondarySectionColor,
                    ),
                  ),
                  18.verticalSpace,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
