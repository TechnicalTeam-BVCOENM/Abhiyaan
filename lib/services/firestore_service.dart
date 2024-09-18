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

  Future<List<ClubsDataModel>> getClubsData(
      {required String collectionName}) async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection(collectionName).get();

      final List<ClubsDataModel> result = snapshot.docs.map((doc) {
        final Object? data = doc.data();
        final Map<String, dynamic>? dataMap = data as Map<String, dynamic>?;

        // Safely cast dynamic data to List<Map<String, dynamic>> for clubMembers
        final List<dynamic>? leadsData = dataMap?["leads"] as List<dynamic>?;
        final List<ClubMemberInfo> leads = leadsData != null
            ? leadsData.map((e) {
                final Map<String, dynamic> leadData = e as Map<String, dynamic>;
                return ClubMemberInfo(
                  name: leadData['name'] ?? '',
                  image: leadData['image'] ?? '',
                  position: leadData['position'] ?? '',
                );
              }).toList()
            : [];

        // Safely cast dynamic data to List<Map<String, dynamic>> for fests
        final List<dynamic>? festsData = dataMap?["fests"] as List<dynamic>?;
        final List<FestInfo> fests = festsData != null
            ? festsData.map((e) {
                final Map<String, dynamic> festData = e as Map<String, dynamic>;
                return FestInfo(
                  festName: festData['name'] ?? '',
                  festImage: festData['image'] ?? '',
                  festLink: festData['link'] ?? '',
                );
              }).toList()
            : [];

        String clubName = dataMap?['clubName'] ?? '';
        String clubLink = dataMap?['clubLink'] ?? '';
        String clubShortHand = dataMap?['clubShortHand'] ?? '';
        String clubImage = dataMap?['clubImage'] ?? '';

        return ClubsDataModel(
          clubName: clubName,
          clubShortHand: clubShortHand,
          clubImage: clubImage,
          clubMembers: leads,
          clubFest: fests,
          clubLink: clubLink,
        );
      }).toList();

      return result;
    } on Exception catch (e) {
      log.e("Error in getting $collectionName clubs data : ${e.toString()}");
      return [];
    }
  }

  Future<List<String>> getHighlights() async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection("highlights").limit(4).get();

      if (snapshot.docs.isEmpty) {
        return [];
      }
      return snapshot.docs.map((doc) => doc["imageUrl"] as String).toList();
    } on Exception catch (e) {
      log.e("Error in getting highlights : ${e.toString()}");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getBestMoments(String docId) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('Events')
          .doc('data')
          .collection('events')
          .doc(docId)
          .collection("bestMoments")
          .get();
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } on Exception catch (e) {
      log.e("Error in getting bestMoments : ${e.toString()}");
      return [];
    }
  }

  Future<List<DepartmentUpdates>> getCollegeUpdates() async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection("updates")
          .orderBy("date", descending: true)
          .limit(6)
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
            url: data['url'] ?? '',
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
            docID: doc.id);
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
              content: data["content"]);
        }).toList();
      }
    } catch (e) {
      log.e("Error in getting blogs data from firebase : ${e.toString()}");
      return [];
    }
  }

  Future<bool> showRegistration() async {
    try {
      final response =
          await _firestore.collection('AppCheck').doc("showRegistration").get();
      final success = response.data() as Map<String, dynamic>;
      final bool value = success["value"];
      return value;
    } catch (e) {
      log.e("Error in showing register button from firebase : ${e.toString()}");
      return false;
    }
  }

// Future<List<EventModel>> getGalleryImages() async {
//   try {
//     final QuerySnapshot snapshot = await _firestore.collection("gallery").get();
//     return snapshot.docs.map((doc) {
//       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//       return EventModel(
//           title: data['title'],
//           startDate: data['startDate'],
//           endDate: data['endDate'],
//           location: data['location'],
//           imageUrl: data['imageUrl'],
//           cName: data['coordinatorName'],
//           cEmail: data['coordinatorEmail'],
//           cPhone: data['coordinatorPhone'],
//           about: data['about'],
//           registerUrl: data['registerUrl'],
//           docID: doc.id);
//     }).toList();
//   } on Exception catch (e) {
//     log.e("Error in getting events : ${e.toString()}");
//     return []; // return an empty list on error
//   }
// }

  Future<List<GalleryModel>> getGalleryImages() async {
    try {
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection("Gallery").get();

      List<GalleryModel> galleryList = [];

      // Iterate over each document in the snapshot
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        // Access the data of each document using doc.data()
        final data =
            doc.data() as Map<String, dynamic>; // Cast to Map<String, dynamic>
        // Add null check before accessing properties of data
        galleryList.add(
          GalleryModel(
            logoUrl: data['LogoUrl'] ?? "null",
            themeName: data['ThemeName'] ?? "null",
            year: data['year'] ?? 0,
            abhiyaan: data['abhiyaan'] ?? {},
            cultural: data['cultural'] ?? {},
            sports: data['sports'] ?? {},
          ),
        );
      }

      // Return the list of GalleryModel objects

      return galleryList;
    } catch (e) {
      log.e("Error in getting events : ${e.toString()}");
      // Handle error by throwing the exception
      rethrow;
    }
  }

  Future<List<MemoriesModel>> getAllMemories() async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection("Events")
          .doc('data')
          .collection('bestMemories')
          .get();
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return MemoriesModel(imageUrl: data['imageUrl']);
      }).toList();
    } on Exception catch (e) {
      log.e("Error in getting events : ${e.toString()}");
      return [];
    }
  }
}
