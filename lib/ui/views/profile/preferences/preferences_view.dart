import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/services/auth_service.dart';
import 'package:abhiyaan/ui/common/circular_loading_indicator.dart';
import 'package:abhiyaan/ui/common/toast_message.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
          backgroundColor: context.colorScheme.scaffold,
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                model._navigationService.back();
              },
              child: Container(
                color: context.colorScheme.scaffold,
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: context.colorScheme.primaryText,
                ),
              ),
            ),
            backgroundColor: context.colorScheme.scaffold,
            centerTitle: true,
            elevation: 0,
            title: Text(
              "My Details",
              style: model.fontTheme.title(
                context,
                color: context.colorScheme.primaryText,
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
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        useSafeArea: true,
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height / 3,
                          minWidth: double.infinity,
                        ),
                        backgroundColor: context.colorScheme.scaffold,
                        clipBehavior: Clip.hardEdge,
                        elevation: 0,
                        showDragHandle: true,
                        context: context,
                        builder: (context) {
                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20)
                                .r,
                            decoration: BoxDecoration(
                              color: context.colorScheme.scaffold,
                              borderRadius: BorderRadius.circular(32).r,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextFormField(
                                  keyboardType: TextInputType.name,
                                  cursorColor: context.colorScheme.accentColor,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 15)
                                        .r,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        const Radius.circular(15).r,
                                      ),
                                      borderSide: BorderSide.none,
                                    ),
                                    fillColor: context.colorScheme.card,
                                    filled: true,
                                    focusColor: context.colorScheme.card,
                                    hintText: 'Enter image link.....',
                                    // errorText:
                                    //     model.isEmailIdValid ? null : model.emailIdErrorText,
                                    hintStyle: model.fontTheme.caption(
                                      context,
                                      color: context.colorScheme.secondaryText,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ).animate(delay: 300.ms).fadeIn(
                                      delay: 100.ms,
                                      curve: Curves.easeInOut,
                                      duration: 700.ms,
                                    ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    splashColor: Colors.transparent,
                    child: Stack(
                      children: [
                        Hero(
                          tag: "profileImage",
                          child: ClipOval(
                            child: CachedNetworkImage(
                              width: 100.r,
                              height: 100.r,
                              fit: BoxFit.cover,
                              imageUrl: AssetUrls.dummyImageUrl,
                              placeholder: (context, url) =>
                                  const CircularLoadingIndicator(),
                              errorWidget: (context, url, error) {
                                return const Icon(Icons.error);
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
                                  borderRadius: BorderRadius.circular(100),
                                  color:
                                      context.colorScheme.bottomNavIconActive),
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
                  8.verticalSpace,
                  Text(
                    model.localStorageService.read('userName'),
                    style: model.fontTheme.title2(
                      context,
                      color: context.colorScheme.primaryText,
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
                    'Abhiyaan v.1.0.5',
                    style: model.fontTheme.paragraph(
                      context,
                      color: context.colorScheme.secondarySectionColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Made with ❤️ by TheDevCrew ',
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
