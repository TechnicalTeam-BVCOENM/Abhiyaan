import 'package:darpan/file_exporter.dart';
import 'package:darpan/utils/extension.dart';

part of 'home_view.dart';

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

class CarouselUtils {
  static Widget buildIndicator(
          BuildContext context, int activeIndex, int length) =>
      AnimatedSmoothIndicator(
        effect: JumpingDotEffect(

          dotHeight: 8.hWise,
          dotWidth: 8.wWise,

          dotColor: context.colorScheme.secondarySectionColor,
          activeDotColor: context.colorScheme.primaryColor,
        ),
        activeIndex: activeIndex,
        count: length,
      );

  static Widget buildImage(BuildContext context, String urlImage, int index) =>
      Container(
        width: MediaQuery.of(context).size.width * 1,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              CachedNetworkImageWidget(
                imageUrl: urlImage,
                height: 1500,
                width: 350,
                maxHeightDiskCache: 1500,
                fit: BoxFit.cover,

              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.4),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
