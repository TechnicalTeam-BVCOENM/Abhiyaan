import 'package:darpan/file_exporter.dart';

class OnboardingComponents {
  static List<Widget> getOnboardingPages(BuildContext context) {
    return [
      onboardingPage(context, const Color.fromARGB(255, 193, 192, 238),
          "Lets Explore Diversity", AssetImagePath.boy),
      onboardingPage(context, const Color.fromARGB(255, 149, 219, 219),
          "Meet Amazing People", AssetImagePath.boy),
      onboardingPage(context, const Color.fromARGB(255, 192, 230, 149),
          "Stay Updated", AssetImagePath.boy),
      // Add more onboarding pages here as needed
    ];
  }

  static Widget onboardingPage(BuildContext context, Color backgroundColor,
      String quote, String imagePath) {
    return Container(
      color: backgroundColor,
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 600.h,
                padding: const EdgeInsets.only(left: 20, top: 20, right: 140),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(72, 249, 233, 232),
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  quote,
                  style: FontThemeClass().display(context,
                      color: const Color.fromARGB(255, 69, 69, 69),
                      fontWeight: FontWeight.w700),
                ),
              ),
              Positioned(
                  left: 30.w,
                  child: SizedBox(
                    width: 500,
                    child: Image(image: AssetImage(imagePath)),
                  ))
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
