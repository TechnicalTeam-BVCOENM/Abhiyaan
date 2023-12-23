part of "community_view.dart";


class CommunityViewModel extends BaseViewModel {
  final log = getLogger("CommunityViewModel");
  // Add ViewModel specific code here
}


// Community blogs component model => Community => data => blogs => random ID => 'author'/'content'/'title'/'imageUrl'/'date'/'likes' (For now there is only one blog)
// If creating post add username at that time of cureent user (only for student not for outsiders)
class CommunityBlogsData {
  final String author;
  // final String content;
  final String title;
  final String imageUrl;
  final String date;
  final int likes;

  CommunityBlogsData({
    required this.author,
    // required this.content,
    required this.title,
    required this.imageUrl,
    required this.date,
    required this.likes,
  });
}

// Departmental Clubs model => Community => data => clubs => 'cesa'/'mesa'/'itsa' etc (For now there is only cesa club)
class DepartmentalClubsData {
  final String clubName; // full name of the club
  final String clubImage; // Logo of the club
  final String clubShortHand; // short name of the club
  final Array clubFest; // (Array of fest ) => festImage , festName
  final Array clubMembers; // (Array of members)  => memberName , memberImage , memberPosition for each member
  final String clubLink; // optional (website link of the club )

  DepartmentalClubsData({
    required this.clubName,
    required this.clubImage,
    required this.clubShortHand,
    required this.clubFest,
    required this.clubMembers,
    required this.clubLink,
  });
}