part of 'gallery_tab_view.dart';

class GalleryTabs extends StatelessWidget {
  final Map<String, dynamic> abhiyaan;
  final Map<String, dynamic> sports;
  final Map<String, dynamic> cultural;
  const GalleryTabs(
      {super.key,
      required this.abhiyaan,
      required this.sports,
      required this.cultural});

  @override
  Widget build(BuildContext context) {
    final List<Tab> myTabs = <Tab>[
      const Tab(text: 'Abhiyaan'),
      const Tab(text: 'Sports'),
      const Tab(text: 'Cultural'),
    ];

    return SizedBox(
      width: double.infinity,
      height: 1000,
      child: DefaultTabController(
        length: myTabs.length,
        child: Scaffold(
          backgroundColor: context.colorScheme.scaffoldBackgroundColor,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: context.colorScheme.primaryTextColor,
            ),
            backgroundColor: context.colorScheme.scaffoldBackgroundColor,
            titleSpacing: 0,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(Icons.navigate_before),
              onPressed: () {
                NavigationService().back();
              },
            ),
            bottom: TabBar(
              tabs: myTabs,
            ),
            title: SizedBox(
                width: 100,
                child: Text(
                  '2024',
                  style: FontThemeClass().paragraph(context),
                )),
          ),
          body: TabBarView(children: [
            TabViewGrid(
              tabData: abhiyaan,
            ),
            TabViewGrid(
              tabData: sports,
            ),
            TabViewGrid(
              tabData: cultural,
            ),
          ]),
        ),
      ),
    );
  }
}

class TabViewCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final List<dynamic> imageList;
  const TabViewCard({super.key, required this.imageUrl, required this.name, required this.imageList});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigationService().navigateToGalleryView(images: imageList, title: name),
      child: Center(
        child: SizedBox(
          width: 190,
          height: 184,
          child: Card(
            color: context.colorScheme.primaryCardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      height: 130,
                      width: 190,
                      fit: BoxFit.cover,
                    )),
                SizedBox(
                  width: 190,
                  height: 39,
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: FontThemeClass()
                        .body(context, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TabViewGrid extends StatelessWidget {
  final Map<String, dynamic> tabData;
  const TabViewGrid({super.key, required this.tabData});

  @override
  Widget build(BuildContext context) {
    List<List<dynamic>> listOfLists = [];
    List<String> keys = [];

    // Run function to create list of lists
    tabData.forEach((key, value) {
      if (value is List) {
        keys.add(key);
        listOfLists.add(value);
      }
    });

    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: listOfLists.length,
        itemBuilder: (BuildContext context, int index) {
          return TabViewCard(
            imageUrl: listOfLists[index][0],
            imageList: listOfLists[index],
            name: keys[index],
          );
        });
  }
}
