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
            slivers: <Widget>[
              DetailedEventAppBar(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.h),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Abhiyaan',
                          style: TextStyle(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          // textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 24.h,
                              width: 24.h,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(right: 8.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Icon(
                                Icons.calendar_month_outlined,
                              ),
                            ),
                            Text(
                              '14-18 Jan 2024',
                              style: TextStyle(
                                fontSize: 18.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 24.h,
                              width: 24.h,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(right: 8.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Icon(
                                Icons.timer_outlined,
                              ),
                            ),
                            Text(
                              '15:00 pm',
                              style: TextStyle(
                                fontSize: 18.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Text(
                          "About Event",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22.sp),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          'Join us for a spectacular celebration of cultural diversity at the Abhiyaan Carnival, where students from all walks of life come together to showcase the rich tapestry of talents that make our college community vibrant and unique. The rich tapestry of talents that make our college community vibrant and unique.',
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Divider(
                          color: Colors.black12,
                          height: 1.h,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "Contact Section",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22.sp),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 28.h,
                              width: 28.h,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(right: 8.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Icon(
                                Icons.account_circle,
                                size: 23.h,
                              ),
                            ),
                            Text(
                              'Mr. Sachin Rathod',
                              style: TextStyle(
                                fontSize: 20.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 28.h,
                              width: 28.h,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(right: 8.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Icon(
                                Icons.email,
                                size: 23.h,
                              ),
                            ),
                            Text(
                              '125rathodsachin@gmail.com',
                              style: TextStyle(
                                fontSize: 18.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 28.h,
                              width: 28.h,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(right: 8.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Icon(
                                Icons.phone_in_talk_rounded,
                                size: 23.h,
                              ),
                            ),
                            Text(
                              '9838070708',
                              style: TextStyle(
                                fontSize: 18.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                      ]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
