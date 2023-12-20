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
          FontThemeClass fontThemeClass = FontThemeClass();
          return Scaffold(
              backgroundColor: context.colorScheme.backgroundColor,
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color: context
                      .colorScheme.secondaryBlackColor, //change your color here
                ),
                elevation: 0,
                title: Text(
                  "Sigma's",
                  style: fontThemeClass.header(context,
                      color: context.colorScheme.secondaryBlackColor),
                ),
                centerTitle: true,
                backgroundColor: context.colorScheme.backgroundColor,
              ),
              body: SafeArea(
                minimum: const EdgeInsets.symmetric(horizontal: 18).r,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: model.allsocietyCards.length,
                    itemBuilder: (context, index) {
                      return SocietyCard(
                        title: model.allsocietyCards[index].title,
                        value: model.allsocietyCards[index].value,
                        leading: model.allsocietyCards[index].leading,
                      );
                    }),
              ));
        });
  }
}
