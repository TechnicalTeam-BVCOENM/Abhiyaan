import 'package:abhiyaan/file_exporter.dart';

class SocietyCard extends StatelessWidget {
  final String title;
  final String value;
  final String leading;

  const SocietyCard({
    super.key,
    required this.title,
    required this.value,
    required this.leading,
  });

  @override
  Widget build(BuildContext context) {
    FontThemeClass fontThemeClass = FontThemeClass();
    return Card(
      color: context.colorScheme.secondaryWhiteColor,
      shadowColor: context.colorScheme.secondaryLPurpleColor,
      elevation: 2,
      child: Column(
        children: [
          ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            minLeadingWidth: 60.w,
            leading: Image.asset(
              leading,
              scale: 5,
            ),
            title: Text(title,
                style: fontThemeClass.title2(context,
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.primaryDarkColor)),
            subtitle: Text(value,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: fontThemeClass.body(context,
                    color: context.colorScheme.secondaryBlackColor)),
          ),
        ],
      ),
    );
  }
}
