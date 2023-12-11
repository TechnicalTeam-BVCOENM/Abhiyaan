import 'package:darpan/file_exporter.dart';
import 'package:darpan/ui/sub_views/academics/practicals/practicals_view_components.dart';

part 'practicals_view_model.dart';

class PracticalsView extends StatelessWidget {
  const PracticalsView({super.key});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PracticalsViewModel>.reactive(
        viewModelBuilder: () => PracticalsViewModel(),
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
                'Practicals',
                style: FontThemeClass().heading2(context),
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20).r,
                child: ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return PracticalsViewModel().allSubCards[index];
                    }),
              ),
            ),
          );
        });
  }
}
