import 'package:abhiyaan/file_exporter.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;

  const ShimmerLoadingWidget({super.key, this.height, this.width, this.radius});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.colorScheme.backgroundColor,
      highlightColor: context.colorScheme.secondaryLPurpleColor,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 18.sp),
          color: Colors.white,
        ),
        width: width ?? double.infinity,
        height: height ?? double.infinity, // Adjust the height as needed
      ),
    );
  }
}

class SectionTextShimmerEffect extends StatelessWidget {
  const SectionTextShimmerEffect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 18, bottom: 8).r,
      child: Row(
        children: [
          ShimmerLoadingWidget(
            width: 180.w,
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
