import '../../file_exporter.dart';

// Section Name Text
class SectionText extends StatelessWidget {
  const SectionText({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 18, bottom: 8),
      child: Text(
        title,
        style: FontThemeClass().title2(
          context,
          context.colorScheme.secondarySectionColor,
        ),
      ),
    );
  }
}
