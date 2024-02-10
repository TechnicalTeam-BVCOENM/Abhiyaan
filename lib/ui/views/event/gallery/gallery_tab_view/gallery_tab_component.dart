part of 'gallery_tab_view.dart';

class GalleryTabs extends StatelessWidget {
  const GalleryTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Tab> myTabs = <Tab>[
      const Tab(text: 'Abhiyaan'),
      const Tab(text: 'Sports'),
      const Tab(text: 'Sports'),
      const Tab(text: 'Sports'),
      const Tab(text: 'Sports'),
      const Tab(text: 'Sports'),
    ];

    return SizedBox(
      width: double.infinity,
      height: 1000,
      child: DefaultTabController(
        length: myTabs.length,
        child: Scaffold(
          backgroundColor: context.colorScheme.backgroundColor,
          appBar: AppBar(
            iconTheme:
                IconThemeData(color: context.colorScheme.secondaryBlackColor),
            backgroundColor: context.colorScheme.backgroundColor,
            titleSpacing: 0,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(Icons.navigate_before),
              onPressed: () {
                NavigationService().back();
              },
            ),
            bottom: TabBar(
              isScrollable: true,
              tabs: myTabs,
            ),
            title: SizedBox(
                width: 100,
                child: Text(
                  '2024',
                  style: FontThemeClass().paragraph(context),
                )),
          ),
          body: const TabBarView(children: [
            Center(child: Text("tab")),
            TabViewGrid(),
            Center(child: Text("tab")),
            Center(child: Text("tab")),
            Center(child: Text("tab")),
            Center(child: Text("tab")),
          ]),
        ),
      ),
    );
  }
}

class TabViewCard extends StatelessWidget {
  const TabViewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 190,
        height: 184,
        child: Card(
          color: context.colorScheme.secondaryWhiteColor,
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
                    imageUrl: "https://cdn.imgchest.com/files/345xck3w597.png",
                    height: 130,
                    width: 190,
                    fit: BoxFit.cover,
                  )),
              Container(
                  width: 190,
                  height: 39,
                  child: Text(
                    "Abhiyaan",
                    textAlign: TextAlign.center,
                    style: FontThemeClass()
                        .body(context, fontWeight: FontWeight.w500),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class TabViewGrid extends StatelessWidget {
  const TabViewGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: tabViewCardList.length,
      itemBuilder: (BuildContext context, int index) {
        return tabViewCardList[index];
      },
    );
  }
}

List<TabViewCard> tabViewCardList = [
  TabViewCard(),
  TabViewCard(),
  TabViewCard(),
  TabViewCard(),
  TabViewCard(),
  TabViewCard(),
  TabViewCard(),
  TabViewCard(),
];
