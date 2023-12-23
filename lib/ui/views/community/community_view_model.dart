part of "community_view.dart";


class CommunityViewModel extends BaseViewModel {
  final log = getLogger("CommunityViewModel");
  // Add ViewModel specific code here
}


// Higlights component model
class CommunityBlogsData {
  final String userName;
  final String profileImage;
  final String topic;
  final String image;
  final String link;
  // description 
  // likes
  // title 

  CommunityBlogsData({
    required this.userName,
    required this.topic,
    required this.profileImage,
    required this.image,
    required this.link,
  });
}

// Departmental Clubs model
class DepartmentalClubsData {
  final String clubName;
  final String clubImage;
  final String clubDescription;
  final String clubLink; // optional (website)
  final Array clubFest; // (Array of fest names) => fest image 
  final Array clubMembers; // now there will be only two members (Array of two members)  => name , image , position for each member

  DepartmentalClubsData({
    required this.clubName,
    required this.clubFest,
    required this.clubMembers,
    required this.clubImage,
    required this.clubDescription,
    required this.clubLink,
  });
}