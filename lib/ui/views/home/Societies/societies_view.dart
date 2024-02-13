import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/ui/views/home/Societies/societies_view_component.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
            backgroundColor: context.colorScheme.scaffoldBackgroundColor,
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: context.colorScheme.primaryTextColor,
              ),
              elevation: 0,
              surfaceTintColor: context.colorScheme.scaffoldBackgroundColor,
              title: Text(
                "Sigma's",
                style: fontThemeClass.title(
                  context,
                  color: context.colorScheme.primaryTextColor,
                ),
              ),
              centerTitle: true,
              backgroundColor: context.colorScheme.scaffoldBackgroundColor,
            ),
            body: SafeArea(
              minimum: const EdgeInsets.symmetric(horizontal: 18).r,
              child: SingleChildScrollView(
                child: StaggeredGrid.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    StaggeredGridTile.fit(
                      crossAxisCellCount: 1,
                      child: SocietyCard(
                        title: model.allsocietyCards[0].title,
                        value: model.allsocietyCards[0].value,
                        leading: model.allsocietyCards[0].leading,
                        url: model.allsocietyCards[0].url,
                      ),
                    ),
                    StaggeredGridTile.fit(
                      crossAxisCellCount: 1,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0).r,
                          child: Text(
                            "Diverse clubs unite in a hub, crafting a symphony of passion.",
                            textAlign: TextAlign.center,
                            style: fontThemeClass.caption(
                              context,
                              color: context.colorScheme.primaryTextColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    StaggeredGridTile.fit(
                      crossAxisCellCount: 1,
                      child: SocietyCard(
                        title: model.allsocietyCards[1].title,
                        value: model.allsocietyCards[1].value,
                        leading: model.allsocietyCards[1].leading,
                        url: model.allsocietyCards[1].url,
                      ),
                    ),
                    StaggeredGridTile.fit(
                      crossAxisCellCount: 1,
                      child: SocietyCard(
                        title: model.allsocietyCards[2].title,
                        value: model.allsocietyCards[2].value,
                        leading: model.allsocietyCards[2].leading,
                        url: model.allsocietyCards[2].url,
                      ),
                    ),
                    StaggeredGridTile.fit(
                      crossAxisCellCount: 1,
                      child: SocietyCard(
                        title: model.allsocietyCards[3].title,
                        value: model.allsocietyCards[3].value,
                        leading: model.allsocietyCards[3].leading,
                        url: model.allsocietyCards[3].url,
                      ),
                    ),
                    StaggeredGridTile.fit(
                      crossAxisCellCount: 1,
                      child: SocietyCard(
                        title: model.allsocietyCards[4].title,
                        value: model.allsocietyCards[4].value,
                        leading: model.allsocietyCards[4].leading,
                        url: model.allsocietyCards[4].url,
                      ),
                    ),
                    StaggeredGridTile.fit(
                      crossAxisCellCount: 1,
                      child: SocietyCard(
                        title: model.allsocietyCards[5].title,
                        value: model.allsocietyCards[5].value,
                        leading: model.allsocietyCards[5].leading,
                        url: model.allsocietyCards[5].url,
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
