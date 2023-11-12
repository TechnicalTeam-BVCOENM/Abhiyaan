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

//designs

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

Container horizontalStoryRow(
    BuildContext context, List model, double borderRadius) {
  FontThemeClass fontTheme = FontThemeClass();
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 4),
    height: 120.hWise,
    width: MediaQuery.of(context).size.width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: model.length,
            itemBuilder: (context, idx) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      debugPrint("Tapped$idx");
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                      height: 80.hWise,
                      width: 80.wWise,
                      decoration: BoxDecoration(
                        color: context.colorScheme.secondarySectionColor,
                        borderRadius: BorderRadius.circular(borderRadius),
                        image: DecorationImage(
                          image: NetworkImage(
                            model[idx].imageUrl,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    model[idx].title,
                    style: fontTheme.smallSubHeading(
                      context,
                      context.colorScheme.secondaryBlackColor,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    ),
  );
}

void showmessage(context, String message) {
  try {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      duration: const Duration(milliseconds: 500),
      backgroundColor: Colors.transparent,
      content: Center(
        child: Container(
          padding: EdgeInsets.only(left: 70, right: 70, top: 10, bottom: 10),
          height: 40.hWise,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryLPurpleColor,
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            message,
            style: FontThemeClass().subHeading(
                context, Theme.of(context).colorScheme.secondaryBlackColor),
          ),
        ),
      ),
    ));
  } catch (e) {
    debugPrint("error is $e");
  }
}
