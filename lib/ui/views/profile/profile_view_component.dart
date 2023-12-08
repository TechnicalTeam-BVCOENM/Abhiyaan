import 'package:darpan/common/common_component_model.dart';
import 'package:flutter/services.dart';
import 'package:darpan/file_exporter.dart';
import '../../../common/toast_message.dart';

class ProfileDetailsCard extends StatelessWidget {
  final String leading;
  final String title;
  final String value;

  const ProfileDetailsCard({
    super.key,
    required this.leading,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 62.sp,
      margin: EdgeInsets.only(bottom: 15.sp),
      decoration: BoxDecoration(
          color: context.colorScheme.secondaryWhiteColor,
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          SizedBox(
            width: 25.sp,
          ),
          Image.asset(width: 30.sp, leading),
          SizedBox(
            width: 32.sp,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: FontThemeClass().heading4(context),
              ),
              const SizedBox(
                height: 4,
              ),
              SizedBox(
                width: 160,
                child: Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: FontThemeClass().smallSubHeading(
                      context, context.colorScheme.secondarySectionColor),
                ),
              ),
            ],
          ),
          const Expanded(child: Text("")),
          TextButton(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: value));
                // ignore: use_build_context_synchronously
                showmessage(context, "Copied");
              },
              child: Image.asset(width: 18, AssetImagePath.copyImg)),
          const SizedBox(
            width: 10,
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
            Uri.parse(url),
          );
        },
        child: Container(
          width: 45.sp,
          height: 45.sp,
          decoration: BoxDecoration(
              color: context.colorScheme.secondaryWhiteColor,
              borderRadius: BorderRadius.circular(100)),
          child: Padding(
              padding: const EdgeInsets.all(5), child: Image.asset(iconpath)),
        ));
  }
}
