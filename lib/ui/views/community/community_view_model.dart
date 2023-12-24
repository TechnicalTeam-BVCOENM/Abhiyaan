part of "community_view.dart";

class CommunityViewModel extends BaseViewModel {
  final log = getLogger("CommunityViewModel");
  final NavigationService navigationService = locator<NavigationService>();
  final FirestoreService firestoreService = FirestoreService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  LocalStorageService localStorageService = locator<LocalStorageService>();

  // Blogs data
  final List<CommunityBlogsData> _blogsData = [];
  List<CommunityBlogsData> get blogsData => _blogsData;
  set blogsData(List<CommunityBlogsData> blogsData) {
    _blogsData.addAll(blogsData);
    notifyListeners();
  }

  Future<List<CommunityBlogsData>> getBlogData() async {
    blogsData = await firestoreService.getBlogs();
    return blogsData;
  }

  int _currentBlogIndex = 0;
  int get currentBlogIndex => _currentBlogIndex;
  void updateBlogIndex(int newIndex) {
    _currentBlogIndex = newIndex;
    notifyListeners();
  }

  // Stream to track likes
  Stream<int>  getLikesStream(String id) {
    return _firestore.collection('Community').doc("data").collection("blogs").doc(id).snapshots().map((snapshot) {
      return snapshot.data()!['likes'];
    });
  }

  // Blog Likes
  Future<int> incrementLikes(int likes, String blogId) async {
    if (localStorageService.read("liked_$blogId") == false || localStorageService.read("liked_$blogId") == null) {
      likes = likes + 1;
    localStorageService.write("liked_$blogId", true);
    log.i(localStorageService.read("liked_$blogId"));
    await firestoreService.updateLikes(blogId, likes);
    notifyListeners();
    return likes;
    }else{
      log.i("Already liked : ${localStorageService.read("liked_$blogId")}");
      return likes;
    }
  }
  Future<int> decrementLike(int likes, String blogId) async {
    if (localStorageService.read("liked_$blogId") == true) {
      likes = likes -1;
    localStorageService.write("liked_$blogId", false);
    log.i(localStorageService.read("liked_$blogId"));
    await firestoreService.updateLikes(blogId, likes);
    notifyListeners();
    return likes;
    }else{
      log.i("Already liked : ${localStorageService.read("liked_$blogId")}");
      return likes;
    }
  }

  Future<void> init(context) async {
    setBusy(true);
    try {
      await getBlogData();
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
  final String documentId;
  final String author;
  // final String content;
  final String title;
  final String imageUrl;
  final Timestamp date;
  final int likes;

  CommunityBlogsData({
    required this.documentId,
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
