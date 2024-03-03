import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/ui/views/community/community_view.dart';
import 'package:abhiyaan/ui/views/event/event_view.dart';
import 'package:abhiyaan/ui/views/home/home_view.dart';
import 'package:abhiyaan/ui/views/profile/profile_view.dart';

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
          body: PopScope(
            canPop: model._canPopNow,
            onPopInvoked: (bool didPop) async {
              if (!didPop) {
                await ShowAppExitPopUp.showAppExitPopUp(context).then(
                  (value) => {
                    if (value) {model._canPopNow = true}
                  },
                );
              }
            },
            child: model.getViewForCurrentIndex(model.currentIndex),
          ),
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              backgroundColor: context.colorScheme.primaryCardColor,
              elevation: 0,
              landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
              selectedItemColor: context.colorScheme.primaryAccentColor,
              unselectedItemColor: context.colorScheme.unSelectedBottomNavIcon,
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: const TextStyle(fontSize: 0),
              currentIndex: model.currentIndex,
              onTap: model.setIndex,
              items: [
                BottomNavigationBarItem(
                  backgroundColor: context.colorScheme.primaryAccentColor,
                  label: '',
                  icon: const Icon(Icons.home_rounded),
                  activeIcon: const BottomNavActiveIcon(
                    icon: Icons.home_outlined,
                    text: "Home",
                  ),
                ),
                const BottomNavigationBarItem(
                  label: '',
                  icon: Icon(Icons.group_rounded),
                  activeIcon: BottomNavActiveIcon(
                    icon: Icons.group_outlined,
                    text: "Community",
                  ),
                ),
                const BottomNavigationBarItem(
                  label: '',
                  icon: Icon(Icons.calendar_month_rounded),
                  activeIcon: BottomNavActiveIcon(
                    icon: Icons.calendar_month_outlined,
                    text: "Events",
                  ),
                ),
                const BottomNavigationBarItem(
                  label: '',
                  icon: Icon(Icons.person),
                  activeIcon: BottomNavActiveIcon(
                    icon: Icons.person_outline_rounded,
                    text: "Profile",
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
