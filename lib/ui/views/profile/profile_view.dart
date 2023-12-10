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
                    width: 28.sp,
                    child: Icon(
                      Icons.settings,
                      size: 30.sp,
                      color: context.colorScheme.primaryColor,
                    ),
                  ),
                ),
              ],
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Padding(
                padding: const EdgeInsets.only(top: 8, left: 18),
                child: Center(
                  child: Container(
                    margin: EdgeInsets.only(left: 40.sp),
                    child: Text(
                      "Profile",
                      style: FontThemeClass().appBarText(context),
                    ),
                  ),
                ),
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 45.sp),
                      child: Row(
                        children: [
                          ClipOval(
                            clipper: MyClip(),
                            child: CachedNetworkImage(
                              width: 80.sp,
                              height: 80.sp,
                              fit: BoxFit.cover,
                              imageUrl: LocalStorageService().read('userImg'),
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator.adaptive()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          SizedBox(
                            width: 30.sp,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocalStorageService().read('userName'),
                                style: FontThemeClass().profileheading(context),
                              ),
                              SizedBox(
                                height: 7.h,
                              ),
                              Text(LocalStorageService().read('userYear'),
                                  style: FontThemeClass().subHeading2(
                                      context,
                                      context
                                          .colorScheme.secondarySectionColor))
                            ],
                          )
                        ],
                      ),
                    ),
                    ProfileDetailsCard(
                      leading: AssetImagePath.misImg,
                      title: "MIS Number",
                      value: LocalStorageService().read('userMisNo'),
                    ),
                    ProfileDetailsCard(
                      leading: AssetImagePath.libraryImg,
                      title: "Library Card Number",
                      value: LocalStorageService().read('userLibNo'),
                    ),
                    ProfileDetailsCard(
                      leading: AssetImagePath.idImg,
                      title: "College ID",
                      value: LocalStorageService().read('userCollegeId'),
                    ),
                    ProfileDetailsCard(
                      leading: AssetImagePath.prnImg,
                      title: "PRN Number",
                      value: LocalStorageService().read('userPrnNo'),
                    ),
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
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class MyClip extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return const Rect.fromLTWH(0, 0, 70, 70);
  }

  @override
  bool shouldReclip(oldClipper) {
    return false;
  }
}
