import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/ui/views/community/community_view.dart';
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
      disposeViewModel: false,
      onViewModelReady: (viewModels) => viewModels.init(context),
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
                floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
                  floatingActionButton: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                       FloatingActionButton(
                        heroTag: "share_blog",
                        onPressed: () async {
                          model.shareBlog(context, blogData);
                        },
                        child: const Icon(
                          Icons.share,
                          color: Colors.black,
                          fill: 0,
                          size: 25,
                        ).animate(delay: 500.ms).scale()
                      ),
                      12.verticalSpace, 
                      FloatingActionButton(
                        heroTag: "like",
                        onPressed: () async {
                          communityViewModel.updateLikes(blogData.documentId);
                        },
                        child: isLiked
                            ?  Icon(
                                Icons.favorite_rounded,
                                color: Colors.red,
                                shadows: [
                                  BoxShadow(
                                    color: context.colorScheme.secondaryBlackColor
                                        .withOpacity(0.25),
                                    blurRadius: 20,
                                    spreadRadius: 0.8,
                                  ),
                                ],
                                fill: 1,
                                size: 25,
                              ).animate(delay: 500.ms).scale()
                            : const Icon(
                                Icons.favorite_border_rounded,
                                color: Colors.black,
                                fill: 0,
                                size: 25,
                              ).animate(delay: 500.ms).scale(),
                      ),
                    ],
                  ),
                  appBar: AppBar(
                    title: Text(
                      blogData.title,
                      maxLines: 2,
                      style: fontThemeClass.body(context,
                          color: context.colorScheme.secondaryBlackColor, fontWeight: FontWeight.bold),
                    ),
                    centerTitle: true,
                  ),
                  backgroundColor: context.colorScheme.backgroundColor,
                  body: SafeArea(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 18).r,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          12.verticalSpace,
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12).r,
                            child: Image.network(
                              blogData.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          4.verticalSpace,
                          Center(
                            child: Text(
                              "Reference Image: ${blogData.title.toLowerCase()}",
                              textAlign: TextAlign.start,
                              style: fontThemeClass.caption(context,
                                  color: context
                                      .colorScheme.secondarySectionColor),
                            ),
                          ),
                          32.verticalSpace,
                          Text(
                            blogData.title,
                            textAlign: TextAlign.start,
                            style: fontThemeClass.header(context,
                                color: context.colorScheme.secondaryBlackColor),
                          ),
                          2.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 25.h,
                                width: 25.w,
                                child: ClipOval(
                                  child: Image.network(blogData.authorImageUrl),
                                ),
                              ),
                              12.horizontalSpace,
                              Text(
                                blogData.author,
                                textAlign: TextAlign.center,
                                style: fontThemeClass.caption(context,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                " | ${DateFormat.MMMM().format(blogData.date.toDate())} ${blogData.date.toDate().day}",
                                textAlign: TextAlign.center,
                                style: fontThemeClass.caption(context,
                                    fontWeight: FontWeight.normal,
                                    color: context
                                        .colorScheme.secondarySectionColor),
                              ),
                              const Spacer(),
                              Text(
                                "Likes ${streamLikes.toString()}",
                                textAlign: TextAlign.center,
                                style: fontThemeClass.caption(
                                  context,
                                  fontWeight: FontWeight.normal,
                                  color: context.colorScheme.secondaryBlackColor
                                      .withOpacity(0.85),
                                ),
                              ),
                            ],
                          ),
                          2.verticalSpace,
                          Divider(
                            thickness: 1.8,
                            endIndent: 300.w,
                            color: context.colorScheme.primaryColor,
                          ),
                          12.verticalSpace,
                          Text(
                            blogData.content,
                            textAlign: TextAlign.start,
                            style: fontThemeClass.body(context),
                          ),
                          12.verticalSpace,
                        ],
                      ),
                    ),
                  ));
            });
      },
    );
  }
}
