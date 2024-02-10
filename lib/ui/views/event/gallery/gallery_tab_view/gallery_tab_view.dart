import 'package:abhiyaan/file_exporter.dart';
import 'package:cached_network_image/cached_network_image.dart';

part 'gallery_tab_view_model.dart';
part "gallery_tab_component.dart";

class GalleryTabView extends StatelessWidget {
  const GalleryTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GalleryTabViewModel>.reactive(
      viewModelBuilder: () => GalleryTabViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: context.colorScheme.scaffoldBackgroundColor,
          body: GestureDetector(
            onTap: () {
              NavigationService().navigateTo(Routes.galleryView);
            },
            child: const Center(
              child: GalleryTabs(),
            ),
          ),
        );
      },
    );
  }
}
