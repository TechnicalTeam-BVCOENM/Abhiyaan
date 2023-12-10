import 'package:darpan/file_exporter.dart';
import 'package:darpan/ui/sub_views/academics/class_notes/class_notes_view_component.dart';
part 'class_notes_view_model.dart';

class ClassNotesView extends StatelessWidget {
  const ClassNotesView({super.key});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ClassNotesViewModel>.reactive(
        viewModelBuilder: () => ClassNotesViewModel(),
        builder: (context, model, child) {
          return Scaffold(
              backgroundColor: context.colorScheme.backgroundColor,
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: context
                    .colorScheme.secondaryBlackColor, //change your color here
              ),
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
               child: ListView.builder(
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return ClassNotesViewModel().allSubCards[index];
                      }),
              ),
            ),
          );
        });
  }
}
