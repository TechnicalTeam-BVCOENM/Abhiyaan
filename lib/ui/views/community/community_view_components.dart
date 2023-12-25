part of "community_view.dart";

// Higlights component
// 1. Use Card Component for each highlight
// 2. Use same logic as Home page for the card component
class CommunityBlogs extends ViewModelWidget<CommunityViewModel> {
  final CommunityBlogsData blogsData;
  const CommunityBlogs({super.key, required this.blogsData});

  @override
  Widget build(BuildContext context, CommunityViewModel viewModel) {
    FontThemeClass fontThemeClass = FontThemeClass();
    DateTime postDate = blogsData.date.toDate();
    DateTime currentDate = DateTime.now().toLocal();
    currentDate =
        DateTime(currentDate.year, currentDate.month, currentDate.day);
    postDate = DateTime(postDate.year, postDate.month, postDate.day);

    String actualPostTime = currentDate.difference(postDate).inDays == 0
        ? "Posted Today"
        : currentDate.difference(postDate).inDays == 1
            ? "Posted Yesterday"
            : "Posted ${currentDate.difference(postDate).inDays} days ago";

    // Future<bool> toggleLike() async {
    //   isLiked = await viewModel.isUserAlreadyLikedPost(blogsData.documentId);
    //   viewModel.notifyListeners();
    //   return isLiked;
    // }

    return StreamBuilder<int>(
        stream: viewModel.getLikesStream(blogsData.documentId),
        builder: (context, snapshot) {
          if (viewModel.hasError) {
            return const Text('Error: Backend Error');
          }
          bool isLiked = viewModel.localStorageService
                  .read("isLiked_${blogsData.documentId}") ??
              false;

          final int streamLikes = snapshot.data ?? 0;
          return Card(
            elevation: 1,
            shadowColor:
                context.colorScheme.secondaryBlackColor.withOpacity(0.8),
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 45.h,
                  padding: const EdgeInsets.symmetric(horizontal: 12).r,
                  decoration: BoxDecoration(
                    color: context.colorScheme.secondaryWhiteColor,
                  ),
                  child: Row(
                    children: [
                      //Author image
                      ClipOval(
                        child: Image.network(
                          "https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671142.jpg?size=338&ext=jpg&ga=GA1.1.1546980028.1703289600&semt=ais",
                          width: 34.w,
                          height: 34.h,
                        ),
                      ).animate(delay: 500.ms).fadeIn(delay: 10.ms),
                      //Author name
                      8.horizontalSpace,
                      Text(
                        blogsData.author,
                        style: fontThemeClass.caption(context,
                            color: context.colorScheme.secondaryBlackColor,
                            fontWeight: FontWeight.w500),
                      ).animate(delay: 500.ms).slide(delay: 10.ms).fadeIn(),
                      const Spacer(),
                      //Posted on date
                      Text(
                        actualPostTime,
                        style: fontThemeClass.caption(context,
                            color: context.colorScheme.secondarySectionColor,
                            fontWeight: FontWeight.w400),
                      ).animate(delay: 500.ms).slide(delay: 10.ms).fadeIn(),
                    ],
                  ),
                ),
                CachedNetworkImageWidget(
                  imageUrl: blogsData.imageUrl,
                  height: 170.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  maxHeightDiskCache: 1600.h,
                ).animate(delay: 100.ms).fadeIn(),
                Container(
                    height: 45.h,
                    padding: const EdgeInsets.symmetric(horizontal: 12).r,
                    decoration: BoxDecoration(
                      color: context.colorScheme.secondaryWhiteColor,
                    ),
                    child: Row(
                      children: [
                        Image.network(
                          "https://cdn3d.iconscout.com/3d/premium/thumb/bulb-3994347-3307681.png?f=webp",
                          height: 25.h,
                          width: 25.w,
                          fit: BoxFit.cover,
                        ).animate(delay: 500.ms).scale(),
                        8.horizontalSpace,
                        Text(
                          blogsData.title,
                          style: fontThemeClass.caption(context,
                              color: context.colorScheme.secondaryBlackColor,
                              fontWeight: FontWeight.w500),
                        ).animate(delay: 500.ms).scale(),
                        const Spacer(),
                        Text(
                          streamLikes.toString(),
                          style: fontThemeClass.caption(context,
                              color: context.colorScheme.secondaryBlackColor,
                              fontWeight: FontWeight.w500),
                        ).animate(delay: 500.ms).scale(),
                        4.horizontalSpace,
                        InkWell(
                          onTap: () {
                            viewModel.updateLikes(blogsData.documentId);
                          },
                          child: isLiked
                              ? const Icon(
                                  Icons.favorite_rounded,
                                  color: Colors.red,
                                  shadows: [
                                    BoxShadow(
                                      color: Colors.red,
                                      blurRadius: 7,
                                      spreadRadius: 0.8,
                                    ),
                                  ],
                                  fill: 1,
                                  size: 25,
                                ).animate(delay: 500.ms).scale()
                              : const Icon(
                                  Icons.favorite_border_rounded,
                                  color: Colors.black,
                                  fill: 0,
                                  size: 25,
                                ).animate(delay: 500.ms).scale(),
                        )
                      ],
                    )),
              ],
            ),
          );
        });
  }
}

// Departmental Clubs
// 1. Use Card Component for each club
// 2. Must be carousel like upcoming events

// Qoute of the day
// 1. Use Card Component for a quote of the day

class QuoteCard extends StatelessWidget {
  final String? quote;
  final String? autherName;

  const QuoteCard({super.key, this.quote, this.autherName});

  @override
  Widget build(BuildContext context) {
    FontThemeClass fontThemeClass = FontThemeClass();
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF2F80ED),
              Color(0xFF56CCF2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Transform.flip(
                flipY: true,
                flipX: true,
                child: const Icon(
                  Icons.format_quote,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ).animate(delay: 600.ms).scale(),
            Text(
              '" $quote "',
              style: fontThemeClass.paragraph(context,
                  fontWeight: FontWeight.w700,
                  color: context.colorScheme.signInTextColor),
              textAlign: TextAlign.center,
            ).animate(delay: 700.ms).scale(),
            15.verticalSpace,
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                "- $autherName", // Replace 'Author Name' with the actual author's name
                style: fontThemeClass.body(context,
                    color: context.colorScheme.signInTextColor,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.right,
              ),
            ).animate(delay: 800.ms).scale(),
            15.verticalSpace,
          ],
        ),
      ),
    ).animate(delay: 500.ms).fadeIn();
  }
}

// Community page Shimmer Effect
class CommunityPageShimmerEffect extends StatelessWidget {
  const CommunityPageShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.backgroundColor,
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 18).r,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 34.h,
                width: 250.w,
                child: const ShimmerLoadingWidget(),
              ),
              4.verticalSpace,
              const SectionTextShimmerEffect(),
              8.verticalSpace,
              SizedBox(
                height: 270.h,
                child: const Card(
                  child: ShimmerLoadingWidget(),
                ),
              ),
              12.verticalSpace,
              const SectionTextShimmerEffect(),
              8.verticalSpace,
              SizedBox(
                height: 120.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.only(right: index == 2 ? 0 : 16).r,
                    height: 120.h,
                    width: 120.w,
                    child: const Card(
                      child: ShimmerLoadingWidget(),
                    ),
                  ),
                ),
              ),
              12.verticalSpace,
              const SectionTextShimmerEffect(),
              8.verticalSpace,
              SizedBox(
                height: 220.h,
                child: const Card(
                  child: ShimmerLoadingWidget(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
