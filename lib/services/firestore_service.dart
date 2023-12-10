import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darpan/ui/sub_views/academics/courses/courses_view.dart';
import 'package:darpan/file_exporter.dart';
import 'package:darpan/ui/sub_views/academics/syllabus/syllabus_view.dart';
import 'package:darpan/ui/sub_views/academics/timetable/timetable_view.dart';
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
    String semester = "${localStorageService.read('userSem')}_sem";
    final QuerySnapshot snapshot = await _firestore
        .collection(collection)
        .doc(localStorageService.read('departmentCodeDatabase'))
        .collection('academics')
        .doc('semester')
        .collection(semester)
        .doc(semester)
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

  Future<List<LectureDataModel>> getTimeTableData(String day) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection("Department")
          .doc('12_computer')
          .collection('academics')
          .doc('semester')
          .collection('1_sem')
          .doc('1_sem')
          .collection('timeTable')
          .doc(day)
          .get();

      if (snapshot.exists) {
        final Map<String, dynamic> data = snapshot.data()!;

        debugPrint("statement");
        debugPrint(data.toString());

        // Assuming 'lectures' is the field containing the array of maps
        final List<dynamic>? lectures = data['lectures'];

        if (lectures != null) {
          return lectures.map((dynamic lecture) {
            Map<String, dynamic> lectureData = lecture as Map<String, dynamic>;
            return LectureDataModel(
              subjectName: lectureData['subjectName'] ?? '',
              startTime: lectureData['startTime'] ?? '',
              subjectTeacherName: lectureData['subjectTeacher'] ?? '',
            );
          }).toList();
        }
      }

      // Handle the case when the document doesn't exist or the array is null
      debugPrint("Document does not exist or the array is null");
      return [];
    } catch (e) {
      // Handle any other exceptions that might occur during the process
      debugPrint("Error fetching data: $e");
      return [];
    }
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
    final QuerySnapshot response = await _firestore
        .collection("Department")
        .doc('12_computer')
        .collection('academics')
        .doc('semester')
        .collection('1_sem')
        .doc('1_sem')
        .collection('courses')
        .get();
    return response.docs.map((ele) {
      Map<String, dynamic> data = ele.data() as Map<String, dynamic>;
      return CourseModel(
          courseName: data['title'],
          courseDesc: data['description'],
          image: data['image'],
          url: data['url']);
    }).toList();
  }
}
