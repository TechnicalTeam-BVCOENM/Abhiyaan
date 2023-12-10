import 'package:darpan/file_exporter.dart';
import 'package:shimmer/shimmer.dart';

class AcademicsShimmerLoadingWidget extends StatelessWidget {
  const AcademicsShimmerLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        scrollBehavior:
            const MaterialScrollBehavior().copyWith(overscroll: false),
        slivers: [
          SliverToBoxAdapter(
            child: 16.verticalSpace,
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
            ),
            delegate: SliverChildBuilderDelegate(
              childCount: 9,
              (BuildContext context, int index) {
                return Shimmer.fromColors(
                  baseColor: context.colorScheme.backgroundColor,
                  highlightColor: context.colorScheme.secondaryLPurpleColor,
                  child: Container(
                    width: 90.r,
                    height: 90.r,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: 60.verticalSpace,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 3,
              (BuildContext context, int index) {
                return Shimmer.fromColors(
                  baseColor: context.colorScheme.backgroundColor,
                  highlightColor: context.colorScheme.secondaryLPurpleColor,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    width: double.infinity,
                    height: 80.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: 8.verticalSpace,
          ),
        ],
      ),
    );
  }
}
