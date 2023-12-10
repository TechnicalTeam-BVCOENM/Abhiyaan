import 'package:darpan/file_exporter.dart';
import 'package:darpan/ui/sub_views/home/Societies/societies_view_component.dart';
part 'societies_view_model.dart';

class SocietiesView extends StatelessWidget {
  const SocietiesView({super.key});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SocietiesViewModel>.reactive(
        viewModelBuilder: () => SocietiesViewModel(),
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
                'Societies',
                style: FontThemeClass().heading2(context),
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 20.sp, horizontal: 20.sp),
                child: const Column(children: [
                  SocietyCard(
                    title: "Nautanki",
                    value: "The Nautanki Club is where dreams take center stage, and reality plays a supporting role.",
                    leading: AssetImagePath.nautankiImg,
                  ),
                  SocietyCard(
                    title: "Crew 5678",
                    value: "Dance is the hidden language of the soul, and in our crew, we speak it fluently.",
                    leading: AssetImagePath.crew_5678Img,
                  ),
                  SocietyCard(
                    title: "CamEra",
                    value: "Photography is the art of frozen time. Our club, the artists of the shutter, freeze memories to last a lifetime.",
                    leading: AssetImagePath.camEraImg,
                  ),
                  SocietyCard(
                    title: "Literature",
                    value: "Literature is art of crafting world with words, & our club is a canvas where literary masterpieces come to life.",
                    leading: AssetImagePath.literatureImg,
                  ),
                  SocietyCard(
                    title: "Mudrakala",
                    value: "Within the strokes of our imagination, the Mudrakala Club unveils a gallery of creativity.",
                    leading: AssetImagePath.mudrakalaImg,
                  ),
                  SocietyCard(
                    title: "Crescendo",
                    value: "Club where individual notes unite in a symphony of diversity, composing the vibrant melody of our shared passion.",
                    leading: AssetImagePath.crescendoImg,
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
