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
            child: Image.network(blogData.authorImageUrl),
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
        Text(
          "Likes ${streamLikes.toString()}",
          textAlign: TextAlign.center,
          style: fontThemeClass.caption(
            context,
            fontWeight: FontWeight.normal,
            color: context.colorScheme.secondaryBlackColor.withOpacity(0.85),
          ),
        ),
      ],
    );
  }
}
