import 'package:darpan/file_exporter.dart';
import 'detailed_event_view.dart';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/widgets.dart';

class DetailedEventView {}

class DetailedEventAppBar extends StatelessWidget {
  const DetailedEventAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 275.h,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(
          'https://thumbs.dreamstime.com/b/modern-business-buildings-11681736.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
