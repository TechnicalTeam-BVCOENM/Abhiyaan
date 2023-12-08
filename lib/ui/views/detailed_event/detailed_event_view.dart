import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:darpan/file_exporter.dart';

part 'detailed_event_view_model.dart';

class DetailedEventView extends StatelessWidget {
  const DetailedEventView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DetailedEventViewModel>.nonReactive(
      viewModelBuilder: () => DetailedEventViewModel(),
      builder: (context, model, child) {
        return Scaffold(
            body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: CachedNetworkImage(
                  imageUrl:
                      "https://images.unsplash.com/photo-1560179707-f14e90ef3623?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8Y29tcGFueXxlbnwwfHwwfHx8MA%3D%3D"),
            ),
            buttonArrow(),
          ],
        ));
      },
    );
  }

  buttonArrow() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
