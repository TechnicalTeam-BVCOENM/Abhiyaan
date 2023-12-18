import 'package:cached_network_image/cached_network_image.dart';
import 'package:darpan/file_exporter.dart';
import 'package:darpan/ui/views/profile/profile_view_component.dart';
part 'profile_view_model.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
        viewModelBuilder: () => ProfileViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: context.colorScheme.backgroundColor,
            appBar: AppBar(
              backgroundColor: context.colorScheme.backgroundColor,
              actions: [
                TextButton(
                  onPressed: () => model.navigateToSettingsView(),
                  child: SizedBox(
                    width: 28.w,
                    child: Icon(
                      Icons.settings,
                      size: 32.r,
                      color: context.colorScheme.switchColor,
                    ),
                  ),
                ),
              ],
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Padding(
                padding: const EdgeInsets.only(top: 8, left: 18).r,
                child: Center(
                  child: Container(
                    margin: EdgeInsets.only(left: 40.r),
                    child: Text(
                      "Profile",
                      style: FontThemeClass().title(context,
                          fontWeight: FontWeight.w500,
                          color: context.colorScheme.secondaryBlackColor),
                    ),
                  ),
                ),
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.r),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 45.r),
                      child: Row(
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                              width: 90.r,
                              height: 90.r,
                              fit: BoxFit.cover,
                              imageUrl:
                                  "https://firebasestorage.googleapis.com/v0/b/darpan-b94d6.appspot.com/o/user%2Fimages.jpeg?alt=media&token=a9889ba7-3958-4784-9708-e43ade1016d4",
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator.adaptive()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          SizedBox(
                            width: 25.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocalStorageService().read('userName'),
                                style: FontThemeClass().title2(context,
                                    color:
                                        context.colorScheme.secondaryBlackColor,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(LocalStorageService().read('userYear'),
                                  style: FontThemeClass().body(context,
                                      color: context
                                          .colorScheme.secondarySectionColor,
                                      fontWeight: FontWeight.w500))
                            ],
                          )
                        ],
                      ),
                    ),
                    for (var profileCard in model.profileCardList) profileCard,
                    // Display each profile card widget
                    const Cetificatation(),
                    const Expanded(child: Text("")),
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
                    SizedBox(
                      height: 20.h,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
