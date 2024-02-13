import 'package:abhiyaan/ui/common/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:intl/intl.dart';
import 'package:abhiyaan/file_exporter.dart';

Widget updatesCard(List updateList, int i, BuildContext context, viewModel) {
  FontThemeClass fontTheme = FontThemeClass();
  return ExpandableNotifier(
    initialExpanded: false,
    child: Expandable(
      collapsed: Card(
        margin: const EdgeInsets.only(bottom: 8).r,
        color: context.colorScheme.primaryCardColor,
        elevation: 0,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16).r,
          side: BorderSide(
            color: context.colorScheme.secondaryPurpleColor,
            width: 1.w,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0).r,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CardTitle(title: updateList[i].title),
                  CardDate(date: updateList[i].date),
                ],
              ),
              2.verticalSpace,
              CollapsedDescription(description: updateList[i].description),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: ExpandableButton(
                      child: Text(
                        "Read More",
                        style: fontTheme.body(
                          context,
                          color: context.colorScheme.switchColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      expanded: Card(
        margin: const EdgeInsets.only(bottom: 8).r,
        color: context.colorScheme.primaryCardColor,
        elevation: 0,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16).r,
          side: BorderSide(
            color: context.colorScheme.secondaryPurpleColor,
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
                  CardTitle(title: updateList[i].title),
                  CardDate(date: updateList[i].date),
                ],
              ),
              2.verticalSpace,
              ExpandedDescription(
                description: updateList[i].description,
                url: updateList[i].url,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ExpandableButton(
                    child: Text(
                      "Read Less",
                      style: fontTheme.body(
                        context,
                        color: context.colorScheme.switchColor,
                      ),
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

class CollapsedDescription extends StatelessWidget {
  final String description;
  const CollapsedDescription({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    FontThemeClass fontTheme = FontThemeClass();
    return Text(
      description,
      maxLines: 2,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.justify,
      style: fontTheme.caption(
        context,
        color: context.colorScheme.primaryTextColor.withOpacity(0.6),
      ),
    );
  }
}

class ExpandedDescription extends StatelessWidget {
  final String description;
  final String url;
  const ExpandedDescription({
    super.key,
    required this.description,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    FontThemeClass fontTheme = FontThemeClass();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          description,
          maxLines: 100,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.justify,
          style: fontTheme.caption(
            context,
            color: context.colorScheme.primaryTextColor.withOpacity(0.6),
          ),
        ),
        4.verticalSpace,
        Visibility(
          visible: url.isNotEmpty || url != "",
          child: Row(
            children: [
              const Text("For more details :-\t"),
              2.horizontalSpace,
              GestureDetector(
                onTap: () {
                  UrlLauncher().launchURL(url);
                },
                child: Text(
                  url.split("/").last,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: fontTheme.caption(
                    context,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CardDate extends StatelessWidget {
  final Timestamp date;
  const CardDate({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    FontThemeClass fontTheme = FontThemeClass();

    return Text(
      "Posted ${DateFormat("MMM d").format((date).toDate())}",
      style: fontTheme.caption(
        context,
        color: context.colorScheme.secondaryTextColor,
      ),
    );
  }
}

class CardTitle extends StatelessWidget {
  final String title;
  const CardTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    FontThemeClass fontTheme = FontThemeClass();

    return Expanded(
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: fontTheme.body(
          context,
          color: context.colorScheme.switchColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
