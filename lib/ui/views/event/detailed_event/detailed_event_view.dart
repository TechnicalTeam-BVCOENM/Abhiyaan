import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/services/firestore_service.dart';
import 'package:abhiyaan/ui/common/carousel_utils.dart';
import 'package:abhiyaan/ui/common/common_component_model.dart';
import 'package:abhiyaan/ui/views/event/event_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
part 'detailed_event_view_model.dart';
part 'detailed_event_view_components.dart';

class DetailedEventView extends StatelessWidget {
  final EventModel eventData;
  const DetailedEventView({super.key, required this.eventData});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DetailedEventViewModel>.reactive(
      viewModelBuilder: () => DetailedEventViewModel(eventData),
      onViewModelReady: (viewModel) => viewModel.getbestMoments(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: context.colorScheme.backgroundColor,
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              DetailedEventAppBar(
                imageLink: eventData.imageUrl,
                eventLocation: eventData.location,
              ),
              DetailedEventData(
                eventName: eventData.title,
                eventInfo: eventData.about,
                eventStartDate: eventData.startDate.toDate(),
                eventEndDate: eventData.endDate.toDate(),
                eventContactName: eventData.cName,
                eventContactEmail: eventData.cEmail,
                eventContactNumber: eventData.cPhone,
              ),
              SliverToBoxAdapter(
                child: model._bestMoments.isEmpty
                    ? Container(
                        height: 230.h,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Card(
                          margin: const EdgeInsets.only(bottom: 8).r,
                          elevation: 0,
                          clipBehavior: Clip.hardEdge,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16).r,
                            side: BorderSide(
                              color: context.colorScheme.secondaryLPurpleColor,
                              width: 1.0,
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.info_rounded,
                                  color:
                                      context.colorScheme.secondaryBlackColor,
                                ),
                                10.horizontalSpace,
                                Text("Stay Tuned Comming Soon !",
                                    style: model.fontThemeClass.body(context)),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(
                        height: 230.h,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CarouselSlider.builder(
                          itemCount: model._bestMoments.length,
                          itemBuilder: (context, index, realIndex) {
                            return CarouselUtils.buildImage(
                              context,
                              model._bestMoments[index]['imageUrl'],
                              model.activeIndex,
                            );
                          },
                          options: CarouselOptions(
                            height: 230.h,
                            onPageChanged: (index, reason) =>
                                model.updateActiveIndex(index),
                            autoPlay: true,
                            autoPlayInterval: 4.seconds,
                            viewportFraction: 1,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration: 1.seconds,
                            autoPlayCurve: Curves.easeInOut,
                            enlargeCenterPage: true,
                          ),
                        ),
                      ),
              ),
              SliverToBoxAdapter(child: 20.verticalSpace),
              SliverToBoxAdapter(
                child: Center(
                  child: CarouselUtils.buildIndicator(
                    context,
                    model.activeIndex,
                    model._bestMoments.length,
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavBarDetailedPage(
            eventName: eventData.title,
            eventInfo: eventData.about,
            eventStartDate: eventData.startDate.toDate(),
            eventEndDate: eventData.endDate.toDate(),
            eventContactName: eventData.cName,
            eventContactEmail: eventData.cEmail,
            eventContactNumber: eventData.cPhone,
          ),
        );
      },
    );
  }
}
