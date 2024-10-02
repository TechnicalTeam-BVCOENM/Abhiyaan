import 'dart:async';
import 'package:abhiyaan/services/notification_service.dart';
import 'package:abhiyaan/ui/common/carousel_utils.dart';
import 'package:abhiyaan/ui/common/circular_loading_indicator.dart';
import 'package:abhiyaan/ui/common/toast_message.dart';
import 'package:abhiyaan/ui/views/home/celebration/celebration_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/services/firestore_service.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:abhiyaan/ui/common/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:upgrader/upgrader.dart';

part 'home_view_model.dart';
part 'home_view_component.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final font = FontThemeClass();
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(context),
      disposeViewModel: false,
      onViewModelReady: (viewModel) {
        // ignore: use_build_context_synchronously
        viewModel.init(context).then((value) => viewModel.afterInit(context));
      },
      builder: (context, model, child) {
        return UpgradeAlert(
          showLater: false,
          showIgnore:
              const bool.fromEnvironment('dart.vm.product') ? false : true,
          upgrader: Upgrader(
            durationUntilAlertAgain: const Duration(days: 2),
          ),
          child: Scaffold(
            backgroundColor: context.colorScheme.scaffold,
            body: model.isBusy
                ? const CircularLoadingIndicator()
                : SafeArea(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 18.0).r,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const UserGreetingsWidget(),
                          const SectionText(title: 'Highlights'),
                          const HighlightCarouselWidget(),
                          const SectionText(title: "Quick Links"),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: quickLinksList(
                                context,
                                model.quickLinksList,
                              ),
                            ),
                          ),
                          10.verticalSpace,
                          const SectionText(
                            title: "College Updates",
                          ),
                          model.collegeUpdates.isEmpty
                              ? SizedBox(
                                  height: 120.h,
                                  child: Card(
                                    margin: const EdgeInsets.only(bottom: 8).r,
                                    elevation: 0,
                                    clipBehavior: Clip.hardEdge,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16).r,
                                      side: BorderSide(
                                        color: context.colorScheme.accentColor,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.info_rounded,
                                          color:
                                              context.colorScheme.primaryText,
                                        ),
                                        10.horizontalSpace,
                                        Text(
                                          "No updates yet, Stay Tuned",
                                          style: font.body(context),
                                        ),
                                      ],
                                    ),
                                  ).animate().fadeIn(),
                                )
                              : ListView.builder(
                                  itemBuilder: (context, index) {
                                    return updatesCard(
                                      model.collegeUpdates,
                                      index,
                                      context,
                                      model,
                                    );
                                  },
                                  itemCount: model.collegeUpdates.length,
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                ).animate(delay: 200.ms).fadeIn(),
                          60.verticalSpace,
                          Text(
                            "Innovate",
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: font.display(
                              context,
                              fontWeight: FontWeight.bold,
                              color: context.colorScheme.secondaryText
                                  .withOpacity(0.35),
                            ),
                          ),
                          Text(
                            "Achieve Inspire",
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: font.display(
                              context,
                              fontWeight: FontWeight.bold,
                              color: context.colorScheme.secondaryText
                                  .withOpacity(0.35),
                            ),
                          ),
                          3.verticalSpace,
                          InkWell(
                            onTap: () {
                              UrlLauncher()
                                  .launchURL("https://abhiyaan.tech/web-team");
                            },
                            child: Text(
                              'Made with ❤️ by TheDevCrew',
                              style: font.caption(
                                context,
                                color: context.colorScheme.primaryText,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          12.verticalSpace,
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
