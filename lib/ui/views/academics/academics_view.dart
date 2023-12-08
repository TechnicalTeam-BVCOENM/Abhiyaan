import 'package:darpan/file_exporter.dart';

part 'academics_view_model.dart';

class AcademicsView extends StatelessWidget {
  const AcademicsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AcademicsViewModel>.reactive(
      viewModelBuilder: () => AcademicsViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          // ** 1 ** //

          // appBar: AppBar(
          //   elevation: 0,
          //   centerTitle: true,
          //   backgroundColor: context.colorScheme.secondaryLPurpleColor,
          //   title: Text(
          //     "Academics",
          //     style: model.fontTheme.heading3(context).copyWith(
          //           color: context.colorScheme.primaryColor,
          //           fontWeight: FontWeight.bold,
          //         ),
          //   ),
          // ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                scrollBehavior: const MaterialScrollBehavior().copyWith(overscroll: false),
                slivers: [
                  // ** 2 ** //

                  // SliverToBoxAdapter(
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(vertical: 18.0),
                  //     child: Text(
                  //       "Academics",
                  //       textAlign: TextAlign.center,
                  //       style: model.fontTheme.appBarText(context).copyWith(
                  //             color: context.colorScheme.primaryColor,
                  //           ),
                  //     ),
                  //   ),
                  // ),
                  const SliverToBoxAdapter(
                    child: SectionText(title: "Academics"),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 2.sp)),
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
                                height: 86.sp,
                                width: 86.sp,
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
                                    height: 70.sp,
                                    width: 70.sp,
                                  ),
                                ),
                              ),
                              Text(
                                model.gridListTitle[index],
                                style: model.fontTheme
                                    .subHeading2(
                                      context,
                                      context.colorScheme.secondarySectionColor,
                                    )
                                    .copyWith(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                                softWrap: false,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 12.sp)),
                  const SliverToBoxAdapter(
                    child: SectionText(title: "Academics Updates"),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: model.academicsUpdatesList.length,
                      (BuildContext context, int index) {
                        return Card(
                          clipBehavior: Clip.hardEdge,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: context.colorScheme.secondaryLPurpleColor,
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      model.academicsUpdatesList[index].title,
                                      style: model.fontTheme.subHeading(context, context.colorScheme.primaryColor),
                                    ),
                                    Text(
                                      "Posted on ${model.academicsUpdatesList[index].postedOn}",
                                      style: model.fontTheme.smallSubHeading(context),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12.sp),
                                Text(model.academicsUpdatesList[index].description),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 8.sp)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
