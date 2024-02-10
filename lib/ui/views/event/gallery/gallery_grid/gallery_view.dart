import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:abhiyaan/file_exporter.dart';
part 'gallery_view_model.dart';

class GalleryView extends StatelessWidget {
  const GalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GalleryViewModel>.reactive(
      viewModelBuilder: () => GalleryViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {
              await model.fetchImages();
              model.notifyListeners();
            },
            child: Scrollbar(
              child: MasonryGridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: model.images.length,
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
                      model.images[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
