part of "community_view.dart";

class CommunityViewModel extends BaseViewModel {
  final log = getLogger("CommunityViewModel");
  final NavigationService navigationService = locator<NavigationService>();
  final FirestoreService firestoreService = FirestoreService();

  // Add ViewModel specific code here

  // Blogs data
  final List<CommunityBlogsData> _blogsData = [];
  List<CommunityBlogsData> get blogsData => _blogsData;

  Future<List<CommunityBlogsData>> getBlogData() async {
    final List<CommunityBlogsData> unsortedList =
        await firestoreService.getBlogs();
    unsortedList.sort((a, b) => a.date.toDate().compareTo(b.date.toDate()));
    for (int i = 0; i < 3; i++) {
      blogsData.add(unsortedList[i]);
    }
    log.i("Overall Blogs data: ${blogsData.length}");
    return blogsData;
  }

  Future<void> init(context) async{
    setBusy(true);
    try {
    await  getBlogData();
    notifyListeners();
    } catch (e) {
      log.e(e.toString());
    }
    setBusy(false);
  }
}

// Community blogs component model => Community => data => blogs => random ID => 'author'/'content'/'title'/'imageUrl'/'date'/'likes' (For now there is only one blog)
// If creating post add username at that time of cureent user (only for student not for outsiders)
class CommunityBlogsData {
  final String author;
  // final String content;
  final String title;
  final String imageUrl;
  final Timestamp date;
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
  final Array
      clubMembers; // (Array of members)  => memberName , memberImage , memberPosition for each member
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
