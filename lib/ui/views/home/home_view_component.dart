import 'package:darpan/file_exporter.dart';
import 'package:darpan/utils/extension.dart';

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
