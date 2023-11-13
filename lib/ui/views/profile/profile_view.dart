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
            appBar: AppBar(
              actions: [
                TextButton(
                  onPressed: () => model.navigateToSettingsView(),
                  child: SizedBox(
                    width: 33.wWise,
                    child: Image.asset(AssetImagePath.settingImg),
                  ),
                ),
              ],
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Padding(
                padding: const EdgeInsets.only(top: 8, left: 18),
                child: Center(
                  child: Container(
                    margin: EdgeInsets.only(left: 30.wWise),
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
                padding: EdgeInsets.symmetric(horizontal: 20.wWise),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.hWise),
                      child: Row(
                        children: [
                          ClipOval(
                            clipper: MyClip(),
                            child: CachedNetworkImage(
                              width: 85.wWise,
                              fit: BoxFit.cover,
                              imageUrl:
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1K8v6grZ-ZUVMNO5SLPpv1757dIoupO612SvpYZfpzndi3Vg6QnqrxRQal1PHqZtdhBE&usqp=CAU",
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator.adaptive()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          SizedBox(
                            width: 24.wWise,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sachin Rathod",
                                style: FontThemeClass().profileheading(context),
                              ),
                              SizedBox(
                                height: 8.hWise,
                              ),
                              Text("BE COMPS",
                                  style: FontThemeClass().subHeading2(
                                      context,
                                      context
                                          .colorScheme.secondarySectionColor))
                            ],
                          )
                        ],
                      ),
                    ),
                    const ProfileDetailsCard(
                      leading: AssetImagePath.misImg,
                      title: "MIS Number",
                      value: "21121017",
                    ),
                    const ProfileDetailsCard(
                      leading: AssetImagePath.libraryImg,
                      title: "Library Card Number",
                      value: "98761112",
                    ),
                    const ProfileDetailsCard(
                      leading: AssetImagePath.idImg,
                      title: "College ID",
                      value: "125rathodsachin@gmail.com",
                    ),
                    const ProfileDetailsCard(
                      leading: AssetImagePath.misImg,
                      title: "PRN Number",
                      value: "123456781234",
                    ),
                    const Expanded(child: Text("")),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialLinks(
                          iconpath: AssetImagePath.instagramImg,
                        ),
                        SocialLinks(
                          iconpath: AssetImagePath.linkedinImg,
                        ),
                        SocialLinks(
                          iconpath: AssetImagePath.xImg,
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
    return const Rect.fromLTWH(0, 0, 85, 85);
  }

  @override
  bool shouldReclip(oldClipper) {
    return false;
  }
}
