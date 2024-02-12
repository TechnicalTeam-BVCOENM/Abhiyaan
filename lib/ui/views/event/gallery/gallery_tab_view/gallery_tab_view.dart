import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/ui/views/event/event_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

part 'gallery_tab_view_model.dart';
part "gallery_tab_component.dart";

class GalleryTabView extends StatelessWidget {
  final GalleryModel gallery;
  const GalleryTabView({super.key, required this.gallery});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GalleryTabViewModel>.reactive(
      viewModelBuilder: () => GalleryTabViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: context.colorScheme.scaffoldBackgroundColor,
          body: Center(
            child: GalleryTabs(
              abhiyaan: gallery.abhiyaan,
              sports: gallery.sports,
              cultural: gallery.cultural,
              year: gallery.year,
            ),
          ),
        );
      },
    );
  }
}
