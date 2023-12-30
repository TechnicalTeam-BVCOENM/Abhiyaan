import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/ui/views/community/community_view.dart';
import 'package:abhiyaan/ui/views/home/celebration/celebration_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:abhiyaan/ui/views/event/event_view.dart';
import 'package:abhiyaan/ui/views/home/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final log = getLogger("FirestoreService");

  Future updateUserStatus() async {
    try {
      await _firestore
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'isUserNew': false}).then(
              (value) => debugPrint("Updated status of user"));
      return;
    } catch (e) {
      log.e("User status failed to update with : ${e.toString()}");
    }
  }

  Future updateLikes(String id) async {
    try {
      final userId = _firestore.collection("Users").doc().id;
      await _firestore
          .collection('Community')
          .doc("data")
          .collection("blogs")
          .doc(id)
          .update({
        'likes': FieldValue.arrayUnion([userId])
      }).then((value) => debugPrint("Updated likes of Post"));
      return;
    } catch (e) {
      log.e("Likes failed to update with : ${e.toString()}");
    }
  }

  Future<List<CelebrationData>> getCelebrationData() async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('Events')
          .doc("data")
          .collection("celebration")
          .get();

      if (snapshot.docs.isEmpty) {
        return [];
      } else {
        return snapshot.docs.map((doc) {
          Map<dynamic, dynamic> data = doc.data() as Map<dynamic, dynamic>;
          return CelebrationData(
            title: data['title'] ?? '',
            description: data['description'] ?? '',
            image: data['imageUrl'] ?? '',
            startdate: data['startDate'],
          );
        }).toList();
      }
    } catch (e) {
      log.e(
          "Error in getting celebration data from firebase : ${e.toString()}");
      return [];
    }
  }

  Future<List<DepartmentalClubsData>> getDepartmentClubsData() async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection("Community")
          .doc("data")
          .collection("clubs")
          .get();
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Map<String, dynamic> aClubData = data["data"] as Map<String, dynamic>;
        List<dynamic> clubMm = data["data"]["clubMember"];
        List<dynamic> clubFst = data["data"]["clubFest"];

        String clubName = aClubData['clubName'];
        String clubShortHand = aClubData['clubShortHand'];
        String clubImage = aClubData['clubImage'];
        List<ClubMemberInfo> clubMembers = clubMm.map((e) {
          return ClubMemberInfo(
            memberName: e['memberName'],
            memberImage: e['memberImage'],
            memberPosition: e['memberPosition'],
          );
        }).toList();
        List<FestInfo> clubFests = clubFst.map((e) {
          return FestInfo(
            festName: e['festName'],
            festImage: e['festImage'],
          );
        }).toList();

        return DepartmentalClubsData(
          clubName: clubName,
          clubShortHand: clubShortHand,
          clubImage: clubImage,
          clubMembers: clubMembers,
          clubFest: clubFests,
        );
      }).toList();
    } on Exception catch (e) {
      log.e("Error in getting departmental clubs data : ${e.toString()}");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getHighlights() async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('CollegeUpdates')
          .doc("data")
          .collection("highlights")
          .limit(4)
          .get();
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } on Exception catch (e) {
      log.e("Error in getting highlights : ${e.toString()}");
      return [];
    }
  }

  Future<List<DepartmentUpdates>> getCollegeUpdates() async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('CollegeUpdates')
          .doc("data")
          .collection("updates").orderBy("date", descending: true).limit(8)
          .get();

      if (snapshot.docs.isEmpty) {
        return [];
      } else {
        return snapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return DepartmentUpdates(
            title: data['title'] ?? '',
            description: data['description'] ?? '',
            date: data['date'] ?? '',
          );
        }).toList();
      }
    } catch (e) {
      log.e("Error in getting college updates : ${e.toString()}");
      return [];
    }
  }

  Future<List<SponsorsModel>> getAllSponsors() async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection("Events")
          .doc("data")
          .collection('sponsors')
          .get();
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return SponsorsModel(
            title: data["title"], url: data["url"], imageUrl: data["imageUrl"]);
      }).toList();
    } on Exception catch (e) {
      log.e("Error in getting sponsors : ${e.toString()}");
      return [];
    }
  }

  Future<List<EventModel>> getAllEvents() async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection("Events")
          .doc('data')
          .collection('events')
          .get();
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return EventModel(
          title: data['title'],
          startDate: data['startDate'],
          endDate: data['endDate'],
          location: data['location'],
          imageUrl: data['imageUrl'],
          cName: data['coordinatorName'],
          cEmail: data['coordinatorEmail'],
          cPhone: data['coordinatorPhone'],
          about: data['about'],
          registerUrl: data['registerUrl'],
        );
      }).toList();
    } on Exception catch (e) {
      log.e("Error in getting events : ${e.toString()}");
      return [];
    }
  }

  Future<Map<String, dynamic>?> getUserData() async {
    try {
      final DocumentSnapshot snapshot = await _firestore
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log.e("Error in getting user data : ${e.toString()}");
      return null;
    }
  }

  Future<List<CommunityBlogsData>> getBlogs() async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('Community')
          .doc("data")
          .collection("blogs")
          .orderBy("date", descending: true)
          .limit(6)
          .get();

      if (snapshot.docs.isEmpty) {
        return [];
      } else {
        return snapshot.docs.map((data) {
          return CommunityBlogsData(
            documentId: data.id,
            author: data["author"],
            authorImageUrl: data["authorImageUrl"],
            title: data['title'],
            imageUrl: data["imageUrl"],
            date: data["date"],
            likes: data["likes"],
            content: data["content"]
          );
        }).toList();
      }
    } catch (e) {
      log.e("Error in getting blogs data from firebase : ${e.toString()}");
      return [];
    }
  }
}
