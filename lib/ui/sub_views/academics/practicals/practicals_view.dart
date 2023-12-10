import 'package:darpan/file_exporter.dart';
part 'practicals_view_model.dart';

class PracticalsView extends StatelessWidget {
  const PracticalsView({super.key});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PracticalsViewModel>.reactive(
        viewModelBuilder: () => PracticalsViewModel(),
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
                'Practicals',
                style: FontThemeClass().heading2(context),
              ),
              centerTitle: true,
            ),
            backgroundColor:
                context.colorScheme.backgroundColor, // Background color
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Coming Soon !',
                    style: FontThemeClass().heading(context,
                        color: context.colorScheme.primaryColor),
                  ),
                  4.verticalSpace,
                  Text(
                    'Amazingness in progress. Stay tuned !',
                    style: FontThemeClass().subHeading2(
                        context, context.colorScheme.secondarySectionColor),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
