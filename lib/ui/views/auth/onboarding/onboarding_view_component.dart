// ignore_for_file: unused_element

import 'package:abhiyaan/file_exporter.dart';

class OnboardingComponents {
  static List<Widget> getOnboardingPages(BuildContext context) {
    return [
      onboardingPage(
        context,
        AssetImagePath.screen1,
        "Join the community, connect, and share ideas",
        "Become a part of vibrant community where students, teachers, and alumni connect, collaborate, and exchange ideas to enhance learning and growth.",
        isFirstPage: true,
      ),
      onboardingPage(
        context,
        AssetImagePath.screen2,
        "Stay updated with all the exciting events happening in campus",
        "Join various clubs and societies, participate in events, and showcase your talents. Explore opportunities, learn new skills, and grow as an individual.",
      ),
      onboardingPage(
        context,
        AssetImagePath.screen3,
        "Get notified and explore highlights",
        "Stay informed with important updates and announcements. Discover highlights that showcase your experiences and keep you engaged in campus activities and events.",
      ),
    ];
  }

  static Widget onboardingPage(
    BuildContext context,
    String imagePath,
    String quote,
    String description, {
    bool isFirstPage = false,
  }) {
    return Container(
      color: context.colorScheme.white,
      child: Column(
        children: [
          isFirstPage ? 0.verticalSpace : 34.verticalSpace,
          // IMAGE
          SizedBox(
            width: double.infinity,
            child: Image.asset(imagePath),
          ),
          32.verticalSpace,
          // TEXT
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  quote,
                  textAlign: TextAlign.center,
                  style: FontThemeClass().header(
                    context,
                    color: context.colorScheme.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                12.verticalSpace,
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: FontThemeClass().body(
                    context,
                    color: context.colorScheme.black.withOpacity(0.5),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
