part of "community_view.dart";

class CommunityViewModel extends BaseViewModel {
  final log = getLogger("CommunityViewModel");
  final NavigationService navigationService = locator<NavigationService>();
  final FirestoreService firestoreService = FirestoreService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  LocalStorageService localStorageService = locator<LocalStorageService>();

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

 Stream<int> getLikesStream(String id) {
     AuthenticationService authenticationService = locator<AuthenticationService>();
      final userId = authenticationService.currentUser!.uid;
  return _firestore
      .collection('Community')
      .doc("data")
      .collection("blogs")
      .doc(id)
      .snapshots()
      .map((snapshot) {
    final likesArray = snapshot.data()?["likes"];
    localStorageService.write("isLiked_$id", likesArray.contains(userId));
    log.i(likesArray);
    return likesArray.length;
    });
}

  Future<void> updateLikes (String blogId) async{
   final currentBlog =  localStorageService.read("isLiked_$blogId");
        AuthenticationService authenticationService = locator<AuthenticationService>();
      final userId = authenticationService.currentUser!.uid;
       try {
        if (currentBlog == true) {
          log.i("Already liked");
          return ;
        }
        await _firestore
            .collection('Community')
            .doc("data")
            .collection("blogs")
            .doc(blogId)
            .update({
          "likes": FieldValue.arrayUnion([userId]),
        }).then((value) => log.i("Updated likes"));   
       } catch (e) {
          log.i(e.toString());
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

class CommunityBlogsData {
  final String documentId;
  final String author;
  // final String content;
  final String title;
  final String imageUrl;
  final Timestamp date;
  final List<dynamic> likes;

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
