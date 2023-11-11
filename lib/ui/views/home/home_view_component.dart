import 'package:darpan/utils/extension.dart';
import '../../../file_exporter.dart';
import '../../../theme/responsive_utils.dart';
import 'home_view.dart';

Container updatesCard(HomeViewModel model, int i, BuildContext context) {
  return Container(
    height: model.departmentUpdatesList[i].expandedHeight,
    margin: const EdgeInsets.symmetric(vertical: 8),
    width: ResponsiveUtils.screenWidth(context),
    decoration: BoxDecoration(
      color: context.colorScheme.secondaryWhiteColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        // Card Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                model.departmentUpdatesList[i].name,
                style: model.fontTheme
                    .subHeading(context, context.colorScheme.primaryColor),
              ),
              Text(
                "Posted ${model.departmentUpdatesList[i].date}",
                style: model.fontTheme.smallSubHeading(context),
              ),
            ],
          ),
        ),
        // Card Body
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Card Body Text
              Text(
                model.departmentUpdatesList[i].description,
                style: model.fontTheme.smallSubHeading(context),
                maxLines: model.departmentUpdatesList[i].isExpanded
                    ? model.departmentUpdatesList[i].maxLines
                    : 2,
                overflow: model.departmentUpdatesList[i].overflow
                    ? TextOverflow.ellipsis
                    : null,
              ),
              // Show more/less button
              InkWell(
                onTap: () {
                  model.toggleExpand(i);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      model.departmentUpdatesList[i].isExpanded
                          ? 'Read less'
                          : 'Read more',
                      style: TextStyle(
                        color: context.colorScheme
                            .primaryColor, // You can customize the color
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

