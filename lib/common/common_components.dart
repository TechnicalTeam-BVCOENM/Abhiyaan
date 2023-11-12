import '../file_exporter.dart';
import 'package:darpan/utils/extension.dart';

class SectionText extends StatelessWidget {
  const SectionText({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 18, bottom: 8),
      child: Text(
        title,
        style: FontThemeClass().subHeading2(
          context,
          context.colorScheme.secondarySectionColor,
        ),
      ),
    );
  }
}

void showmessage(context, String message) {
  try {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 500),
      backgroundColor: Theme.of(context).colorScheme.backgroundColor,
      content: Container(
        width: 200.wWise,
        height: 40.hWise,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryLPurpleColor,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            message,
            style: FontThemeClass().subHeading(
                context, Theme.of(context).colorScheme.secondaryBlackColor),
          ),
        ),
      ),
    ));
  } catch (e) {
    for (var i = 0; i < 100; i++) {
      debugPrint("error is $e");
    }
  }
}
