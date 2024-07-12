import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/ui/common/cached_network_image.dart';
import 'package:abhiyaan/ui/views/community/community_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

part 'detailed_blogs_view_model.dart';
part 'detailed_blogs_view_components.dart';

class DettailedBlogPage extends StatelessWidget {
  final CommunityBlogsData blogData;
  const DettailedBlogPage({super.key, required this.blogData});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DettailedBlogPageModel>.reactive(
      viewModelBuilder: () => DettailedBlogPageModel(),
      disposeViewModel: true,
      onViewModelReady: (viewModels) => viewModels.init(blogData),
      onDispose: (model) => model.disposeModel(),
      builder: (context, model, child) {
        FontThemeClass fontThemeClass = FontThemeClass();
        final CommunityViewModel communityViewModel = CommunityViewModel();
        return StreamBuilder<int>(
          stream: communityViewModel.getLikesStream(blogData.documentId),
          builder: (context, snapshot) {
            bool isLiked = communityViewModel.localStorageService
                    .read("isLiked_${blogData.documentId}") ??
                false;
            final int streamLikes = snapshot.data ?? 0;
            return Scaffold(
              floatingActionButton: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    backgroundColor: context.colorScheme.accentColor,
                    heroTag: "like",
                    onPressed: () async {
                      model.shareBlog(context, blogData);
                    },
                    child: Icon(
                      Icons.share,
                      color: context.colorScheme.white,
                      fill: 0,
                      size: 25,
                    ),
                  ).animate(delay: 200.ms).scale(),
                  12.horizontalSpace,
                  FloatingActionButton(
                    backgroundColor: context.colorScheme.accentColor,
                    heroTag: "like",
                    onPressed: () async {
                      communityViewModel.updateLikes(
                          blogData.documentId, context);
                    },
                    child: Icon(
                      isLiked
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: isLiked ? Colors.red : Colors.white,
                      fill: isLiked ? 1 : 0,
                      size: 25,
                    ),
                  ).animate(delay: 200.ms).scale(),
                ],
              ),
              appBar: AppBar(
                backgroundColor: context.colorScheme.card,
                surfaceTintColor: context.colorScheme.card,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: context.colorScheme.primaryText,
                  ),
                ),
                title: Text(
                  blogData.title,
                  maxLines: 2,
                  style: fontThemeClass.title2(
                    context,
                    color: context.colorScheme.primaryText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
              ),
              backgroundColor: context.colorScheme.card,
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 18).r,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      12.verticalSpace,
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12).r,
                        child: Hero(
                          transitionOnUserGestures: true,
                          tag: blogData.documentId,
                          child: CachedNetworkImage(
                            imageUrl: blogData.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      4.verticalSpace,
                      Center(
                        child: Text(
                          "image source: ${blogData.title.toLowerCase()}",
                          textAlign: TextAlign.start,
                          style: fontThemeClass.caption(
                            context,
                            color: context.colorScheme.secondaryText,
                          ),
                        ),
                      ),
                      16.verticalSpace,
                      BlogAuthorDetailes(
                        blogData: blogData,
                        streamLikes: streamLikes,
                      ),
                      2.verticalSpace,
                      Divider(
                        thickness: 1.8,
                        endIndent: 300.w,
                        color: context.colorScheme.accentColor,
                      ),
                      12.verticalSpace,
                      Text(
                        blogData.content,
                        textAlign: TextAlign.justify,
                        style: fontThemeClass.body(context),
                      ),
                      90.verticalSpace,
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
