import 'package:abhiyaan/ui/common/common_component_model.dart';
import 'package:flutter/services.dart';
import 'package:abhiyaan/file_exporter.dart';
import '../../common/toast_message.dart';

class ProfileDetailsCard extends StatelessWidget {
  final String leading;
  final String title;
  final String value;
  final IconData icon;

  const ProfileDetailsCard({
    super.key,
    required this.leading,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 75.h,
      margin: EdgeInsets.only(bottom: 20.r),
      decoration: BoxDecoration(
          color: context.colorScheme.secondaryWhiteColor,
          borderRadius: BorderRadius.circular(20.r)),
      child: Row(
        children: [
          SizedBox(
            width: 25.w,
          ),
          Image.asset(width: 36.w, leading),
          SizedBox(
            width: 32.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200.w,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  title,
                  style: FontThemeClass().body(context,
                      fontWeight: FontWeight.w500,
                      color: context.colorScheme.secondaryBlackColor),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              SizedBox(
                width: 160.w,
                child: Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: FontThemeClass().caption(context,
                      color: context.colorScheme.secondarySectionColor),
                ),
              ),
            ],
          ),
          const Expanded(child: Text("")),
          TextButton(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: value))
                    .then((value) => showmessage(context, "Copied"));
                // ignore: use_build_context_synchronously
              },
              child: Icon(
                icon,
                size: 26.r,
                color: context.colorScheme.switchColor,
              )),
          SizedBox(
            width: 10.w,
          )
        ],
      ),
    );
  }
}

class SocialLinks extends StatelessWidget {
  final String iconpath;
  final String url;
  const SocialLinks({super.key, required this.iconpath, required this.url});
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          UrlLauncher externalUrlHandler = UrlLauncher();
          externalUrlHandler.launchURL(
            url,
          );
        },
        child: Container(
          width: 47.r,
          height: 47.r,
          decoration: BoxDecoration(
              color: context.colorScheme.secondaryWhiteColor,
              borderRadius: BorderRadius.circular(100)),
          child: Padding(
              padding: const EdgeInsets.all(9).r, child: Image.asset(iconpath)),
        ));
  }
}

class Cetificatation extends StatelessWidget {
  const Cetificatation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 75.h,
      margin: EdgeInsets.only(bottom: 20.r),
      decoration: BoxDecoration(
          color: context.colorScheme.secondaryWhiteColor,
          borderRadius: BorderRadius.circular(20.r)),
      child: Row(
        children: [
          SizedBox(
            width: 25.w,
          ),
          Image.asset(width: 36.w, AssetImagePath.certificateImg),
          SizedBox(
            width: 32.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200.w,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  "Certifications",
                  style: FontThemeClass().body(context,
                      fontWeight: FontWeight.w500,
                      color: context.colorScheme.secondaryBlackColor),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              SizedBox(
                width: 160.w,
                child: Text(
                  LocalStorageService().read('userCertifications'),
                  overflow: TextOverflow.ellipsis,
                  style: FontThemeClass().caption(context,
                      color: context.colorScheme.secondarySectionColor),
                ),
              ),
            ],
          ),
          const Expanded(child: Text("")),
          TextButton(
              onPressed: () async {},
              child: Icon(
                Icons.navigate_next,
                size: 26.r,
                color: context.colorScheme.switchColor,
              )),
          SizedBox(
            width: 10.w,
          )
        ],
      ),
    );
  }
}
