import 'package:darpan/file_exporter.dart';

class SubjectCard extends StatelessWidget {
  final String title;

  const SubjectCard({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70.h,
      margin: EdgeInsets.only(bottom: 25.w),
      decoration: BoxDecoration(
          color: context.colorScheme.secondaryLPurpleColor,
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          SizedBox(
            width: 15.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: FontThemeClass().subHeading(
                    context, context.colorScheme.secondaryBlackColor),
              ),
            ],
          ),
          const Expanded(child: Text("")),
          TextButton(
              onPressed: () {
                //navigate
                // navigateToSettingsView
              },
              child: const Icon(
                Icons.navigate_next_rounded,
                size: 22,
              )),
        ],
      ),
    );
  }
}
