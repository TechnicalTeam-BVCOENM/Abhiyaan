import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/ui/views/home/Societies/societies_view_component.dart';
part 'societies_view_model.dart';

class SocietiesView extends StatelessWidget {
  const SocietiesView({super.key});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SocietiesViewModel>.reactive(
        viewModelBuilder: () => SocietiesViewModel(),
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
                  'Societies',
                  style: FontThemeClass().header(context),
                ),
                centerTitle: true,
                backgroundColor: context.colorScheme.backgroundColor,
              ),
              body: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20)
                          .r
                          .r,
                  child: ListView.builder(
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return model.allsocietyCards[index];
                      }),
                ),
              ));
        });
  }
}
