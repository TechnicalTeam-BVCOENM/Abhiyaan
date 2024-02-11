import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:abhiyaan/file_exporter.dart';
part 'gallery_view_model.dart';

class GalleryView extends StatelessWidget {
  final List<dynamic> images;
  final String title;
  const GalleryView({super.key, required this.images, required this.title});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GalleryViewModel>.reactive(
      viewModelBuilder: () => GalleryViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: context.colorScheme.scaffoldBackgroundColor,
          body: RefreshIndicator(
              onRefresh: () async {
                model.fetchImages(images);
                model.notifyListeners();
              },
              child: Scrollbar(
                child: MasonryGridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: images.length,
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image.network(
                          images[index],
                          fit: BoxFit.cover,
                        )),
                  ),
                ).animate().fade(
                      duration: const Duration(milliseconds: 1500),
                    ),
              )),
        );
      },
    );
  }
}
