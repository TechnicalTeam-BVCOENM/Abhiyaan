import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../file_exporter.dart';

//tools
class CircularLoadingIndicator extends StatelessWidget {
  final double height;

  const CircularLoadingIndicator({Key? key, this.height = 100.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height.hWise,
        width: height.wWise,
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            context.colorScheme.secondarySectionColor,
          ),
        ),
      ),
    );
  }
}

void showMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0);
}

// Section Name Text
class SectionText extends StatelessWidget {
  const SectionText({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 18, bottom: 8),
      child: Text(
        title,
        style: FontThemeClass().subHeading2(
          context,
          context.colorScheme.secondarySectionColor,
        ),
      ),
    );
  }
}

class CachedNetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final double maxHeightDiskCache;
  final BoxFit fit;

  const CachedNetworkImageWidget({
    super.key,
    required this.imageUrl,
    required this.height,
    required this.width,
    required this.maxHeightDiskCache,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      height: height,
      width: width,
      maxHeightDiskCache: maxHeightDiskCache.toInt(),
      placeholder: (context, url) => CircularLoadingIndicator(height: 90.hWise),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}




