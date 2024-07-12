import 'package:abhiyaan/file_exporter.dart';

part 'expand_image_view_model.dart';

class ExpandImageView extends StatelessWidget {
  final String imageUrl;
  const ExpandImageView({super.key, required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.scaffold,
      body: SafeArea(
        child: Center(
          child: InteractiveViewer(
            minScale: 0.1, // Minimum scale
            maxScale: 4.0, // Maximum scale
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: context.colorScheme.scaffold,
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(imageUrl),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
