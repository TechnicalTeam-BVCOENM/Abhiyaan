import 'package:abhiyaan/file_exporter.dart';

class SectionText extends StatelessWidget {
  const SectionText({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 18, bottom: 8),
      child: Text(
        title,
        style: FontThemeClass().body(context,
            color: context.colorScheme.secondarySectionColor,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
