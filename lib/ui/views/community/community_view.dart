import 'dart:async';
import 'package:abhiyaan/theme/responsive_utils.dart';
import 'package:abhiyaan/ui/common/circular_loading_indicator.dart';
import 'package:abhiyaan/ui/common/toast_message.dart';
import 'package:abhiyaan/ui/common/url_launcher.dart';
import 'package:abhiyaan/ui/views/community/detailed_blogs/detailed_blogs_view.dart';
import 'package:abhiyaan/utils/firebase_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/services/auth_service.dart';
import 'package:abhiyaan/services/firestore_service.dart';
import 'package:abhiyaan/ui/common/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';

part "community_view_components.dart";
part "community_view_model.dart";
part 'data_model.dart';

class CommunityView extends StatelessWidget {
  const CommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CommunityViewModel>.reactive(
      viewModelBuilder: () => CommunityViewModel(),
      disposeViewModel: false,
      onViewModelReady: (viewModel) => viewModel.init(context),
      builder: (context, model, child) {
        FontThemeClass font = FontThemeClass();
        return Scaffold(
          backgroundColor: context.colorScheme.scaffold,
          body: model.isBusy
              ? const CircularLoadingIndicator()
              : SafeArea(
                  minimum: const EdgeInsets.symmetric(horizontal: 18).r,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        18.verticalSpace,
                        _buildTitle(font, context),
                        _buildQuote(model),
                        _buildClubs(
                            model.departmentClubsData, "Departmental Clubs"),
                        18.verticalSpace,
                        const CommunityInviteCard(),
                        _buildClubs(
                            model.universalClubsData, "Universal Clubs"),
                        12.verticalSpace,
                        _buildCommunityBlogs(model, context),
                        38.verticalSpace,
                      ]
                          .animate(interval: 100.milliseconds)
                          .fadeIn(duration: 200.milliseconds),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
