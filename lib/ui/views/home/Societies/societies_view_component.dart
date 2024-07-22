import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/ui/common/url_launcher.dart';

class SocietyCard extends StatelessWidget {
  final String title;
  final String value;
  final String leading;
  final String url;

  const SocietyCard({
    super.key,
    required this.title,
    required this.value,
    required this.leading,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    FontThemeClass fontThemeClass = FontThemeClass();
    return GestureDetector(
      onTap: () {
        UrlLauncher().launchURL(url);
      },
      child: Card(
        color: context.colorScheme.card,
        shadowColor: context.colorScheme.card.withOpacity(0.5),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  leading,
                  height: 80.h,
                  width: 80.w,
                ),
              ),
              2.verticalSpace,
              Center(
                child: Text(
                  title,
                  style: fontThemeClass.body(
                    context,
                    color: context.colorScheme.primaryText,
                  ),
                ),
              ),
              12.verticalSpace,
              Text(
                value,
                style: fontThemeClass.small(
                  context,
                  color: context.colorScheme.secondaryText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
