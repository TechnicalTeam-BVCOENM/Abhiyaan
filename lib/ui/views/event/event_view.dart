import 'package:darpan/theme/responsive_utils.dart';
import 'package:flutter/rendering.dart';

import '../../../file_exporter.dart';
part 'event_view_model.dart';

class EventView extends StatelessWidget {
  const EventView({super.key});

  @override
  Widget build(BuildContext context) {
    FontThemeClass fontTheme = FontThemeClass();
    return ViewModelBuilder<EventViewModel>.reactive(
      viewModelBuilder: () => EventViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                
                children: [
                  const Align(
                      alignment: Alignment.bottomLeft,
                      child: SectionText(title: "Ongoing Events")),
                  Card(
                    clipBehavior: Clip.hardEdge,
                    shape: ShapeBorder.lerp(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        1),
                    child: Stack(
                      children: [
                        // Event Image and Info
                        Positioned(
                          child: SizedBox(
                            height: 250.hWise,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                // Event Image
                                CachedNetworkImageWidget(
                                  imageUrl:
                                      "https://imgs.search.brave.com/y2ve9MehABcSRTFjQYPcwpiFeueug4jPMSBV80j3lew/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXRteXVuaS5j/b20vYXp1cmUvY29s/bGVnZS1pbWFnZS9i/aWcvYmhhcmF0aS12/aWR5YXBlZXRocy1p/bnN0aXR1dGUtb2Yt/bWFuYWdlbWVudC1z/dHVkaWVzLXJlc2Vh/cmNoLWJ2aW1zci1t/dW1iYWkuanBn",
                                  height: 160.hWise,
                                  width: ResponsiveUtils.screenWidth(context),
                                  maxHeightDiskCache:
                                      ResponsiveUtils.screenWidth(context),
                                ),
                                SizedBox(
                                  height: 28.hWise,
                                ),
                                // Event Info
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Title
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 22.padL.left),
                                              child: Text(
                                                "Abhiyaan",
                                                style:
                                                    fontTheme.heading2(context),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 4.hWise,
                                            ),
                                            //  Time and Location
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 20.padL.left),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.timer,
                                                        size: 18.wWise,
                                                        color: context
                                                            .colorScheme
                                                            .primaryColor,
                                                      ),
                                                      SizedBox(
                                                        width: 4.wWise,
                                                      ),
                                                      Text(
                                                        "11:00 AM",
                                                        style: fontTheme
                                                            .subHeading2(
                                                          context,
                                                          context.colorScheme
                                                              .primaryColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 8.wWise,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        size: 18.wWise,
                                                        color: context
                                                            .colorScheme
                                                            .primaryColor,
                                                      ),
                                                      SizedBox(
                                                        width: 4.wWise,
                                                      ),
                                                      Text(
                                                        "Qudrangle",
                                                        style: fontTheme
                                                            .subHeading2(
                                                          context,
                                                          context.colorScheme
                                                              .primaryColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: 8.padR.right),
                                          child: Transform.rotate(
                                            angle: 180 * 314 / 22,
                                            child: InkWell(
                                              onTap: () {},
                                              child: Icon(
                                                Icons.send_rounded,
                                                size: 36.wWise,
                                                color: context
                                                    .colorScheme.primaryColor,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Event floating Date
                        Positioned(
                          top: 120.hWise,
                          left: 20.wWise,
                          child: Container(
                            height: 60.hWise,
                            width: 60.wWise,
                            decoration: BoxDecoration(
                              color: context.colorScheme.secondaryWhiteColor,
                              boxShadow: [
                                BoxShadow(
                                  color: context
                                      .colorScheme.secondarySectionColor
                                      .withOpacity(0.4),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                )
                              ],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "26",
                                  style: fontTheme.large(
                                    context,
                                  ),
                                ),
                                Text(
                                  "Feb",
                                  style: fontTheme.subHeading2(context,
                                      context.colorScheme.secondaryBlackColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Align(
                      alignment: Alignment.bottomLeft,
                      child: SectionText(title: "Sponsors")),
                  const Align(
                      alignment: Alignment.bottomLeft,
                      child: SectionText(title: "Upcoming Events")),

                      Container(
                        height: 200,
                         child:ListView.builder(
                    
                      scrollDirection: Axis.horizontal,
                      itemCount: 5, // Adjust the number of cards as needed
                      itemBuilder: (context, index) {
                        return Container(
                          height: 200,
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            clipBehavior: Clip.hardEdge,
                            shape: ShapeBorder.lerp(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                1),
                            child: Stack(
                              children: [
                                // Event Image and Info
                                Positioned(
                                  child: SizedBox(
                                    height: 175.hWise,
                                    width: 200.wWise,
                                    child: Column(
                                      children: [
                                        // Event Image
                                        CachedNetworkImageWidget(
                                          imageUrl:
                                              "https://imgs.search.brave.com/y2ve9MehABcSRTFjQYPcwpiFeueug4jPMSBV80j3lew/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXRteXVuaS5j/b20vYXp1cmUvY29s/bGVnZS1pbWFnZS9i/aWcvYmhhcmF0aS12/aWR5YXBlZXRocy1p/bnN0aXR1dGUtb2Yt/bWFuYWdlbWVudC1z/dHVkaWVzLXJlc2Vh/cmNoLWJ2aW1zci1t/dW1iYWkuanBn",
                                          height: 125.hWise,
                                          width: ResponsiveUtils.screenWidth(
                                              context),
                                          maxHeightDiskCache:
                                              ResponsiveUtils.screenWidth(
                                                  context),
                                        ),
                                        SizedBox(
                                          height: 8.hWise,
                                        ),
                                        // Event Info
                                        Row(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // Title
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 15.padL.left,
                                                          top: 4.padT.top),
                                                      child: Text(
                                                        "Abhiyaan",
                                                        style: fontTheme
                                                            .profileheading(
                                                                context),
                                                      ),
                                                    ),

                                                    //  Time and Location
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 15.padL.left),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons.timer,
                                                                size: 12.wWise,
                                                                color: context
                                                                    .colorScheme
                                                                    .primaryColor,
                                                              ),
                                                              SizedBox(
                                                                width: 4.wWise,
                                                              ),
                                                              Text(
                                                                "11:00 AM",
                                                                style: fontTheme
                                                                    .smallSubHeading(
                                                                  context,
                                                                  context
                                                                      .colorScheme
                                                                      .primaryColor,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 8.wWise,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .location_on,
                                                                size: 12.wWise,
                                                                color: context
                                                                    .colorScheme
                                                                    .primaryColor,
                                                              ),
                                                              SizedBox(
                                                                width: 4.wWise,
                                                              ),
                                                              Text(
                                                                "Qudrangle",
                                                                style: fontTheme
                                                                    .smallSubHeading(
                                                                  context,
                                                                  context
                                                                      .colorScheme
                                                                      .primaryColor,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Event floating Date
                                Positioned(
                                  top: 6.hWise,
                                  left: 6.wWise,
                                  child: Container(
                                    height: 50.hWise,
                                    width: 50.wWise,
                                    decoration: BoxDecoration(
                                      color: context
                                          .colorScheme.secondaryWhiteColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: context
                                              .colorScheme.secondarySectionColor
                                              .withOpacity(0.4),
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          "26",
                                          style: fontTheme.heading(context,
                                              context.colorScheme.primaryColor),
                                        ),
                                        Text(
                                          "Feb",
                                          style: fontTheme.subHeading2(
                                              context,
                                              context.colorScheme
                                                  .secondaryBlackColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                           
                        );
                      })
                      ),
                 
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
