import 'package:darpan/file_exporter.dart';

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
    return Container(
      width: double.infinity,
      height: 70.h,
      margin: EdgeInsets.only(bottom: 15.w),
      decoration: BoxDecoration(
          color: context.colorScheme.secondaryWhiteColor,
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
                style: FontThemeClass()
                    .subHeading(context, context.colorScheme.primaryColor),
              ),
              const SizedBox(
                height: 4,
              ),
              SizedBox(
                width: 200.w,
                child: Text(
                  value,
                  maxLines: 3,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                  style: FontThemeClass().smallSubHeading(
                      context, context.colorScheme.secondarySectionColor),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
            ],
          ),
          const Expanded(child: Text("")),
          Image.asset(width: 50.w, leading),
          SizedBox(
            width: 15.w,
          ),
        ],
      ),
    );
  }
}
