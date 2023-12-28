part of '../clubs/clubs_view.dart';

class ClubsAppBar extends ViewModelWidget<ClubsViewModel> {
  final String clubShortHand;
  const ClubsAppBar({super.key, required this.clubShortHand});

  @override
  Widget build(BuildContext context, ClubsViewModel viewModel) {
    return SliverAppBar(
      iconTheme: IconThemeData(
        color: context.colorScheme.secondaryBlackColor, //change your color here
      ),
      elevation: 0,
      title: Text(
        clubShortHand,
        style: FontThemeClass()
            .header(context, color: context.colorScheme.secondaryBlackColor),
      ),
      centerTitle: true,
      backgroundColor: context.colorScheme.backgroundColor,
    );
  }
}

class ClubsData extends ViewModelWidget<ClubsViewModel> {
  final String clubName;
  final String clubImage;
  final String clubShortHand;
  final List<FestInfo> clubFest;
  final List<ClubMemberInfo> clubMembers;

  const ClubsData({
    super.key,
    required this.clubName,
    required this.clubImage,
    required this.clubShortHand,
    required this.clubFest,
    required this.clubMembers,
  });

  @override
  Widget build(BuildContext context, ClubsViewModel viewModel) {
    FontThemeClass fontTheme = FontThemeClass();
    return SliverToBoxAdapter(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18).r,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            10.verticalSpace,
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(16.0).r, // Adjust the radius as needed
              child: Image.network(
                clubImage,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 276.h,
              ),
            ),
            10.verticalSpace,
            Center(
              child: Text(
                clubName,
                style: fontTheme.body(context, fontWeight: FontWeight.w500),
              ),
            ),
            10.verticalSpace,
            SizedBox(
              height: 230.h,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: clubMembers.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 4.0,
                      margin: const EdgeInsets.all(16.0),
                      color: context.colorScheme.secondaryWhiteColor,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0).r,
                        child: SizedBox(
                          width: 130.w,
                          child: Column(
                            children: [
                              // Circular image
                              Container(
                                width: 80.0,
                                height: 80.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        clubMembers[index].memberImage),
                                  ),
                                ),
                              ),
                              // Name
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, bottom: 8.0)
                                        .r,
                                child: Text(
                                  clubMembers[index].memberName,
                                  style: fontTheme.body(context,
                                      fontWeight: FontWeight.w500),
                                ).animate(delay: 500.ms).scale(),
                              ),
                              // Position
                              Text(
                                clubMembers[index].memberPosition,
                                style: fontTheme.body(context,
                                    color: context
                                        .colorScheme.secondarySectionColor),
                              ).animate(delay: 500.ms).scale(),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Fests",
                style: fontTheme.body(
                  context,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 210.h,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: clubFest.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 4.0,
                      margin: const EdgeInsets.all(16.0),
                      clipBehavior: Clip.hardEdge,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            clubFest[index].festImage,
                            height: 124.h,
                            width: 140.w,
                            fit: BoxFit.fitWidth,
                          ).animate(delay: 400.ms).fadeIn(duration: 900.ms),
                          Container(
                            height: 50.h,
                            width: 140.w,
                            decoration: BoxDecoration(
                              color: context.colorScheme.secondaryWhiteColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  clubFest[index].festName,
                                  style: fontTheme.body(context,
                                      fontWeight: FontWeight.w500),
                                ).animate(delay: 500.ms).scale(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            5.verticalSpace,
            Center(
              child: Text(
                "Let's Explore the $clubShortHand",
                style: fontTheme.body(context,
                    fontWeight: FontWeight.w500,
                    color: context.colorScheme.secondarySectionColor),
              ),
            ),
            28.verticalSpace,
          ])),
    );
  }
}
