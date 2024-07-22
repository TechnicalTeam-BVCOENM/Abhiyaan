part of '../uni_clubs/uni_clubs_view.dart';

class UniClubsAppBar extends ViewModelWidget<UniClubsViewModel> {
  final String uniClubShortHand;
  const UniClubsAppBar({super.key, required this.uniClubShortHand});

  @override
  Widget build(BuildContext context, UniClubsViewModel viewModel) {
    return SliverAppBar(
      iconTheme: IconThemeData(
        color: context.colorScheme.primaryText, //change your color here
      ),
      elevation: 0,
      title: Text(
        uniClubShortHand,
        style: FontThemeClass().header(
          context,
          color: context.colorScheme.primaryText,
        ),
      ),
      centerTitle: true,
      backgroundColor: context.colorScheme.scaffold,
    );
  }
}

class UniversalClubsData extends ViewModelWidget<UniClubsViewModel> {
  final String uniclubName;
  final String uniclubImage;
  final String uniclubShortHand;
  // final List<FestInfo> uniclubFest;
  final String uniclubLink;
  final List<ClubMemberInfo> uniclubMembers;

  const UniversalClubsData({
    super.key,
    required this.uniclubName,
    required this.uniclubImage,
    required this.uniclubShortHand,
    // required this.uniclubFest,
    required this.uniclubMembers,
    required this.uniclubLink,
  });

  @override
  Widget build(BuildContext context, UniClubsViewModel viewModel) {
    FontThemeClass fontTheme = FontThemeClass();
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18).r,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          10.verticalSpace,
          Hero(
            tag: uniclubShortHand,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0).r,
                child: CachedNetworkImage(
                  height: 276.h,
                  width: 395.w,
                  fit: BoxFit.fill,
                  imageUrl: uniclubImage,
                  placeholder: (context, url) =>
                      const CircularLoadingIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
          18.verticalSpace,
          SizedBox(
            width: double.infinity,
            child: Center(
              child: Text(
                uniclubName,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: fontTheme.body(context, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          4.verticalSpace,
          Center(
            child: InkWell(
              onTap: () {
                try {
                  UrlLauncher().launchURL(uniclubLink);
                } catch (e) {
                  viewModel.log.e(e.toString());
                }
              },
              child: Text(
                "Let's Explore the $uniclubShortHand",
                style: fontTheme.body(context,
                    fontWeight: FontWeight.w500,
                    color: context.colorScheme.secondarySectionColor),
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
                itemCount: uniclubMembers.length,
                itemBuilder: (context, index) {
                  return MemberCard(
                    clubMembers: uniclubMembers,
                    fontTheme: fontTheme,
                    index: index,
                  );
                },
              ),
            ),
          ),
          // uniclubFest.isEmpty
          //     ? Container()
          //     : Padding(
          //         padding: const EdgeInsets.only(left: 16.0).r,
          //         child: Text(
          //           "Fests | ${uniclubFest.length}",
          //           style: fontTheme.body(
          //             context,
          //             fontWeight: FontWeight.w500,
          //           ),
          //         ),
          //       ),
          // uniclubFest.isEmpty
          //     ? Container()
          //     : SizedBox(
          //         height: 230.h,
          //         width: double.infinity,
          //         child: ListView.builder(
          //           physics: const BouncingScrollPhysics(),
          //           scrollDirection: Axis.horizontal,
          //           itemCount: uniclubFest.length,
          //           shrinkWrap: true,
          //           itemBuilder: (context, index) {
          //             return FestCard(
          //               clubFest: uniclubFest,
          //               fontTheme: fontTheme,
          //               index: index,
                //       );
                //     },
                //   ),
                // ),
          15.verticalSpace,
        ]));
  }
}

class MemberCard extends StatelessWidget {
  const MemberCard({
    super.key,
    required this.clubMembers,
    required this.fontTheme,
    required this.index,
  });

  final List<ClubMemberInfo> clubMembers;
  final FontThemeClass fontTheme;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(16.0).r,
      color: context.colorScheme.card,
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
                    return const CircularLoadingIndicator();
                  },
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
                      maxLines: 1,
                      style: fontTheme.body(
                        context,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              // Position
              Text(
                clubMembers[index].memberPosition,
                style: fontTheme.caption(
                  context,
                  color: context.colorScheme.secondarySectionColor,
                ),
              ),
            ].animate(delay: 100.ms, interval: 80.ms).scale(),
          ),
        ),
      ),
    );
  }
}

// class FestCard extends StatelessWidget {
//   const FestCard({
//     super.key,
//     required this.clubFest,
//     required this.fontTheme,
//     required this.index,
//   });

//   final List<FestInfo> clubFest;
//   final FontThemeClass fontTheme;
//   final int index;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         clubFest[index].festLink != "" || clubFest[index].festLink.isEmpty
//             ? UrlLauncher().launchURL(
//                 clubFest[index].festLink,
//               )
//             : showNormalMessage(
//                 context,
//                 " Direct link not found for this event!",
//               );
//       },
//       child: Card(
//         shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(12).r),
//         clipBehavior: Clip.hardEdge,
//         color: context.colorScheme.card,
//         elevation: 4.0,
//         margin: const EdgeInsets.all(12.0).r,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment:
//               MainAxisAlignment.start, // Align children to the start
//           children: [
//             SizedBox(
//               width: 150.w,
//               height: 150.h,
//               child: CachedNetworkImage(
//                 fit: BoxFit.cover,
//                 imageUrl: clubFest[index].festImage,
//                 placeholder: (context, url) => const CircularLoadingIndicator(),
//                 errorWidget: (context, url, error) => const Icon(Icons.error),
//               ),
//             ),
//             Wrap(
//               clipBehavior: Clip.hardEdge,
//               children: [
//                 Container(
//                   height: 52.h,
//                   width: 150.w,
//                   decoration: BoxDecoration(
//                     color: context.colorScheme.card,
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0).r,
//                     child: Center(
//                       child: Text(
//                         clubFest[index].festName,
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 1,
//                         style: fontTheme.body(context,
//                             fontWeight: FontWeight.w500),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ].animate(delay: 200.ms, interval: 80.ms).scale(),
//         ),
//       ),
//     );
//   }
// }
