part of 'event_view.dart';

// Event Time and location component
class EventDetails {
  FontThemeClass fontTheme = FontThemeClass();

  Row _eventLocation(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.location_on,
          size: 18.wWise,
          color: context.colorScheme.primaryColor.withOpacity(0.8),
        ),
        SizedBox(
          width: 4.wWise,
        ),
        Text(
          "Qudrangle",
          style: fontTheme.subHeading2(
            context,
            context.colorScheme.primaryColor.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Row _eventTime(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.timer,
          size: 18.wWise,
          color: context.colorScheme.primaryColor.withOpacity(0.8),
        ),
        SizedBox(
          width: 4.wWise,
        ),
        Text(
          "11:00 AM",
          style: fontTheme.subHeading2(
            context,
            context.colorScheme.primaryColor.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  CachedNetworkImageWidget _eventImage(
      BuildContext context, String imageUrl, double height, double width) {
    return CachedNetworkImageWidget(
      imageUrl: imageUrl,
      height: height,
      width: width,
      maxHeightDiskCache: ResponsiveUtils.screenWidth(context),
    );
  }

  Padding eventTitle(BuildContext context, String title, EdgeInsets padding) {
    return Padding(
      padding: padding,
      child: Text(
        title,
        style: fontTheme.heading(context),
      ),
    );
  }

  get eventLocation => _eventLocation;
  get eventTime => _eventTime;
  get eventImage => _eventImage;
}


//UC
class UCEventDetails {
  FontThemeClass fontTheme = FontThemeClass();

  Row _eventLocation(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.location_on,
          size: 12.wWise,
          color: context.colorScheme.primaryColor.withOpacity(0.8),
        ),
        SizedBox(
          width: 4.wWise,
        ),
        Text(
          "Qudrangle",
          style: fontTheme.smallSubHeading(
            context,
            context.colorScheme.primaryColor.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Row _eventTime(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.timer,
          size: 12.wWise,
          color: context.colorScheme.primaryColor.withOpacity(0.8),
        ),
        SizedBox(
          width: 4.wWise,
        ),
        Text(
          "11:00 AM",
          style: fontTheme.smallSubHeading(
            context,
            context.colorScheme.primaryColor.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  CachedNetworkImageWidget _eventImage(
      BuildContext context, String imageUrl, double height, double width) {
    return CachedNetworkImageWidget(
      imageUrl: imageUrl,
      height: height,
      width: width,
      maxHeightDiskCache: ResponsiveUtils.screenWidth(context),
    );
  }

  Padding eventTitle(BuildContext context, String title, EdgeInsets padding) {
    return Padding(
      padding: padding,
      child: Text(
        title,
        style: fontTheme.heading(context),
      ),
    );
  }

  Padding eventUTitle(BuildContext context, String title, EdgeInsets padding) {
    return Padding(
      padding: padding,
      child: Text(
        title,
        style: fontTheme.profileheading(context),
      ),
    );
  }

  get eventLocation => _eventLocation;
  get eventTime => _eventTime;
  get eventImage => _eventImage;
}

class EventDateContainer extends StatelessWidget {
  final double? top;

  final double? bottom;
  final double? right;
  final double? left;


  const EventDateContainer({

    Key? key,
    this.top,
    this.right,
    this.bottom,
    this.left,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    FontThemeClass fontTheme = FontThemeClass();
    return Positioned(
      top: top,
      left: left,
      bottom: bottom,
      right: right,
      child: Container(
        height: 60.hWise,
        width: 60.wWise,
        decoration: BoxDecoration(
          color: context.colorScheme.secondaryWhiteColor,
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.secondarySectionColor.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        // Event Date
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
              style: fontTheme.subHeading2(
                  context, context.colorScheme.secondaryBlackColor),
            ),
          ],
        ),
      ),
    );
  }
}

class EventDateUContainer extends StatelessWidget {
  final double? top;
  final double? bottom;
  final double? right;
  final double? left;
  const EventDateUContainer({
    Key? key,
    this.top,
    this.right,
    this.bottom,
    this.left,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FontThemeClass fontTheme = FontThemeClass();
    return Positioned(
      top: top,
      left: left,
      bottom: bottom,
      right: right,
      child: Container(
        height: 50.hWise,
        width: 50.wWise,
        decoration: BoxDecoration(
          color: context.colorScheme.secondaryWhiteColor,
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.secondarySectionColor.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        // Event Date
        child: Column(
          children: [
            Text(
              "26",
              style:
                  fontTheme.heading(context, context.colorScheme.primaryColor),

            ),
            Text(
              "Feb",
              style: fontTheme.subHeading2(
                  context, context.colorScheme.secondaryBlackColor),
            ),
          ],
        ),
      ),
    );
  }
}

class EventCardInfo extends StatelessWidget {
  const EventCardInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    EventDetails eventDetails = EventDetails();
    return Positioned(
      child: SizedBox(
        height: 250.hWise,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            // Event Image
            eventDetails.eventImage(
              context,
              "https://imgs.search.brave.com/y2ve9MehABcSRTFjQYPcwpiFeueug4jPMSBV80j3lew/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXRteXVuaS5j/b20vYXp1cmUvY29s/bGVnZS1pbWFnZS9i/aWcvYmhhcmF0aS12/aWR5YXBlZXRocy1p/bnN0aXR1dGUtb2Yt/bWFuYWdlbWVudC1z/dHVkaWVzLXJlc2Vh/cmNoLWJ2aW1zci1t/dW1iYWkuanBn",
              160.hWise,
              ResponsiveUtils.screenWidth(context),
            ),
            SizedBox(
              height: 28.hWise,
            ),
            // Event Info
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Event Info
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Event Title
                        eventDetails.eventTitle(context, 'Abhiyaan',
                            EdgeInsets.only(left: 22.padL.left)),
                        SizedBox(
                          height: 4.hWise,
                        ),
                        //  Event Time and Location
                        Padding(
                          padding: EdgeInsets.only(left: 20.padL.left),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              eventDetails.eventTime(context),
                              SizedBox(
                                width: 8.wWise,
                              ),
                              eventDetails.eventLocation(context),
                            ],
                          ),
                        )
                      ],
                    ),
                    // Event Button
                    Padding(
                      padding: EdgeInsets.only(right: 8.padR.right),
                      child: Transform.rotate(
                        angle: 180 * 314 / 22,
                        child: IconButton(
                          onPressed: () {},
                          splashRadius: 20.wWise,
                          tooltip: "Details",
                          icon: Icon(
                            Icons.send_rounded,
                            size: 36.wWise,
                            color: context.colorScheme.primaryColor,
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
    );
  }
}


class EventCardUpcoming extends StatelessWidget {
  const EventCardUpcoming({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    UCEventDetails uceventDetails = UCEventDetails();
    return Positioned(
      child: SizedBox(
        height: 175.hWise,
        width: 200.wWise,
        child: Column(
          children: [
            // Event Image
            uceventDetails.eventImage(
              context,
              "https://imgs.search.brave.com/y2ve9MehABcSRTFjQYPcwpiFeueug4jPMSBV80j3lew/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXRteXVuaS5j/b20vYXp1cmUvY29s/bGVnZS1pbWFnZS9i/aWcvYmhhcmF0aS12/aWR5YXBlZXRocy1p/bnN0aXR1dGUtb2Yt/bWFuYWdlbWVudC1z/dHVkaWVzLXJlc2Vh/cmNoLWJ2aW1zci1t/dW1iYWkuanBn",
              125.hWise,
              ResponsiveUtils.screenWidth(context),
            ),
            SizedBox(
              height: 8.hWise,
            ),
            // Event Info
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Event Info
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Event Title
                        uceventDetails.eventUTitle(
                            context,
                            'Abhiyaan',
                            EdgeInsets.only(
                                left: 15.padL.left, top: 4.padT.top)),

                        //  Event Time and Location
                        Padding(
                          padding: EdgeInsets.only(left: 15.padL.left),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              uceventDetails.eventTime(context),
                              SizedBox(
                                height: 8.wWise,
                              ),
                              uceventDetails.eventLocation(context),
                            ],
                          ),
                        )
                      ],
                    ),
                    // Event Button
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}




