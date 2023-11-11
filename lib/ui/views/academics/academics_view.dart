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
          appBar: AppBar(
            title: Text(
              "Academics",
              style: model.fontTheme.heading2(context).copyWith(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: ListView(
              children: [
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    // crossAxisSpacing: 24.0,
                    mainAxisSpacing: 16.0,
                  ),
                  itemCount: 9,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  // shrinkWrap: true, // Use shrinkWrap to limit the height of the GridView
                  // physics: const NeverScrollableScrollPhysics(), // Disable GridView scrolling
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        // functionality remaining
                        debugPrint("Tapped $index");
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 94.hWise,
                            width: 94.wWise,
                            decoration: BoxDecoration(
                              color: context.colorScheme.secondaryPurpleColor,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5,
                                  color: context.colorScheme.secondaryPurpleColor,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Image(
                                image: AssetImage(model.gridListImages[index]),
                                fit: BoxFit.contain,
                                height: 72.hWise,
                                width: 72.wWise,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
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
                const SectionText(title: "Academics Updates"),
              ],
            ),
          ),
        );
      },
    );
  }
}
