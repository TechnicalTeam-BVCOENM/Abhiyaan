import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darpan/common/update_component.dart';
import 'package:darpan/services/firestore_service.dart';
import 'package:darpan/file_exporter.dart';
import 'package:darpan/ui/views/academics/academics_view_component.dart';
part 'academics_view_model.dart';

class AcademicsView extends StatelessWidget {
  const AcademicsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AcademicsViewModel>.reactive(
      viewModelBuilder: () => AcademicsViewModel(),
      onViewModelReady: (viewModel) => viewModel.loadData(),
      builder: (context, model, child) {
        return Scaffold(
          body: model.isBusy
              ? const AcademicsShimmerLoadingWidget()
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollBehavior: const MaterialScrollBehavior().copyWith(overscroll: false),
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 18.0, bottom: 12.0),
                            child: Text(
                              "Academics",
                              textAlign: TextAlign.center,
                              style: model.fontTheme.appBarText(context).copyWith(
                                    color: context.colorScheme.primaryColor,
                                  ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(child: SizedBox(height: 2.h)),
                        SliverGrid(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 16.0,
                            // crossAxisSpacing: 16.0,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            childCount: 9,
                            (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  // Functionality remaining
                                  debugPrint("Tapped $index");
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 90.r,
                                      height: 90.r,
                                      decoration: BoxDecoration(
                                        color: context.colorScheme.secondaryLPurpleColor,
                                        borderRadius: BorderRadius.circular(25),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 5,
                                            color: context.colorScheme.secondaryLPurpleColor,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Image(
                                          image: AssetImage(model.gridListImages[index]),
                                          fit: BoxFit.contain,
                                          height: 72.r,
                                          width: 72.r,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      model.gridListTitle[index],
                                      style: model.fontTheme.subHeading2(
                                        context,
                                        context.colorScheme.secondarySectionColor,
                                      ),
                                      textAlign: TextAlign.center,
                                      softWrap: false,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SliverToBoxAdapter(child: SizedBox(height: 12.h)),
                        const SliverToBoxAdapter(
                          child: SectionText(title: "Academics Updates"),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            childCount: model._academicsUpdates.length,
                            (BuildContext context, int index) {
                              return updatesCard(model._academicsUpdates, index, context, model);
                            },
                          ),
                        ),
                        SliverToBoxAdapter(child: SizedBox(height: 8.h)),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
