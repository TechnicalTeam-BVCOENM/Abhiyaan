import 'package:cached_network_image/cached_network_image.dart';
import '../../file_exporter.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final double maxHeightDiskCache;
  final BoxFit fit;

  const CachedNetworkImageWidget({
    super.key,
    required this.imageUrl,
    required this.height,
    required this.width,
    required this.maxHeightDiskCache,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      height: height,
      width: width,
      maxHeightDiskCache: maxHeightDiskCache.toInt(),
      // placeholder: (context, url) => CircularLoadingIndicator(height: 90.sp),
      progressIndicatorBuilder: (context, url, downloadProgress) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: CircularProgressIndicator.adaptive(
          value: downloadProgress.progress,
        )),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}

Container horizontalStoryRow(
    BuildContext context, List model, double borderRadius) {
  FontThemeClass fontTheme = FontThemeClass();
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 4),
    height: 120.sp,
    width: MediaQuery.of(context).size.width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: model.length,
            itemBuilder: (context, idx) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      debugPrint("Tapped$idx");
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                      height: 80.sp,
                      width: 80.sp,
                      decoration: BoxDecoration(
                        color: context.colorScheme.secondarySectionColor,
                        borderRadius: BorderRadius.circular(borderRadius),
                        image: DecorationImage(
                          image: NetworkImage(
                            model[idx].imageUrl,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    model[idx].title,
                    style: fontTheme.title2(
                      context,
                      color: context.colorScheme.secondaryBlackColor,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    ),
  );
}
