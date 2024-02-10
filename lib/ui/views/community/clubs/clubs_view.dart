import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/ui/common/circular_loading_indicator.dart';
import 'package:abhiyaan/ui/common/toast_message.dart';
import 'package:abhiyaan/ui/common/url_launcher.dart';
import 'package:abhiyaan/ui/views/community/community_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: context.colorScheme.scaffoldBackgroundColor,
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
                clubLink: clubsData.clubLink,
              ),
            ],
          ),
        );
        // );
      },
    );
  }
}
