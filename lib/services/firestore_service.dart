import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darpan/app/app.locator.dart';
import 'package:darpan/services/local_storage_service.dart';
import 'package:darpan/ui/sub_views/academics/syllabus/syllabus_view.dart';
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
    final QuerySnapshot snapshot = await _firestore
        .collection(collection)
        .doc('12')
        .collection('updates')
        .get();
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return DepartmentUpdates(
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        date: data['date'] ?? '',
      );
    }).toList();
  }

  Future<List<AcademicsUpdates>> getAllAcademicData(String collection) async {
    final QuerySnapshot snapshot =
        await _firestore.collection(collection).doc('12').collection('1').get();
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return AcademicsUpdates(
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        date: data['date'] ?? '',
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

  Future<List<Syllabus>> getAllSyllabus(String collection) async {
    final localStorageService = locator<LocalStorageService>();
    final QuerySnapshot snapshot = await _firestore
        .collection(collection)
        .doc(localStorageService.read('departmentCodeDatabase'))
        .collection('academics')
        .doc('semester')
        .collection('1_sem')
        .doc('1_sem')
        .collection('syllabus')
        .get();
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Syllabus(
        subjectName: data['subjectName'] ?? '',
        imageUrl: data['imageUrl'] ?? '',
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
}
