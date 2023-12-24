import 'package:cloud_firestore/cloud_firestore.dart';

class CelebrationData {
  String title;
  String description;
  String image;
  Timestamp startdate;

  CelebrationData(
      {required this.title,
      required this.description,
      required this.image,
      required this.startdate});
}
