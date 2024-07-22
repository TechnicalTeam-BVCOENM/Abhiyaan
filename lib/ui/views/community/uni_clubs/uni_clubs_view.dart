import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/ui/common/circular_loading_indicator.dart';
// import 'package:abhiyaan/ui/common/toast_message.dart';
import 'package:abhiyaan/ui/common/url_launcher.dart';
import 'package:abhiyaan/ui/views/community/community_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';
part 'uni_clubs_view_model.dart';
part 'uni_clubs_view_components.dart';

class UniClubsView extends StatelessWidget {
  final UniversalClubsData universalClubsData;
  const UniClubsView({super.key, required this.universalClubsData});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UniClubsViewModel>.nonReactive(
      viewModelBuilder: () => UniClubsViewModel(universalClubsData),
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: context.colorScheme.scaffold,
            elevation: 0,
            forceMaterialTransparency: true,
            leading: GestureDetector(
              onTap: () {
                model._navigationService.back();
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                color: context.colorScheme.primaryText,
              ),
            ),
            title: Text(
              universalClubsData.uniclubShortHand,
              style: FontThemeClass().header(
                context,
                color: context.colorScheme.primaryText,
              ),
            ),
          ),
          backgroundColor: context.colorScheme.scaffold,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                UniversalClubsData(
                  uniclubName: universalClubsData.uniclubName,
                  uniclubImage: universalClubsData.uniclubImage,
                  uniclubShortHand: universalClubsData.uniclubShortHand,
                  uniclubMembers: universalClubsData.uniclubMembers,
                  // uniclubFest: universalClubsData.uniclubFest,
                  uniclubLink: universalClubsData.uniclubLink,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
