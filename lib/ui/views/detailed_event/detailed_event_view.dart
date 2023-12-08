import 'package:darpan/file_exporter.dart';
import 'package:darpan/ui/views/detailed_event/detailed_event_view_components.dart';

part 'detailed_event_view_model.dart';

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
              SliverAppBar(
                backgroundColor: Colors.white,
                elevation: 0.0,
                pinned: true,
                stretch: true,
                expandedHeight: 220.h,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    'https://thumbs.dreamstime.com/b/modern-business-buildings-11681736.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 220.h,
                  ),
                  stretchModes: [
                    StretchMode.blurBackground,
                    StretchMode.zoomBackground
                  ],
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(0.0),
                  child: Container(
                    height: 32.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: context.colorScheme.backgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.h),
                        topRight: Radius.circular(15.h),
                      ),
                    ),
                    child: Container(
                      width: 40.w,
                      height: 5.h,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(100.h),
                      ),
                    ),
                  ),
                ),
              ),
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
