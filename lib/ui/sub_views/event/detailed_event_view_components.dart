import 'package:darpan/file_exporter.dart';
// part of '../event/detailed_event_view.dart';

class DetailedEventAppBar extends StatelessWidget {
  const DetailedEventAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
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
              );
  }
}
