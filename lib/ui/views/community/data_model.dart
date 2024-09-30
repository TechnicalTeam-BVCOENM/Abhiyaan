part of 'community_view.dart';

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
