import 'package:darpan/file_exporter.dart';
import 'package:darpan/ui/views/event/event_view.dart';
import 'package:darpan/ui/views/home/home_view.dart';
import 'package:darpan/ui/views/profile/profile_view.dart';
import 'package:darpan/utils/extension.dart';

part 'bottom_nav_view_model.dart';
part 'bottom_nav_view_components.dart';

class BottomNavView extends StatelessWidget {
  const BottomNavView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BottomNavViewModel>.reactive(
        onViewModelReady: (model) => model.init(),
        viewModelBuilder: () => BottomNavViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            extendBody: true,
            body: WillPopScope(
              onWillPop: model.onPop,
              child: model.getViewForCurrentIndex(model.currentIndex),
            ),
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.wWise),
                  topRight: Radius.circular(15.wWise),
                ),
                child: BottomAppBar(
                  clipBehavior: Clip.antiAlias,
                  elevation: 8,
                  color: context.colorScheme.bottomNavBarBg,
                  child: BottomNavigationBar(
                    backgroundColor: context.colorScheme.bottomNavBarBg,
                    elevation: 0,
                    landscapeLayout:
                        BottomNavigationBarLandscapeLayout.centered,
                    selectedItemColor:
                        context.colorScheme.selectedBottomNavIcon,
                    unselectedItemColor:
                        context.colorScheme.unSelectedBottomNavIcon,
                    type: BottomNavigationBarType.fixed,
                    selectedLabelStyle: const TextStyle(fontSize: 0),
                    currentIndex: model.currentIndex,
                    onTap: model.setIndex,
                    items: [
                      BottomNavigationBarItem(
                        backgroundColor:
                            context.colorScheme.selectedBottomNavIconbg,
                        label: '',
                        icon: const Icon(Icons.home_filled),
                        activeIcon: const BottomNavActiveIcon(
                          icon: Icons.home_filled,
                          text: "Home",
                        ),
                      ),
                      BottomNavigationBarItem(
                        backgroundColor:
                            context.colorScheme.selectedBottomNavIconbg,
                        label: '',
                        icon: const Icon(Icons.book),
                        activeIcon: const BottomNavActiveIcon(
                          icon: Icons.menu_book_sharp,
                          text: "Academics",
                        ),
                      ),
                      const BottomNavigationBarItem(
                        label: '',
                        icon: Icon(Icons.calendar_month_outlined),
                        activeIcon: BottomNavActiveIcon(
                          icon: Icons.calendar_month_outlined,
                          text: "Event",
                        ),
                      ),
                      const BottomNavigationBarItem(
                        label: '',
                        icon: Icon(Icons.person_2_outlined),
                        activeIcon: BottomNavActiveIcon(
                          icon: Icons.person_2_outlined,
                          text: "Profile",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
