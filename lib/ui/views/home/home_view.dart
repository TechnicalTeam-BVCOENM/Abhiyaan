import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darpan/ui/common/cached_network_image.dart';
import 'package:darpan/ui/common/shimmer.dart';
import 'package:darpan/ui/common/update_component.dart';
import 'package:darpan/file_exporter.dart';
import 'package:darpan/services/firestore_service.dart';
import 'package:intl/intl.dart';
import 'package:darpan/ui/common/common_component_model.dart';
import 'package:darpan/ui/views/event/event_view.dart';
part 'home_view_model.dart';
part 'home_view_component.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    FontThemeClass fontTheme = FontThemeClass();
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (viewModel) => viewModel.loadData(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: context.colorScheme.backgroundColor,
          body: model.isBusy
              ? const ShimmerLoadingWidget()
              : SafeArea(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 18.0).r,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Hey ${model.user} 👋', // Update according to loal storage
                                style: fontTheme.appBarText(
                                    context, context.colorScheme.headingColor),
                              ),
                              IconButton(
                                splashRadius: 30.sp,
                                splashColor:
                                    context.colorScheme.secondaryBlackColor,
                                icon: ImageIcon(
                                  const AssetImage(
                                    "assets/images/Notification Bell.png",
                                  ),
                                  size: 24.sp,
                                ),
                                onPressed: () {},
                              )
                            ],
                          ),
                        ),
                        const SectionText(title: 'Highlights'),
                        SizedBox(
                          width: 386.w,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CarouselSlider.builder(
                                  itemCount: model.highlights.length,
                                  itemBuilder: (context, index, realIndex) {
                                    return CarouselUtils.buildImage(
                                        context,
                                        model.highlights[index]['imageUrl'],
                                        model._activeIndex);
                                  },
                                  options: CarouselOptions(
                                    height: 230.h,
                                    onPageChanged: (index, reason) =>
                                        model.updateActiveIndex(index),
                                    autoPlay: true,
                                    autoPlayInterval:
                                        const Duration(seconds: 3),
                                    viewportFraction: 1,
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                CarouselUtils.buildIndicator(
                                  context,
                                  model.activeIndex,
                                  model.highlights.length,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SectionText(title: "Quick Links"),
                        quickLinksList(context, model.quickLinksList),
                        // Activity
                        const SectionText(
                          title: "Activity",
                        ),
                        Container(
                          height: 135.sp,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: context.colorScheme.secondaryWhiteColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row( 
                            children: [ 
                              Expanded( 
                                flex: 3, 
                                child: Container( 
                                decoration: BoxDecoration( 
                                color: context.colorScheme.secondaryLPurpleColor, 
                                borderRadius: BorderRadius.only( 
                                topLeft: Radius.circular(12), 
                                bottomLeft: Radius.circular(12), 
                                  ), 
                                 ), 
                                  child: Padding( 
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8), 
                                    child: Column( 
                                      mainAxisAlignment: MainAxisAlignment.center, 
                                      children: [ 
                                        Text("${model.activityList[0].startTime.format(context)}", 
                                          style: fontTheme.subHeading(context, context.colorScheme.primaryDarkColor), 
                                        ), 
                                        Container ( 
                                         width: 10, 
                                         child: const Divider( 
                                         color: Colors.black, 
                                         thickness: 2.0, 
                                         height: 10.0, 
                                         ), 
                                        ), 
                                        Text("${model.activityList[0].endTime.format(context)}", 
                                          style: fontTheme.subHeading(context, context.colorScheme.primaryDarkColor), 
                                        ), 
                                      ], 
                                     
                                    ), 
                                  ), 
                                ), 
                              ), 
                              Expanded( 
                                flex: 7, 
                                child: Container( 
                                decoration: BoxDecoration( 
                                  color: context.colorScheme.secondaryWhiteColor, 
                                  borderRadius: BorderRadius.only( 
                                  topRight: Radius.circular(12), 
                                  bottomRight: Radius.circular(12), 
                                  ), 
                                ), 
                                   
                                  child: Padding( 
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8), 
                                    child: Column( 
                                      mainAxisAlignment: MainAxisAlignment.center, 
                                      crossAxisAlignment: CrossAxisAlignment.start, 
                                      children: [ 
                                        Text(model.activityList[0].subName, 
                                            style: fontTheme.subHeading(context, context.colorScheme.primaryDarkColor), 
                                          ), 
                                        SizedBox(height: 10), 
                                        Text(model.activityList[0].profName, 
                                            style: fontTheme.smallSubHeading(context, context.colorScheme.primaryDarkColor), 
                                          ), 
                                        SizedBox(height: 5), 
                                        Text(model.activityList[0].location, 
                                            style: fontTheme.smallSubHeading(context, context.colorScheme.primaryDarkColor), 
                                          ), 
                                     
                                      ], 
                                    ), 
                                  ), 
                                ),
                              ),
                              ],
                              ),  
                        ),
                        const SectionText(
                          title: "Department Updates",
                        ),
                        for (var i = 0;
                            i < model.departmentUpdates.length;
                            i++) ...[
                          updatesCard(
                              model._departmentUpdates, i, context, model),
                        ],
                        SizedBox(height: 20.h),
                        Center(
                          child: Text(
                            'Made with ❤️ by Technical Team',
                            style: fontTheme.smallSubHeading(context),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
