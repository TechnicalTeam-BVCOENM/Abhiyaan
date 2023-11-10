import 'package:darpan/file_exporter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

part 'home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text('Hey ${model.user} 👋',
                style: FontThemeClass().appBarText),
            automaticallyImplyLeading: false,
            elevation: 0,
            actions: [
              IconButton(
                splashRadius: 24,
                splashColor: ColorThemeClass.backgroundColor,
                icon: const Icon(Icons.notifications_none_rounded, size: 24),
                onPressed: () {},
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionText(
                    title: "Highlights",
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 220,
                    child: PageView.builder(
                        itemCount: model.currentIndex,
                        controller: model.pageController,
                        pageSnapping: true,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: const DecorationImage(
                                image: NetworkImage(
                                  'https://bvcoenm.edu.in/wp-content/uploads/2022/08/sih2.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 9.0),
                    child: Center(
                      child: SmoothPageIndicator(
                        controller: model.pageController,
                        count: model.currentIndex,
                        effect: const JumpingDotEffect(
                          dotColor: ColorThemeClass.secondarySectionColor,
                          activeDotColor: ColorThemeClass.primaryColor,
                          dotHeight: 8,
                          dotWidth: 8,
                          // expansionFactor: 4,
                        ),
                      ),
                    ),
                  ),
                  const SectionText(
                    title: "Activity",
                  ),
                  Container(
                    height: 135,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: ColorThemeClass.secondaryWhiteColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const SectionText(
                    title: "Department Updates",
                  ),
                  for (var i = 0; i < model.currentIndex; i++)
                    Container(
                      height: 135,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: ColorThemeClass.secondaryWhiteColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(model.departmentUpdatesList[i].name,
                                    style: const TextStyle(
                                      color: ColorThemeClass.primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                    )),
                                Text(
                                  "Posted ${model.departmentUpdatesList[i].date}",
                                  style: const TextStyle(
                                    color:
                                        ColorThemeClass.secondarySectionColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8),
                            child: Text(
                              "${model.departmentUpdatesList[i].description}...",
                              style: FontThemeClass().paragraph(),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SectionText extends StatelessWidget {
  const SectionText({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 18, bottom: 8),
      child: Text(
        title,
        style: FontThemeClass().subHeading2(),
      ),
    );
  }
}
