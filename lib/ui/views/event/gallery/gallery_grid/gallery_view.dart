import 'dart:math';

import 'package:abhiyaan/ui/common/circular_loading_indicator.dart';
import 'package:abhiyaan/ui/views/event/expand_image/expand_image_view.dart';
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
          backgroundColor: context.colorScheme.scaffoldBackgroundColor,
          body: SafeArea(
            child: Scrollbar(
              child: Column(
                children: [
                  const SizedBox(height: 18),
                  Center(
                    child: Text(
                      title,
                      style: FontThemeClass().title(context),
                    ),
                  ),
                  const SizedBox(height: 18),
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
                        child: InkWell(
                          onTap: () {
                            NavigationService().navigateToView(
                              ExpandImageView(
                                imageUrl: images[index],
                              ),
                            );
                          },
                          child: Container(
                            height: 100.0 +
                                random.nextInt(
                                    100), // random height between 100 and 200
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
