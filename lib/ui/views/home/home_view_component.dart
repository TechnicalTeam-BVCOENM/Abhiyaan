part of 'home_view.dart';

// Department Updates Card
Container updatesCard(HomeViewModel model, int i, BuildContext context) {
  return Container(
    height: model.departmentUpdates[i].expandedHeight,
    margin: const EdgeInsets.symmetric(vertical: 8),
    width: ResponsiveUtils.screenWidth(context),
    decoration: BoxDecoration(
      color: context.colorScheme.secondaryWhiteColor,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: context.colorScheme.secondaryLPurpleColor.withOpacity(0.7),
        width: 1,
      ),
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
                model.departmentUpdates[i].title,
                style: model.fontTheme.subHeading(context, context.colorScheme.primaryColor),
              ),
              Text(
                "Posted ${DateFormat("MMM d").format((model.departmentUpdates[i].date).toDate())}",
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
                model.departmentUpdates[i].description,
                style: model.fontTheme.smallSubHeading(context),
                maxLines: model.departmentUpdates[i].isExpanded ? model.departmentUpdates[i].maxLines : 2,
                overflow: model.departmentUpdates[i].overflow ? TextOverflow.ellipsis : null,
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
                      model.departmentUpdates[i].isExpanded ? 'Read less' : 'Read more',
                      style: TextStyle(
                        color: context.colorScheme.primaryColor, // You can customize the color
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

// Carousel
class CarouselUtils {
  static Widget buildIndicator(BuildContext context, int activeIndex, int length) => AnimatedSmoothIndicator(
        effect: JumpingDotEffect(
          dotHeight: 8.sp,
          dotWidth: 8.sp,
          dotColor: context.colorScheme.secondarySectionColor,
          activeDotColor: context.colorScheme.primaryColor,
        ),
        activeIndex: activeIndex,
        count: length,
      );

  static Widget buildImage(BuildContext context, String urlImage, int index) => Container(
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

// Quick Links
Row quickLinksList(BuildContext context, List model, [double? borderRadius]) {
  FontThemeClass fontTheme = FontThemeClass();
  return Row(
    children: [
      Expanded(
        child: GridView.builder(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
          ),
          itemCount: model.length,
          itemBuilder: (context, idx) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    debugPrint("Tapped$idx");
                    handleQuickLinksNavigation(model, idx);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    height: 60.sp,
                    width: 60.sp,
                    decoration: BoxDecoration(
                      color: context.colorScheme.secondaryLPurpleColor,
                      borderRadius: BorderRadius.circular(borderRadius ?? 18),
                    ),
                    child: Image.asset(
                      model[idx].imageUrl,
                      width: 36.sp,
                      height: 36.sp,
                    ),
                    // Icon(
                    //   model[idx].icon,
                    //   size: 36.sp,
                    //   color: context.colorScheme.primaryColor,
                    // ),
                  ),
                ),
                Text(
                  model[idx].title,
                  style: fontTheme.smallSubHeading(
                    context,
                    context.colorScheme.primaryDarkColor,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ],
  );
}
