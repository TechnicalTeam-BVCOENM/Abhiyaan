import 'package:expandable/expandable.dart';
import 'package:intl/intl.dart';
import 'package:darpan/file_exporter.dart';

Widget updatesCard(List updateList, int i, BuildContext context, viewModel) {
  return ExpandableNotifier(
    initialExpanded: false,
    child: Expandable(
      collapsed: Card(
        margin: const EdgeInsets.only(bottom: 8),
        elevation: 0,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: context.colorScheme.secondaryLPurpleColor,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    updateList[i].title,
                    style: FontThemeClass().subHeading(context, context.colorScheme.primaryColor),
                  ),
                  Text(
                    "Posted ${DateFormat("MMM d").format((updateList[i].date).toDate())}",
                    style: FontThemeClass().smallSubHeading(context),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Text(
                updateList[i].description,
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ExpandableButton(
                    child: Text(
                      "Read More",
                      style: FontThemeClass().smallSubHeading(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      expanded: Card(
        margin: const EdgeInsets.only(bottom: 8),
        elevation: 0,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: context.colorScheme.secondaryLPurpleColor,
            width: 1.w,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    updateList[i].title,
                    style: FontThemeClass().subHeading(context, context.colorScheme.primaryColor),
                  ),
                  Text(
                    "Posted ${DateFormat("MMM d").format((updateList[i].date).toDate())}",
                    style: FontThemeClass().smallSubHeading(context),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Text(
                updateList[i].description,
                maxLines: 100,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ExpandableButton(
                    child: Text(
                      "Read Less",
                      style: FontThemeClass().smallSubHeading(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
