import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/ui/views/community/community_view.dart';
import 'package:flutter_animate/flutter_animate.dart';
part 'clubs_view_model.dart';
part 'clubs_view_components.dart';

class ClubsView extends StatelessWidget {
  final DepartmentalClubsData clubsData;
  const ClubsView({super.key, required this.clubsData});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ClubsViewModel>.reactive(
      viewModelBuilder: () => ClubsViewModel(clubsData),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: context.colorScheme.backgroundColor,
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              ClubsAppBar(
                clubShortHand: clubsData.clubShortHand,
              ),
              ClubsData(
                clubName: clubsData.clubName,
                clubImage: clubsData.clubImage,
                clubShortHand: clubsData.clubShortHand,
                clubMembers: clubsData.clubMembers,
                clubFest: clubsData.clubFest,
              ),
            ],
          ),
        );
        // );
      },
    );
  }
}
