import 'package:darpan/file_exporter.dart';

Widget subjectCard(List syllabusList, int i, BuildContext context, viewModel) {
  return ListView.builder(
      itemCount: i,
      itemBuilder: (ctx, index) {
        return GestureDetector(
          onTap: () => viewModel.navigateToSubject(),
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(120.0),
                child: Image.network(
                  syllabusList[index].imageUrl,
                  width: 54.sp,
                  height: 60.sp,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                syllabusList[index].subjectName,
                style: viewModel.fontTheme.heading4(context),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Icon(
                Icons.navigate_next_rounded,
                color: context.colorScheme.secondaryBlackColor,
                size: 30.sp,
              ),
              tileColor: context.colorScheme.secondaryWhiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
        );
      });
}
