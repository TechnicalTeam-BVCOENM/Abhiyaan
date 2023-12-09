import 'package:darpan/file_exporter.dart';
import 'package:darpan/ui/sub_views/event/detailed_event_view_components.dart';
// import 'package:darpan/theme/theme_service.dart';

part 'detailed_event_view_model.dart';
// part 'detailed_event_view_components.dart';

class DetailedEventView extends StatelessWidget {
  const DetailedEventView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DetailedEventViewModel>.reactive(
      viewModelBuilder: () => DetailedEventViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: CustomScrollView(
            physics: BouncingScrollPhysics(),
            // scrollBehavior:
            //     MaterialScrollBehavior().copyWith(overscroll: false),
            slivers: <Widget>[
              DetailedEventAppBar(),
              DetailedEventData(),
            ],
          ),
          // body: SafeArea(
          //   child: Stack(
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.only(top: 40.0),
          //         child: Column(
          //           children: [
          //             Image.network(
          //                 'https://thumbs.dreamstime.com/b/modern-business-buildings-11681736.jpg'),
          //           ],
          //         ),
          //       ),
          //       DraggableScrollableSheet(
          //         builder: (context, scrollController) {
          //           return DetailedEventData();
          //         },
          //       ),
          //     ],
          //   ),
          // ),
          bottomNavigationBar: BottomNavBarDetailedPage(),
        );
      },
    );
  }
}
