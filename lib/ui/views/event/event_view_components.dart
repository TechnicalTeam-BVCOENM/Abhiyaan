part of 'event_view.dart';

// Event Time and location component
class EventDetails {
  Row _eventLocation(BuildContext context) {
    FontThemeClass fontTheme = FontThemeClass();

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
    FontThemeClass fontTheme = FontThemeClass();

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

  get eventLocation => _eventLocation;
  get eventTime => _eventTime;
  get eventImage => _eventImage;
}

class EventDateContainer extends StatelessWidget {
  const EventDateContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    FontThemeClass fontTheme = FontThemeClass();
    return Positioned(
      top: 120.hWise,
      left: 20.wWise,
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
              style: fontTheme.large(context, FontWeight.w600),
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
    FontThemeClass fontTheme = FontThemeClass();
    EventDetails eventDetails = EventDetails();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Event Info
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Event Title
                Padding(
                  padding: EdgeInsets.only(left: 22.padL.left),
                  child: Text(
                    "Abhiyaan",
                    style: fontTheme.heading(context),
                  ),
                ),
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
    );
  }
}