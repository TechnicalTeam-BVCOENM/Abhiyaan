part of "detailed_blogs_view.dart";

class DettailedBlogPageModel extends BaseViewModel {
  final log = getLogger("DettailedBlogPageModel");
  init(BuildContext context) {}

  void shareBlog(BuildContext context, CommunityBlogsData blogData) async {
    final box = context.findRenderObject() as RenderBox?;
   await Share.share(
        "Hey! Check out this blog on Abhiyaan App: ${blogData.title} by ${blogData.author}.\n\n${blogData.content.substring(0, 150)}...\n\n${blogData.imageUrl}",
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
        subject: "Abhiyaan Blog: ${blogData.title}"
        );
  }
}
