part of 'gallery_view.dart';

class GalleryViewModel extends BaseViewModel {
  List<String> images = [
    'https://picsum.photos/seed/picsum/200/300',
    'https://cdn.pixabay.com/photo/2016/08/11/23/48/mountains-1587287_1280.jpg',
    'https://cdn.pixabay.com/photo/2012/09/15/02/22/forest-56930_1280.jpg',
    'https://cdn.pixabay.com/photo/2015/05/03/14/40/woman-751236_1280.jpg',
    'https://cdn.pixabay.com/photo/2023/01/06/12/28/ninja-7701126_1280.jpg',
    'https://images.pexels.com/photos/1293261/pexels-photo-1293261.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/5767679/pexels-photo-5767679.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/13876836/pexels-photo-13876836.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://www.pcgamesn.com/wp-content/sites/pcgamesn/2023/04/Killjoy-best-agent-550x309.jpg',
  ];


  Future<void> fetchImages() async {
    // Fetch updated images here
    // For example:
    // final List<String> newImages = await yourImageFetchingFunction();
    // images.clear();
    // images.addAll(newImages);
    // notifyListeners();
    // For demonstration, I'll just shuffle the existing list
    images.shuffle();
    notifyListeners();
  }
}
