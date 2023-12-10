import 'package:darpan/file_exporter.dart';
import 'package:darpan/ui/sub_views/academics/pyqs/pyqs_view_component.dart';
part 'pyqs_view_model.dart';

class PyqsView extends StatelessWidget {
  const PyqsView({super.key});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PyqsViewModel>.reactive(
        viewModelBuilder: () => PyqsViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: context.colorScheme.backgroundColor,
            appBar: AppBar(
              backgroundColor: context.colorScheme.backgroundColor,
              foregroundColor: context.colorScheme.secondaryBlackColor,
              iconTheme: IconThemeData(
                color: context
                    .colorScheme.secondaryBlackColor, //change your color here
              ),
              elevation: 0,
              title: Text(
                "PYQ's",
                style: FontThemeClass().heading2(context),
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20).r,
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return PyqsViewModel().allSubCards[index];
                    }),
              ),
            ),
          );
        });
  }
}
