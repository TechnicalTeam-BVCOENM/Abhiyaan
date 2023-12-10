import 'package:darpan/file_exporter.dart';
import 'package:darpan/ui/sub_views/academics/class_notes/class_notes_components.dart';
part 'class_notes_view_model.dart';

class ClassNotesView extends StatelessWidget {
  const ClassNotesView({super.key});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ClassNotesViewModel>.reactive(
        viewModelBuilder: () => ClassNotesViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: context
                    .colorScheme.secondaryBlackColor, //change your color here
              ),
              backgroundColor: context.colorScheme.backgroundColor,
              elevation: 0,
              title: Text(
                'Class Notes',
                style: FontThemeClass().heading2(context),
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 20.sp, horizontal: 20.sp),
                child: const Column(children: [
                  SubjectCard(
                    leading: AssetImagePath.tcsImg,
                    title: "Theoretical Comp. Science",
                  ),
                  SubjectCard(
                    leading: AssetImagePath.seImg,
                    title: "Software Engineering",
                  ),
                  SubjectCard(
                    leading: AssetImagePath.cnImg,
                    title: "Computer Network",
                  ),
                  SubjectCard(
                    leading: AssetImagePath.dwmImg,
                    title: "Data Warehousing & Mining",
                  ),
                  SubjectCard(
                    leading: AssetImagePath.adbmsImg,
                    title: "Advance DBMS",
                  ),
                  SubjectCard(
                    leading: AssetImagePath.pceImg,
                    title: "PCE II",
                  ),
                  Expanded(child: Text("")),
                ]),
              ),
            ),
            backgroundColor: context.colorScheme.backgroundColor,
          );
        });
  }
}
