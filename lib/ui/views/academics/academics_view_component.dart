import 'package:darpan/file_exporter.dart';
import 'package:shimmer/shimmer.dart';

class AcademicsShimmerLoadingWidget extends StatelessWidget {
  const AcademicsShimmerLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.r),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        scrollBehavior:
            const MaterialScrollBehavior().copyWith(overscroll: false),
        slivers: [
          SliverToBoxAdapter(
            child: 16.verticalSpace,
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 16.r,
              crossAxisSpacing: 16.r,
            ),
            delegate: SliverChildBuilderDelegate(
              childCount: 9,
              (BuildContext context, int index) {
                return Shimmer.fromColors(
                  baseColor: context.colorScheme.backgroundColor,
                  highlightColor: context.colorScheme.secondaryLPurpleColor,
                  child: Container(
                    width: 98.r,
                    height: 98.r,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: 62.verticalSpace,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 3,
              (BuildContext context, int index) {
                return Shimmer.fromColors(
                  baseColor: context.colorScheme.backgroundColor,
                  highlightColor: context.colorScheme.secondaryLPurpleColor,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 12.r),
                    width: double.infinity,
                    height: 120.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
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
