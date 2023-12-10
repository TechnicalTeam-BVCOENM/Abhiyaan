import 'package:darpan/file_exporter.dart';

class SubjectCard extends StatelessWidget {
  final String leading;
  final String title;

  const SubjectCard({
    super.key,
    required this.leading,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 62.h,
      margin: EdgeInsets.only(bottom: 15.w),
      decoration: BoxDecoration(
          color: context.colorScheme.secondaryWhiteColor,
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          SizedBox(
            width: 15.w,
          ),
          Image.asset(width: 32.w, leading),
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
                Icons.navigate_next,
                size: 22,
              )),
        ],
      ),
    );
  }
}
