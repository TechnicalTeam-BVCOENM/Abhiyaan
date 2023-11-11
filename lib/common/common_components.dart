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

Container horizontalStoryRow(
    BuildContext context, List model, double borderRadius) {
  FontThemeClass fontTheme = FontThemeClass();
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 4),
    height: 120.hWise,
    width: MediaQuery.of(context).size.width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: model.length,
            itemBuilder: (context, idx) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      debugPrint("Tapped$idx");
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                      height: 80.hWise,
                      width: 80.wWise,
                      decoration: BoxDecoration(
                        color: context.colorScheme.secondarySectionColor,
                        borderRadius: BorderRadius.circular(borderRadius),
                        image: DecorationImage(
                          image: NetworkImage(
                            model[idx].imageUrl,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    model[idx].title,
                    style: fontTheme.smallSubHeading(
                      context,
                      context.colorScheme.secondaryBlackColor,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    ),
  );
}
