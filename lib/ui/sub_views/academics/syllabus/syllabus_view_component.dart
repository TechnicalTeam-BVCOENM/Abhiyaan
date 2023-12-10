import 'package:darpan/file_exporter.dart';

Widget subjectCard(List syllabusList, int i, BuildContext context, viewModel) {
  return ListView.builder(
      itemCount: i,
      itemBuilder: (ctx, index) {
        return ListTile(
            leading: Image(image: NetworkImage(syllabusList[index].imageUrl)),
            title: Text(
              syllabusList[index].subjectName,
              style: viewModel.fontTheme.heading4(context),
            ),
            trailing: const Icon(Icons.forward_rounded),
            tileColor: context.colorScheme.secondaryWhiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ));
      });
}
