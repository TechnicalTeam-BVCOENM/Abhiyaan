import 'package:abhiyaan/file_exporter.dart';

part 'gallery_tab_view_model.dart';

class GalleryTabView extends StatelessWidget {
  const GalleryTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GalleryTabViewModel>.reactive(
        viewModelBuilder: () => GalleryTabViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            body: GestureDetector(
                onTap: () {
                  NavigationService().navigateTo(Routes.galleryView);
                },
                child: const Center(
                    child: Text("tap here to view gallery images"))),
          );
        });
  }
}
