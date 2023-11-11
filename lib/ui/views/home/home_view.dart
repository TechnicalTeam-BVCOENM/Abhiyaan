import 'package:darpan/file_exporter.dart';
import 'package:darpan/services/auth_service.dart';
import 'package:darpan/utils/extension.dart';
import 'home_view_component.dart';
part 'home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    FontThemeClass fontTheme = FontThemeClass();
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) {
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Hey ${model.user} 👋',
                            style:fontTheme.appBarText(context),),
                        IconButton(
                          splashRadius: 30,
                          splashColor: context.colorScheme.backgroundColor,
                          icon: Icon(
                            Icons.notifications_none_rounded,
                            size: 24.hWise,
                          ),
                          onPressed: () {
                            model.signOut();
                          },
                        )
                      ],
                    ),
                  ),
                  // Highlights
                  const SectionText(
                    title: "Highlights",
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 220.hWise,
                    child: PageView.builder(
                        itemCount: model.currentIndex,
                        controller: model.pageController,
                        pageSnapping: true,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(left: 8.0),
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
                        effect: JumpingDotEffect(
                          dotColor: context.colorScheme.secondarySectionColor,
                          activeDotColor: context.colorScheme.primaryColor,
                          dotHeight: 8,
                          dotWidth: 8,
                        ),
                      ),
                    ),
                  ),
                  // Quick Links
                  const SectionText(title: "Quick Links"),
                  horizontalStoryRow(context, model.quickLinksList,50),
                  // Activity
                  const SectionText(
                    title: "Activity",
                  ),
                  Container(
                    height: 135.hWise,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: context.colorScheme.secondaryWhiteColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  // Department Updates
                  const SectionText(
                    title: "Department Updates",
                  ),
                  for (var i = 0; i < model.departmentUpdatesList.length; i++)
                    updatesCard(model, i, context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

 
