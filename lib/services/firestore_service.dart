import 'package:cloud_firestore/cloud_firestore.dart';
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