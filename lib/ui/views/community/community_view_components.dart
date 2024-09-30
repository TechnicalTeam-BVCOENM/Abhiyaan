part of "community_view.dart";

// final AnalyticsService _analyticsService = locator<AnalyticsService>();

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

class ClubsViewWidget extends ViewModelWidget<CommunityViewModel> {
  final ClubsDataModel data;
  const ClubsViewWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context, CommunityViewModel viewModel) {
    final font = FontThemeClass();
    return GestureDetector(
      onTap: () {
        viewModel.navigationService.navigateToClubsView(clubsData: data);
      },
      child: SizedBox(
        width: 248.w,
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30).r,
            ),
            elevation: 0.1,
            color: context.colorScheme.card,
            child: Padding(
              padding: const EdgeInsets.all(8.0).r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(2.0).r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color:
                            context.colorScheme.secondaryText.withOpacity(0.1),
                        width: 2,
                      ),
                    ),
                    child: Stack(
                      children: [
                        ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: data.clubImage,
                            height: 65.h,
                            width: 65.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: SvgPicture.asset(
                            "assets/images/community/verified.svg",
                            height: 16.h,
                            width: 16.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                  10.horizontalSpace,
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          data.clubShortHand,
                          style: font.body(
                            context,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          data.clubName,
                          maxLines: 4,
                          overflow: TextOverflow.clip,
                          style: font.small(
                            context,
                            color: context.colorScheme.secondaryText
                                .withOpacity(0.7),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
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
              child: Icon(
                Icons.format_quote_outlined,
                color: context.colorScheme.primary,
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

class CommunityInviteCard extends ViewModelWidget<CommunityViewModel> {
  const CommunityInviteCard({
    super.key,
  });

  @override
  Widget build(BuildContext context, CommunityViewModel viewModel) {
    final font = FontThemeClass();
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 0.1,
      color: context.colorScheme.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20).r,
      ),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(14).r,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Want to know more about us ?",
                  style: font.body(
                    context,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                8.verticalSpace,
                Text(
                  "Join our community of practical learners. Build skills, solve problems.",
                  style: font.small(
                    context,
                    color: context.colorScheme.secondaryText.withOpacity(0.5),
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                24.verticalSpace,
                SizedBox(
                  width: double.infinity,
                  height: 34.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          viewModel.joinCommunity();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.colorScheme.accentColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20).r,
                          ),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/images/community/whatsapp.svg",
                              height: 20.h,
                              width: 20.w,
                            ),
                            8.horizontalSpace,
                            Text(
                              "Join Community",
                              style: font.caption(
                                context,
                                fontWeight: FontWeight.w700,
                                color: context.colorScheme.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          viewModel.shareCommunity();
                        },
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(
                            color: context.colorScheme.accentColor,
                            width: 1.5.w,
                          ),
                          backgroundColor: context.colorScheme.card,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20).r,
                          ),
                        ),
                        child: Text(
                          "Share",
                          style: font.caption(
                            context,
                            fontWeight: FontWeight.w700,
                            color: context.colorScheme.primaryText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 10,
            bottom: MediaQuery.of(context).size.height * 0.045,
            child: Transform.rotate(
              angle: 0.4,
              child: const CustomAvatar(
                  image: "assets/images/community/avatars/avtr1.jpg"),
            ),
          ),
          Positioned(
            left: 14,
            top: MediaQuery.of(context).size.height * 0.012,
            child: Transform.rotate(
              angle: 0.4,
              child: const CustomAvatar(
                  image: "assets/images/community/avatars/avtr2.jpg"),
            ),
          ),
          Positioned(
            left: 80,
            bottom: MediaQuery.of(context).size.height * 0.062,
            height: 24.h,
            width: 24.w,
            child: const CustomAvatar(
                image: "assets/images/community/avatars/avtr3.jpg"),
          ),
          Positioned(
            right: 24,
            top: MediaQuery.of(context).size.height * 0.01,
            child: const CustomAvatar(
                image: "assets/images/community/avatars/avtr4.jpg"),
          ),
        ],
      ),
    );
  }
}

class CustomAvatar extends StatelessWidget {
  final String image;
  const CustomAvatar({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.asset(
        image,
        width: 28.w,
        height: 28.h,
      ),
    );
  }
}
