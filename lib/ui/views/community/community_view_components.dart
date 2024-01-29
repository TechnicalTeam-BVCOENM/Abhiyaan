part of "community_view.dart";

final AnalyticsService _analyticsService = locator<AnalyticsService>();

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
                      ClipOval(
                        child: blogsData.authorImageUrl != ''
                            ? CachedNetworkImage(
                                imageUrl: blogsData.authorImageUrl,
                                width: 34.w,
                                height: 34.h,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                AssetImagePath.emptyPerson,
                                width: 34.w,
                                height: 34.h,
                              ),
                      ).animate(delay: 500.ms).fadeIn(delay: 10.ms),
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
                Hero(
                  transitionOnUserGestures: true,
                  tag: blogsData.documentId,
                  child: CachedNetworkImageWidget(
                    imageUrl: blogsData.imageUrl,
                    height: 170.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    maxHeightDiskCache: 1600.h,
                  ),
                ),
                Container(
                    height: 45.h,
                    padding: const EdgeInsets.symmetric(horizontal: 12).r,
                    decoration: BoxDecoration(
                      color: context.colorScheme.secondaryWhiteColor,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          AssetImagePath.bulb,
                          height: 25.h,
                          width: 25.w,
                          fit: BoxFit.cover,
                        ).animate(delay: 500.ms).scale(),
                        8.horizontalSpace,
                        Hero(
                          tag: blogsData.title,
                          child: Text(
                            blogsData.title,
                            style: fontThemeClass.caption(context,
                                color: context.colorScheme.secondaryBlackColor,
                                fontWeight: FontWeight.w500),
                          ).animate(delay: 500.ms).scale(),
                        ),
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
                            viewModel.updateLikes(
                                blogsData.documentId, context);
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

class DepartmentClubs extends ViewModelWidget<CommunityViewModel> {
  final DepartmentalClubsData data;
  const DepartmentClubs({super.key, required this.data});

  @override
  Widget build(BuildContext context, CommunityViewModel viewModel) {
    FontThemeClass fontThemeClass = FontThemeClass();
    return Padding(
      padding: const EdgeInsets.only(right: 10).r,
      child: GestureDetector(
        onTap: () {
          _analyticsService.logEvent(
              eventName: "Departmental_Club_View",
              value: "${data.clubShortHand} Club Viewed");
          viewModel.navigationService.navigateToClubsView(clubsData: data);
        },
        child: SizedBox(
          height: 120.h,
          width: 120.w,
          child: Card(
            clipBehavior: Clip.hardEdge,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: data.clubImage,
                  height: 80.h,
                  width: 120.w,
                  fit: BoxFit.fitHeight,
                  maxHeightDiskCache: 200,
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      height: 80.h,
                      width: 120.w,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  height: 30.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                    color: context.colorScheme.secondaryWhiteColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.bookmark_rounded,
                          color:
                              context.colorScheme.primaryColor.withOpacity(0.8),
                          size: 18.sp),
                      12.horizontalSpace,
                      Center(
                        child: Text(
                          data.clubShortHand,
                          style: fontThemeClass.caption(context,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ].animate(delay: 300.ms).fadeIn(),
            ),
          ),
        ),
      ),
    );
  }
}

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
              quote == ''
                  ? "Education for us is not a matter of degree, but of life."
                  : ' $quote ',
              style: fontThemeClass.paragraph(context,
                  fontWeight: FontWeight.w700,
                  color: context.colorScheme.signInTextColor),
              textAlign: TextAlign.center,
            ).animate(delay: 700.ms).scale(),
            15.verticalSpace,
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                autherName == '' ? "- John Ruskin" : "- $autherName",
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
