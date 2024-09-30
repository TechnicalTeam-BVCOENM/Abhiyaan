import 'package:abhiyaan/file_exporter.dart';

class SectionText extends StatelessWidget {
  const SectionText({super.key, required this.title, this.showArrow = false});
  final String title;
  final bool showArrow;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 18, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: FontThemeClass().body(
              context,
              color: context.colorScheme.primaryText,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (showArrow)
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16.w,
            )
        ],
      ),
    );
  }
}
