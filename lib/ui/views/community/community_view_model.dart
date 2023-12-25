part of "community_view.dart";

class CommunityViewModel extends BaseViewModel {
  final log = getLogger("CommunityViewModel");
  final NavigationService navigationService = locator<NavigationService>();
  final FirestoreService firestoreService = FirestoreService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  LocalStorageService localStorageService = locator<LocalStorageService>();
  String affirmation = "";
  String authorName = "";


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


   final List<DepartmentalClubsData> _departmentClubsData = [];
  List<DepartmentalClubsData> get departmentClubsData => _departmentClubsData;
  set departmentClubsData(List<DepartmentalClubsData> departmentClubsData) {
    _departmentClubsData.addAll(departmentClubsData);
    notifyListeners();
  }

  Future<List<DepartmentalClubsData>> getDepartmentClubsData() async {
    departmentClubsData = await firestoreService.getDepartmentClubsData();
    return departmentClubsData;
  }




  int _currentBlogIndex = 0;
  int get currentBlogIndex => _currentBlogIndex;
  void updateBlogIndex(int newIndex) {
    _currentBlogIndex = newIndex;
    notifyListeners();
  }

  Stream<int> getLikesStream(String id) {
    AuthenticationService authenticationService =
        locator<AuthenticationService>();
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

  Future<void> fetchAffirmation() async {
    Random random = Random();
    int randomNumber = random.nextInt(15);
    List<String> author;
    var response = await http.get(Uri.parse('https://type.fit/api/quotes'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      affirmation = data[randomNumber]['text'];
      authorName =
          data[randomNumber]['author']; // Corrected 'author' to 'author'
      author = authorName.split(",");
      authorName = author[0];
    } else {
      // Handle error cases here
      debugPrint('Failed to fetch affirmation');
    }
  }

  Future<void> updateLikes(String blogId) async {
    final currentBlog = localStorageService.read("isLiked_$blogId");
    AuthenticationService authenticationService =
        locator<AuthenticationService>();
    final userId = authenticationService.currentUser!.uid;
    try {
      if (currentBlog == true) {
        log.i("Already liked");
        return;
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
      await fetchAffirmation();
      await getDepartmentClubsData();
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


class DepartmentalClubsData {
  final String clubName; 
  final String clubImage;
  final String clubShortHand; 
  final List<FestInfo> clubFest; 
  final List<ClubMemberInfo> clubMembers; 
  // final String clubLink; 

  DepartmentalClubsData({
    required this.clubName,
    required this.clubImage,
    required this.clubShortHand,
    required this.clubFest,
    required this.clubMembers,
    // required this.clubLink,
  });
}

class FestInfo {
  final String festName;
  final String festImage;

  FestInfo({
    required this.festName,
    required this.festImage,
  });
}

class ClubMemberInfo {
  final String memberName;
  final String memberImage;
  final String memberPosition;

  ClubMemberInfo({
    required this.memberName,
    required this.memberImage,
    required this.memberPosition,
  });
}
