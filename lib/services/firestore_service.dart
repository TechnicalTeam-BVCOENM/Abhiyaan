import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/ui/views/community/community_view.dart';
import 'package:abhiyaan/ui/views/home/celebration/celebration_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:abhiyaan/ui/views/event/event_view.dart';
import 'package:abhiyaan/ui/views/home/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future updateUserStatus() async {
    try {
      await _firestore
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'isUserNew': false}).then(
              (value) => debugPrint("Updated status of user"));
      return;
    } catch (e) {
      debugPrint("User status failed to update with : ${e.toString()}");
    }
  }

  Future updateLikes(String id) async {
    try {
      final userId = _firestore.collection("Users").doc().id;
      await _firestore.collection('Community').doc("data").collection("blogs").doc(id).update({'likes':  FieldValue.arrayUnion([userId])}).then((value) => debugPrint("Updated likes of Post"));
      return;
    } catch (e) {
      debugPrint("Likes failed to update with : ${e.toString()}");
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
      debugPrint(
          "Error in getting celebration data from firebase : ${e.toString()}");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getAllData(String collection) async {
    final QuerySnapshot snapshot =
        await _firestore.collection(collection).get();
    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Future<List<Map<String, dynamic>>> getHighlights() async {
    final QuerySnapshot snapshot = await _firestore
        .collection('CollegeUpdates')
        .doc("data")
        .collection("highlights")
        .get();
    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Future<List<DepartmentUpdates>> getCollegeUpdates() async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('CollegeUpdates')
          .doc("data")
          .collection("updates")
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
      debugPrint("Error in getting college updates : ${e.toString()}");
      return [];
    }
  }

  Future<List<SponsorsModel>> getAllSponsors() async {
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
  }

  Future<List<EventModel>> getAllEvents() async {
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
  }

  Future<void> addData(Map<String, dynamic> data) async {
    await _firestore.collection('your_collection').add(data);
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final DocumentSnapshot snapshot = await _firestore
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (snapshot.exists) {
      return snapshot.data() as Map<String, dynamic>;
    } else {
      return null;
    }
  }

  Future<List<CommunityBlogsData>> getBlogs() async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('Community')
          .doc("data")
          .collection("blogs").orderBy("date",descending: true).limit(3).get();

      if (snapshot.docs.isEmpty) {
        return [];
      } else {
        return snapshot.docs.map((data) {
          debugPrint(data.id);
          return CommunityBlogsData(
              documentId: data.id,
              author: data["author"],
              title: data['title'],
              imageUrl: data["imageUrl"],
              date: data["date"],
              likes: data["likes"],
              // content: data["content"]
              );
        }).toList();
      }
    } catch (e) {
      debugPrint("Error in getting blogs data from firebase : ${e.toString()}");
      return [];
    }
  }
}
