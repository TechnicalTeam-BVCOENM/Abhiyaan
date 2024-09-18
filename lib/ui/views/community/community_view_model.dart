part of "community_view.dart";

class CommunityViewModel extends BaseViewModel {
  final log = getLogger("CommunityViewModel");
  final NavigationService navigationService = locator<NavigationService>();
  final FirestoreService firestoreService = FirestoreService();
  final AnalyticsService _analyticsService = locator<AnalyticsService>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  LocalStorageService localStorageService = locator<LocalStorageService>();

  String affirmation = "";
  String authorName = "";
  int _currentBlogIndex = 0;
  int get currentBlogIndex => _currentBlogIndex;
  final List<CommunityBlogsData> _blogsData = [];
  List<CommunityBlogsData> get blogsData => _blogsData;
  set blogsData(List<CommunityBlogsData> blogsData) {
    _blogsData.addAll(blogsData);
    notifyListeners();
  }

  final List<ClubsDataModel> _departmentClubsData = [];
  List<ClubsDataModel> get departmentClubsData => _departmentClubsData;
  set departmentClubsData(List<ClubsDataModel> departmentClubsData) {
    _departmentClubsData.addAll(departmentClubsData);
    notifyListeners();
  }

  final List<ClubsDataModel> _universalClubsData = [];
  List<ClubsDataModel> get universalClubsData => _universalClubsData;
  set universalClubsData(List<ClubsDataModel> universalClubsData) {
    _universalClubsData.addAll(universalClubsData);
    notifyListeners();
  }

  void navigateToDetailedBlogPage(
      CommunityBlogsData blogData, BuildContext context) {
    try {
      _analyticsService.logEvent(
          eventName: "Detailed_Blog_View",
          value: "${blogData.title} Blog Viewed : ${blogData.documentId}");
      showModalBottomSheet(
        enableDrag: true,
        showDragHandle: true,
        context: context,
        elevation: 0,
        isDismissible: false,
        backgroundColor: context.colorScheme.card,
        isScrollControlled: true,
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.9,
          maxHeight: MediaQuery.of(context).size.height * 0.95,
        ),
        builder: (context) {
          return DettailedBlogPage(blogData: blogData);
        },
      );
    } on Exception catch (e) {
      log.e("Error in navigating to detailed blog page: ${e.toString()}");
    }
  }

  Future<List<CommunityBlogsData>> getBlogData() async {
    try {
      blogsData = await firestoreService.getBlogs();
      return blogsData;
    } on Exception catch (e) {
      log.e("Error in fetching blogs: ${e.toString()}");
      return [];
    }
  }

  Future<void> getDepartmentClubsData() async {
    try {
      departmentClubsData =
          await firestoreService.getClubsData(collectionName: FirebaseConstants.clubs);
    } on Exception catch (e) {
      log.e("Error in fetching department clubs data: ${e.toString()}");
    }
  }

  Future<List<ClubsDataModel>> getUniversalClubsData() async {
    try {
      universalClubsData =
          await firestoreService.getClubsData(collectionName: FirebaseConstants.globalClubs);
      return universalClubsData;
    } on Exception catch (e) {
      log.e("Error in fetching universal clubs data: ${e.toString()}");
      return [];
    }
  }

  void updateBlogIndex(int newIndex) {
    try {
      _currentBlogIndex = newIndex;
      notifyListeners();
    } on Exception catch (e) {
      log.e("Error in updating blog index: ${e.toString()}");
    }
  }

  Stream<int> getLikesStream(String id) {
    try {
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
        return likesArray.length;
      });
    } on Exception catch (e) {
      log.e("Error in getting likes stream: ${e.toString()}");
      return const Stream.empty();
    }
  }

  Future<void> updateLikes(String blogId, BuildContext context) async {
    final currentBlog = localStorageService.read("isLiked_$blogId");
    AuthenticationService authenticationService =
        locator<AuthenticationService>();
    final userId = authenticationService.currentUser!.uid;
    try {
      if (currentBlog == true) {
        log.d("Already liked");
        showNormalMessage(context, "Already liked");
        return;
      }
      await _firestore
          .collection('Community')
          .doc("data")
          .collection("blogs")
          .doc(blogId)
          .update({
        "likes": FieldValue.arrayUnion([userId]),
      }).then((value) {
        _analyticsService.logEvent(
            eventName: "Blog_Likes", value: "Blog Liked : $blogId");
        showSuccessMessage(context, "You Liked this blog");
      });
    } catch (e) {
      log.e("Error in updating likes: ${e.toString()}");
    }
  }

  Future<void> init(context) async {
    try {
      _analyticsService.logScreen(screenName: 'CommunityView Screen Opened');
      await Future.wait([
        getBlogData(),
        getDepartmentClubsData(),
        getUniversalClubsData(),
      ]);
      notifyListeners();
    } catch (e) {
      log.e(e.toString());
    }
  }

  var clubsCarosoulOptions = CarouselOptions(
    scrollPhysics: const BouncingScrollPhysics(),
    autoPlayCurve: Curves.easeInOutCubic,
    enableInfiniteScroll: true,
    autoPlay: true,
    autoPlayInterval: 2.seconds,
    autoPlayAnimationDuration: 1.seconds,
    pauseAutoPlayOnTouch: true,
    pauseAutoPlayInFiniteScroll: true,
    viewportFraction: 0.35,
    height: 120.h,
  );
}

class CommunityBlogsData {
  final String documentId;
  final String author;
  final String authorImageUrl;
  final String content;
  final String title;
  final String imageUrl;
  final Timestamp date;
  final List<dynamic> likes;

  CommunityBlogsData({
    required this.documentId,
    required this.author,
    required this.authorImageUrl,
    required this.content,
    required this.title,
    required this.imageUrl,
    required this.date,
    required this.likes,
  });
}

class ClubsDataModel {
  final String clubName;
  final String clubImage;
  final String clubShortHand;
  final List<FestInfo> clubFest;
  final List<ClubMemberInfo> clubMembers;
  final String clubLink;

  ClubsDataModel({
    required this.clubName,
    required this.clubImage,
    required this.clubShortHand,
    required this.clubFest,
    required this.clubMembers,
    required this.clubLink,
  });
}

class FestInfo {
  final String festName;
  final String festImage;
  final String festLink;

  FestInfo({
    required this.festName,
    required this.festImage,
    required this.festLink,
  });
}

class ClubMemberInfo {
  final String name;
  final String image;
  final String position;

  ClubMemberInfo({
    required this.name,
    required this.image,
    required this.position,
  });
}
