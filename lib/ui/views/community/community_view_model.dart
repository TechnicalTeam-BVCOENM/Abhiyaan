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

  final List<DepartmentalClubsData> _departmentClubsData = [];
  List<DepartmentalClubsData> get departmentClubsData => _departmentClubsData;
  set departmentClubsData(List<DepartmentalClubsData> departmentClubsData) {
    _departmentClubsData.addAll(departmentClubsData);
    notifyListeners();
  }

  final List<UniversalClubsData> _universalClubsData = [];
  List<UniversalClubsData> get universalClubsData => _universalClubsData;
  set universalClubsData(List<UniversalClubsData> universalClubsData) {
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

  Future<List<DepartmentalClubsData>> getDepartmentClubsData() async {
    try {
      departmentClubsData = await firestoreService.getDepartmentClubsData();
      return departmentClubsData;
    } on Exception catch (e) {
      log.e("Error in fetching department clubs data: ${e.toString()}");
      return [];
    }
  }

  Future<List<UniversalClubsData>> getUniversalClubsData() async {
    try {
      universalClubsData = await firestoreService.getUniversalClubsData();
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

  Future<void> fetchAffirmation() async {
    try {
      Random random = Random();
      int randomNumber = random.nextInt(15);
      List<String> author;
      var response = await http.get(Uri.parse('https://type.fit/api/quotes'));

      if (response.statusCode != 200) {
        return;
      } else if (response.statusCode == 200) {
        final data = jsonDecode(response.body.toString());
        affirmation = data[randomNumber]['text'];
        authorName = data[randomNumber]['author'];
        author = authorName.split(",");
        authorName = author[0];
      }
    } on Exception catch (e) {
      log.e("Error in fetching affirmation: ${e.toString()}");
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
      await runBusyFuture(getBlogData());
      await getDepartmentClubsData();
      notifyListeners();
      await fetchAffirmation();
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

class DepartmentalClubsData {
  final String clubName;
  final String clubImage;
  final String clubShortHand;
  final List<FestInfo> clubFest;
  final List<ClubMemberInfo> clubMembers;
  final String clubLink;

  DepartmentalClubsData({
    required this.clubName,
    required this.clubImage,
    required this.clubShortHand,
    required this.clubFest,
    required this.clubMembers,
    required this.clubLink,
  });
}

class  UniversalClubsData {
  final String uniclubName;
  final String uniclubImage;
  final String uniclubShortHand;
  final List<ClubMemberInfo> clubMembers;
  final String uniclubLink;

  UniversalClubsData({
    required this.uniclubName,
    required this.uniclubImage,
    required this.uniclubShortHand,
    required this.clubMembers,
    required this.uniclubLink,
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
  final String memberName;
  final String memberImage;
  final String memberPosition;

  ClubMemberInfo({
    required this.memberName,
    required this.memberImage,
    required this.memberPosition,
  });
}
