part of "detailed_blogs_view.dart";

class BlogAuthorDetailes extends StatelessWidget {
  const BlogAuthorDetailes({
    super.key,
    required this.blogData,
    required this.streamLikes,
  });

  final CommunityBlogsData blogData;

  final int streamLikes;

  @override
  Widget build(BuildContext context) {
    FontThemeClass fontThemeClass = FontThemeClass();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.h,
          width: 25.w,
          child: ClipOval(
            child: CachedNetworkImageWidget(
              imageUrl: blogData.authorImageUrl,
              height: 25.h,
              width: 25.w,
              maxHeightDiskCache: 500,
            ),
          ),
        ),
        12.horizontalSpace,
        Text(
          blogData.author,
          textAlign: TextAlign.center,
          style: fontThemeClass.caption(context, fontWeight: FontWeight.w500),
        ),
        Text(
          " | ${DateFormat.MMMM().format(blogData.date.toDate())} ${blogData.date.toDate().day}",
          textAlign: TextAlign.center,
          style: fontThemeClass.caption(context,
              fontWeight: FontWeight.normal,
              color: context.colorScheme.secondarySectionColor),
        ),
        const Spacer(),
        SizedBox(
          width: 80.w,
          height: 25.h,
          child: Stack(
            children: [
              for (int i = 0; i < (streamLikes > 4 ? 4 : streamLikes); i++)
                Positioned(
                  right: (15.0 * (i)).w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12).r,
                    clipBehavior: Clip.hardEdge,
                    child: SizedBox(
                      width: 25.w,
                      height: 25.h,
                      child: CachedNetworkImageWidget(
                        height: 25.h,
                        width: 25.w,
                        imageUrl: AssetUrls.dummyImageUrl,
                        maxHeightDiskCache: 80,
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
        4.horizontalSpace,
        streamLikes > 4
            ? Text(
                "+ ${(streamLikes - 4).toString()} likes",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )
            : Text(
                "Likes ${streamLikes.toString()}",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
      ],
    );
  }
}
