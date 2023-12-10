import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darpan/ui/sub_views/academics/courses/courses_view.dart';
import 'package:darpan/ui/views/academics/academics_view.dart';
import 'package:darpan/ui/views/event/event_view.dart';
import 'package:darpan/ui/views/home/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getAllData(String collection) async {
    final QuerySnapshot snapshot =
        await _firestore.collection(collection).get();
    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Future<List<DepartmentUpdates>> getAllDepartmentData(
      String collection) async {
    final QuerySnapshot snapshot =
        await _firestore.collection(collection).get();
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return DepartmentUpdates(
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        date: data['date'] ?? '',
        isExpanded: data['isExpanded'] ?? false,
        expandedHeight: (data['expandedHeight'] ?? 100.0).toDouble(),
        maxLines: data['maxLines'] ?? 2,
        overflow: data['overflow'] ?? true,
      );
    }).toList();
  }

  Future<List<AcademicsUpdates>> getAllAcademicData(String collection) async {
    final QuerySnapshot snapshot =
        await _firestore.collection(collection).get();
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return AcademicsUpdates(
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        date: data['date'] ?? '',
        isExpanded: data['isExpanded'] ?? false,
        expandedHeight: (data['expandedHeight'] ?? 100.0).toDouble(),
        maxLines: data['maxLines'] ?? 2,
        overflow: data['overflow'] ?? true,
      );
    }).toList();
  }

  Future<List<SponsorsModel>> getAllSponsors() async {
    final QuerySnapshot snapshot =
        await _firestore.collection("sponsors").get();
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return SponsorsModel(
          title: data["title"], url: data["url"], imageUrl: data["imageUrl"]);
    }).toList();
  }

  Future<List<EventModel>> getAllEvents() async {
    final QuerySnapshot snapshot = await _firestore.collection("events").get();
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
      // print(snapshot.data() as Map<String, dynamic>);
      return snapshot.data() as Map<String, dynamic>;
    } else {
      return null; // Document with the specified ID does not exist
    }
  }

  Future<List<CourseModel>> getAllCourses() async {
    final QuerySnapshot response = await _firestore.collection("courses").get();
    return response.docs.map((ele) {
      Map<String, dynamic> data = ele.data() as Map<String, dynamic>;
      return CourseModel(
          courseName: data['courseName'],
          courseDesc: data['courseDesc'],
          image: data['image'],
          url: data['courseUrl']);
    }).toList();
  }
}
