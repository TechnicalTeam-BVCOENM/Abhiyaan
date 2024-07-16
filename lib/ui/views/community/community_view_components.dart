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
          shadowColor: context.colorScheme.card.withOpacity(0.8),
          color: context.colorScheme.card,
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
                  color: context.colorScheme.card,
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
                      style: fontThemeClass.caption(
                        context,
                        color: context.colorScheme.primaryText,
                        fontWeight: FontWeight.w500,
                      ),
                    ).animate(delay: 500.ms).slide(delay: 10.ms).fadeIn(),
                    const Spacer(),
                    //Posted on date
                    Text(
                      actualPostTime,
                      style: fontThemeClass.caption(
                        context,
                        color: context.colorScheme.secondaryText,
                        fontWeight: FontWeight.w400,
                      ),
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
                  color: context.colorScheme.card,
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
                      child: SizedBox(
                        width: ResponsiveUtils.screenWidth(context) * 0.65,
                        child: Text(
                          blogsData.title,
                          overflow: TextOverflow.ellipsis,
                          style: fontThemeClass.caption(
                            context,
                            color: context.colorScheme.primaryText,
                            fontWeight: FontWeight.w500,
                          ),
                        ).animate(delay: 500.ms).scale(),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      streamLikes.toString(),
                      style: fontThemeClass.caption(
                        context,
                        color: context.colorScheme.primaryText,
                        fontWeight: FontWeight.w500,
                      ),
                    ).animate(delay: 500.ms).scale(),
                    4.horizontalSpace,
                    InkWell(
                      onTap: () {
                        viewModel.updateLikes(blogsData.documentId, context);
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
                ),
              ),
            ],
          ),
        );
      },
    );
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
                Hero(
                  tag: data.clubShortHand,
                  child: CachedNetworkImage(
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
                ),
                Container(
                  height: 30.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                    color: context.colorScheme.card,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.bookmark_rounded,
                        color: context.colorScheme.accentColor,
                        size: 18.sp,
                      ),
                      4.horizontalSpace,
                      Center(
                        child: Text(
                          data.clubShortHand,
                          style: fontThemeClass.caption(
                            context,
                            fontWeight: FontWeight.w500,
                          ),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        15.verticalSpace,
        Container(
          width: double.maxFinite,
          alignment: Alignment.centerLeft,
          child: Center(
            child: Transform.flip(
              flipY: true,
              flipX: true,
              child:  Icon(
                Icons.format_quote_outlined,
                color: context.colorScheme.darkScaffold,
                size: 40,
              ),
            ),
          ),
        ).animate(delay: 600.ms).scale(),
        Text(
          quote == ''
              ? "Education for us is not a matter of degree, but of life."
              : ' $quote ',
          style: fontThemeClass.body(
            context,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ).animate(delay: 700.ms).scale(),
        15.verticalSpace,
        Container(
          alignment: Alignment.centerRight,
          child: Text(
            autherName == '' ? "- John Ruskin" : "- $autherName",
            style: fontThemeClass.caption(
              context,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.right,
          ),
        ).animate(delay: 800.ms).scale(),
        15.verticalSpace,
      ],
    ).animate(delay: 500.ms).fadeIn();
  }
}
