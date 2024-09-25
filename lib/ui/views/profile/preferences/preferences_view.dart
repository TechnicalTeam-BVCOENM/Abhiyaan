import 'package:abhiyaan/app/app.dialogs.dart';
import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/services/auth_service.dart';
import 'package:abhiyaan/services/firestore_service.dart';
import 'package:abhiyaan/ui/common/circular_loading_indicator.dart';
import 'package:abhiyaan/ui/common/toast_message.dart';
import 'package:abhiyaan/ui/views/bottom_nav/bottom_nav_view.dart';
import 'package:abhiyaan/ui/views/profile/profile_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_animate/flutter_animate.dart';

part 'preferences_view_model.dart';
part 'preferences_view_components.dart';

class PreferencesView extends StatelessWidget {
  const PreferencesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PreferencesViewModel>.reactive(
      viewModelBuilder: () => PreferencesViewModel(),
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, model, child) {
        final font = FontThemeClass();
        return Scaffold(
          backgroundColor: context.colorScheme.scaffold,
          appBar: _appBar(context),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25).r,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    35.verticalSpace,
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            model.updateImageSheet(context);
                          },
                          child: Stack(
                            children: [
                              Hero(
                                tag: "profileImage",
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    width: 100.r,
                                    height: 100.r,
                                    fit: BoxFit.cover,
                                    imageUrl: AssetUrls.profileImageUrl == '' ||
                                            AssetUrls.profileImageUrl ==
                                                'Not Available'
                                        ? AssetUrls.dummyImageUrl
                                        : AssetUrls.profileImageUrl,
                                    placeholder: (context, url) =>
                                        const CircularLoadingIndicator(),
                                    errorWidget: (context, url, error) {
                                      return Container(
                                          color: context.colorScheme.card,
                                          child: const Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ));
                                    },
                                  ),
                                ),
                              ),
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: context
                                            .colorScheme.bottomNavIconActive),
                                    child: Transform.flip(
                                      child: Icon(
                                        Icons.edit,
                                        size: 25.r,
                                        color: context.colorScheme.scaffold,
                                      ),
                                    ),
                                  )).animate(delay: 400.ms).scale(),
                            ],
                          ),
                        ),
                        4.verticalSpace,
                        Text(
                          model.localStorageService.read('userName'),
                          style: font.title2(
                            context,
                            color: context.colorScheme.primaryText,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        2.verticalSpace,
                        Text(
                          model.localStorageService.read('userProfile'),
                          style: font.body(
                            context,
                            color: context.colorScheme.secondaryText,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    30.verticalSpace,
                    model.localStorageService.read('userProfile') ==
                                "Explorer" ||
                            model.localStorageService.read('userProfile') ==
                                "Faculty"
                        ? Container()
                        : const MisNumberTile(),
                    model.localStorageService.read('userProfile') ==
                                "Explorer" ||
                            model.localStorageService.read('userProfile') ==
                                "Faculty"
                        ? 0.verticalSpace
                        : 16.verticalSpace,
                    const EmailAdressTile(),
                    16.verticalSpace,
                    const PasswordChangeTile(),
                    180.verticalSpace,
                    const LogoutButton(),
                    22.verticalSpace,
                    Text(
                      'Abhiyaan v${AppConstants.appVersion}',
                      style: font.paragraph(
                        context,
                        color: context.colorScheme.secondaryText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Made with ❤️ by TheDevCrew ',
                      style: font.caption(
                        context,
                        color: context.colorScheme.secondaryText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    18.verticalSpace,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
