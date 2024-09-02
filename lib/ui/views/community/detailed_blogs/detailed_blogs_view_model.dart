part of "detailed_blogs_view.dart";

class DettailedBlogPageModel extends BaseViewModel {
  final log = getLogger("DettailedBlogPageModel");
  final AnalyticsService _analyticsService = locator<AnalyticsService>();

  void init(CommunityBlogsData blogData) {
    _analyticsService.logScreen(screenName: "Detailed Blog Screen Opened");
    _analyticsService.logEvent(
        eventName: "Detailed_Blog_View",
        value: "${blogData.title} Blog Viewed : ${blogData.documentId}");

    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  void shareBlog(BuildContext context, CommunityBlogsData blogData) async {
    final box = context.findRenderObject() as RenderBox?;
    _analyticsService.logEvent(
        eventName: "Share_blog",
        value:
            "${blogData.title} Blog Share button clicked : ${blogData.documentId}");
    await Share.share(
        "Hey! Check out this blog on Abhiyaan App: ${blogData.title} by ${blogData.author}.\n\n${blogData.content.substring(0, 150)}...\n\n${blogData.imageUrl}",
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
        subject: "Abhiyaan Blog: ${blogData.title}");
  }

  void disposeModel() {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: SystemUiOverlay.values);
  }
}
