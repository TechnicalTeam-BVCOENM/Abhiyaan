import 'package:abhiyaan/file_exporter.dart';

class SectionText extends StatelessWidget {
  const SectionText({super.key, required this.title, this.showArrow = false, this.height = 18});
  final String title;
  final bool showArrow;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: height, bottom: 8),
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
