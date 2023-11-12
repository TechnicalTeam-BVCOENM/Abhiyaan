import 'package:cached_network_image/cached_network_image.dart';
import 'package:darpan/file_exporter.dart';
import 'package:flutter/services.dart';
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
                    onPressed: () {},
                    child: SizedBox(
                        width: 33,
                        child: Image.asset("assets/profile/setting.png")))
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
                padding: EdgeInsets.symmetric(horizontal: 20.0.wWise),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.hWise),
                      child: Row(
                        children: [
                          ClipOval(
                            clipper: MyClip(),
                            child: CachedNetworkImage(
                              width: 85,
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
                                style: FontThemeClass().heading2(context),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text("BE COMPS",
                                  style: FontThemeClass().subHeading(
                                      context,
                                      context
                                          .colorScheme.secondarySectionColor))
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 70.hWise,
                      decoration: BoxDecoration(
                          color: context.colorScheme.secondaryWhiteColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 25,
                          ),
                          Image.asset(width: 22, "assets/profile/mis.png"),
                          const SizedBox(
                            width: 38,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "MIS Number",
                                style: FontThemeClass().heading4(context),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                "21121017",
                                style: FontThemeClass().subHeading2(context,
                                    context.colorScheme.secondarySectionColor),
                              ),
                            ],
                          ),
                          const Expanded(child: Text("")),
                          TextButton(
                              onPressed: () async {
                                await Clipboard.setData(
                                    const ClipboardData(text: "21121017"));
                                // ignore: use_build_context_synchronously
                                showmessage(context, "Copied");
                              },
                              child: Image.asset(
                                  width: 22, "assets/profile/copy.png")),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
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
