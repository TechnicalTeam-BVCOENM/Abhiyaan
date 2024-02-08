import 'package:abhiyaan/file_exporter.dart';

part 'gallery_view_model.dart';

class GalleryView extends StatelessWidget {
  const GalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GalleryViewModel>.reactive(
        viewModelBuilder: () => GalleryViewModel(),
        builder: (context, model, child) {
          return const Scaffold(
            body: Center(child: Text("gallery_view")),
          );
        });
  }
}
