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
      height: 100.h,
      margin: const EdgeInsets.only(bottom: 20).r,
      decoration: BoxDecoration(
          color: context.colorScheme.secondaryWhiteColor,
          borderRadius: BorderRadius.circular(20).r),
      child: Row(
        children: [
          SizedBox(
            width: 15.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               SizedBox(
                height: 4.h,
              ),
              Text(
                title,
                style: FontThemeClass()
                    .subHeading(context, context.colorScheme.primaryColor),
              ),
               SizedBox(
                height: 4.h,
              ),
              SizedBox(
                width: 270.w,
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
               SizedBox(
                height: 8.h,
              ),
            ],
          ),
          const Expanded(child: Text("")),
          Image.asset(width: 80.w, leading),
          SizedBox(
            width: 15.w,
          ),
        ],
      ),
    );
  }
}
