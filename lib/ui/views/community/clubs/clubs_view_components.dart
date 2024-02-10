part of '../clubs/clubs_view.dart';

class ClubsAppBar extends ViewModelWidget<ClubsViewModel> {
  final String clubShortHand;
  const ClubsAppBar({super.key, required this.clubShortHand});

  @override
  Widget build(BuildContext context, ClubsViewModel viewModel) {
    return SliverAppBar(
      iconTheme: IconThemeData(
        color: context.colorScheme.primaryTextColor, //change your color here
      ),
      elevation: 0,
      title: Text(
        clubShortHand,
        style: FontThemeClass().header(
          context,
          color: context.colorScheme.primaryTextColor,
        ),
      ),
      centerTitle: true,
      backgroundColor: context.colorScheme.scaffoldBackgroundColor,
    );
  }
}

class ClubsData extends ViewModelWidget<ClubsViewModel> {
  final String clubName;
  final String clubImage;
  final String clubShortHand;
  final List<FestInfo> clubFest;
  final String clubLink;
  final List<ClubMemberInfo> clubMembers;

  const ClubsData({
    super.key,
    required this.clubName,
    required this.clubImage,
    required this.clubShortHand,
    required this.clubFest,
    required this.clubMembers,
    required this.clubLink,
  });

  @override
  Widget build(BuildContext context, ClubsViewModel viewModel) {
    FontThemeClass fontTheme = FontThemeClass();
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.verticalSpace,
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0).r,
                child: CachedNetworkImage(
                  height: 276.h,
                  fit: BoxFit.cover,
                  imageUrl: clubImage,
                  placeholder: (context, url) {
                    return const Center(
                      child: CircularLoadingIndicator(),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return const Icon(Icons.error);
                  },
                ),
              ),
            ),
            18.verticalSpace,
            SizedBox(
              width: double.infinity,
              child: Center(
                child: Text(
                  clubName,
                  overflow: TextOverflow.ellipsis,
                  style: fontTheme.body(
                    context,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            10.verticalSpace,
            SizedBox(
              height: 220.h,
              child: Center(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: clubMembers.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 4.0,
                      margin: const EdgeInsets.all(16.0).r,
                      color: context.colorScheme.primaryCardColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20).r),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0).r,
                        child: SizedBox(
                          width: 130.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: CachedNetworkImage(
                                  width: 80.r,
                                  height: 80.r,
                                  fit: BoxFit.cover,
                                  imageUrl: clubMembers[index].memberImage,
                                  placeholder: (context, url) {
                                    return const Center(
                                      child: CircularLoadingIndicator(),
                                    );
                                  },
                                  errorWidget: (context, url, error) {
                                    return const Icon(Icons.error);
                                  },
                                ),
                              ),
                              // Name
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0).r,
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Center(
                                    child: Text(
                                      clubMembers[index].memberName,
                                      overflow: TextOverflow.ellipsis,
                                      style: fontTheme.body(
                                        context,
                                        color: context
                                            .colorScheme.primaryTextColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ).animate(delay: 500.ms).scale(),
                              ),
                              // Position
                              Text(
                                clubMembers[index].memberPosition,
                                style: fontTheme.body(
                                  context,
                                  color: context.colorScheme.secondaryTextColor,
                                ),
                              ).animate(delay: 500.ms).scale(),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0).r,
              child: Text(
                "Fests",
                style: fontTheme.body(
                  context,
                  color: context.colorScheme.secondaryTextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            clubFest.isNotEmpty
                ? SizedBox(
                    height: 229.h,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: clubFest.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            clubFest[index].festLink != ""
                                ? UrlLauncher()
                                    .launchURL(clubFest[index].festLink)
                                : showNormalMessage(
                                    context,
                                    " Direct link not found for this event!",
                                  );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12).r),
                            clipBehavior: Clip.hardEdge,
                            color: context.colorScheme.primaryCardColor,
                            elevation: 4.0,
                            margin: const EdgeInsets.all(12.0).r,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: clubFest[index].festImage,
                                    placeholder: (context, url) {
                                      return const Center(
                                        child: CircularLoadingIndicator(),
                                      );
                                    },
                                    errorWidget: (context, url, error) {
                                      return const Icon(Icons.error);
                                    },
                                  ),
                                ),
                                Container(
                                  height: 50.h,
                                  width: 150.w,
                                  decoration: BoxDecoration(
                                    color: context.colorScheme.primaryCardColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0).r,
                                    child: Center(
                                      child: Text(
                                        clubFest[index].festName,
                                        style: fontTheme.body(
                                          context,
                                          color: context
                                              .colorScheme.primaryTextColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ).animate(delay: 500.ms).scale(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : SizedBox(
                    height: 229.h,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error),
                          4.horizontalSpace,
                          const Text("No fests found!"),
                        ],
                      ),
                    ),
                  ),
            5.verticalSpace,
            Center(
              child: GestureDetector(
                onTap: () {
                  try {
                    UrlLauncher().launchURL(clubLink);
                  } catch (e) {
                    viewModel.log.e(e.toString());
                  }
                },
                child: Text(
                  "Let's Explore the $clubShortHand",
                  style: fontTheme.body(
                    context,
                    fontWeight: FontWeight.w500,
                    color: context.colorScheme.secondaryTextColor,
                  ),
                ),
              ),
            ),
            15.verticalSpace,
          ],
        ),
      ),
    );
  }
}
