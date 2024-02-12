import 'dart:math';
import 'dart:ui';
import 'package:abhiyaan/ui/common/circular_loading_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:abhiyaan/file_exporter.dart';
part 'gallery_view_model.dart';

class GalleryView extends StatelessWidget {
  final List<dynamic> images;
  final String title;
  final Random random = Random();

  GalleryView({super.key, required this.images, required this.title});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GalleryViewModel>.reactive(
      viewModelBuilder: () => GalleryViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: context.colorScheme.primaryTextColor,
            ),
            title: Text(
              title.toUpperCase(),
              style: FontThemeClass().title(context),
            ),
            backgroundColor: context.colorScheme.scaffoldBackgroundColor,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          backgroundColor: context.colorScheme.scaffoldBackgroundColor,
          body: SafeArea(
            child: Scrollbar(
              child: Column(
                children: [
                  18.horizontalSpace,
                  Expanded(
                    child: MasonryGridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: images.length,
                      gridDelegate:
                          const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onLongPress: () {
                            showDialog(
                                barrierColor: Colors.black.withOpacity(0.4),
                                context: context,
                                builder: (context) {
                                  return BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 10,
                                      sigmaY: 10,
                                    ),
                                    child: AlertDialog(
                                      contentPadding: EdgeInsets.zero,
                                      titlePadding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 12),
                                      content: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20).r,
                                          child: CachedNetworkImage(
                                            imageUrl: images[index],
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            height: (100.0 + random.nextInt(100)).h,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: images[index],
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) {
                                return const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircularLoadingIndicator(),
                                );
                              },
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ).animate().fade(
                    duration: const Duration(milliseconds: 1500),
                  ),
            ),
          ),
        );
      },
    );
  }
}
