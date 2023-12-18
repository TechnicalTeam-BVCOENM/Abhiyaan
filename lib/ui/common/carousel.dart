import 'package:carousel_slider/carousel_slider.dart';
import 'package:darpan/file_exporter.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Carousel extends StatelessWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: imageUrls.length,
          itemBuilder: (context, int index, int realIndex) {
            return CarouselUtils.buildImage(
                context, imageUrls[index], activeIndex);
          },
          options: CarouselOptions(
            height: 230.h,
            onPageChanged: (index, reason) => _activeIndex,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            viewportFraction: 1,
          ),
        ),
        const SizedBox(height: 20),
        CarouselUtils.buildIndicator(
          context,
          activeIndex,
          imageUrls.length,
        ),
      ],
    );
  }
}

class CarouselUtils {
  static Widget buildIndicator(
          BuildContext context, int activeIndex, int length) =>
      AnimatedSmoothIndicator(
        effect: JumpingDotEffect(
          dotHeight: 8.sp,
          dotWidth: 8.sp,
          dotColor: context.colorScheme.secondarySectionColor,
          activeDotColor: context.colorScheme.primaryColor,
        ),
        activeIndex: activeIndex,
        count: length,
      );

  static Widget buildImage(BuildContext context, String urlImage, int index) =>
      Container(
        width: MediaQuery.of(context).size.width * 0.87,
        margin: const EdgeInsets.symmetric(horizontal: 7),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: urlImage,
                height: 1500.h,
                width: double.infinity,
                maxHeightDiskCache: 1000,
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.4),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

final List<String> imageUrls = [
  "https://fastly.picsum.photos/id/237/536/354.jpg?hmac=i0yVXW1ORpyCZpQ-CknuyV-jbtU7_x9EBQVhvT5aRr0",
  "https://fastly.picsum.photos/id/866/536/354.jpg?hmac=tGofDTV7tl2rprappPzKFiZ9vDh5MKj39oa2D--gqhA",
  "https://fastly.picsum.photos/id/1084/536/354.jpg?grayscale&hmac=Ux7nzg19e1q35mlUVZjhCLxqkR30cC-CarVg-nlIf60",
  "https://fastly.picsum.photos/id/870/536/354.jpg?blur=2&grayscale&hmac=A5T7lnprlMMlQ18KQcVMi3b7Bwa1Qq5YJFp8LSudZ84",
  "https://fastly.picsum.photos/id/326/536/354.jpg?hmac=vpN_TKlGZw_xJpuA2bKAHJxAZa1V4-LnEeZNFr9kCoM",
];

int _activeIndex = 0;
int get activeIndex => _activeIndex;
void updateActiveIndex(int newIndex) {
  _activeIndex = newIndex;
  //notifyListeners();
}
