// ignore_for_file: unused_element

import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/ui/views/auth/onboarding/onboarding_view.dart';
import 'package:flutter_animate/flutter_animate.dart';

class _FloatingImage extends StatefulWidget {
  final double left;
  final double? top;
  final double? right;
  final double? bottom;
  final double width;
  final String imagePath;
  final Duration duration;
  final Offset endOffset; // End position of the animation

  const _FloatingImage({
    required this.left,
    this.top,
    this.right,
    this.bottom,
    required this.width,
    required this.imagePath,
    required this.duration,
    required this.endOffset,
  });

  @override
  __FloatingImageState createState() => __FloatingImageState();
}

class __FloatingImageState extends State<_FloatingImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      reverseDuration: widget.duration,
    )..repeat(reverse: true);

    _animation = Tween<Offset>(
      begin: Offset.zero, // Use startOffset as the start position
      end: widget.endOffset, // Use endOffset as the end position
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.left.w,
      top: widget.top?.h,
      right: widget.right?.w,
      bottom: widget.bottom?.h,
      child: SlideTransition(
        position: _animation,
        child: SizedBox(
          width: widget.width,
          child: Image.asset(widget.imagePath),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class PageIndicator extends ViewModelWidget<OnboardingViewModel> {
  const PageIndicator({super.key});

  @override
  Widget build(BuildContext context, OnboardingViewModel viewModel) {
    return Container(
      alignment: const Alignment(0, 0.65),
      child: SmoothPageIndicator(
          effect: const WormEffect(dotHeight: 10, dotWidth: 10),
          onDotClicked: (index) {
            viewModel.pageController.jumpToPage(index);
          },
          controller: viewModel.pageController,
          count: 3),
    );
  }
}

class PageControllerIcons extends ViewModelWidget<OnboardingViewModel> {
  const PageControllerIcons({super.key});

  @override
  Widget build(BuildContext context, OnboardingViewModel viewModel) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 40),
        alignment: const Alignment(0, 0.85),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: 60.r,
                height: 60.r,
                child: viewModel.activeindex != 0
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(300), // Rounded corners
                          ),
                        ),
                        onPressed: () {
                          viewModel.updateindex(
                              context, false, viewModel.activeindex);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: context.colorScheme.secondaryText,
                        ))
                    : Container()),
            SizedBox(
              width: 60.r,
              height: 60.r,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(300), // Rounded corners
                    ),
                  ),
                  onPressed: () {
                    viewModel.updateindex(context, true, viewModel.activeindex);
                  },
                  child: viewModel.activeindex != 2
                      ? Icon(
                          Icons.arrow_forward,
                          color: context.colorScheme.secondaryText,
                        )
                      : const Icon(
                          Icons.done_rounded,
                          color: Colors.green,
                        )),
            )
          ],
        ));
  }
}

class OnboardingComponents {
  static List<Widget> getOnboardingPages(BuildContext context) {
    return [
      onboardingPage(
        context,
        const Color.fromARGB(255, 193, 192, 238),
        500,
        ["Let's", "Explore", "Abhiyaan"],
        AssetImagePath.boy,
        30,
        0,
        const Offset(0, 0.02),
        "Stay Informed with College Updates",
      ),
      onboardingPage(
        context,
        const Color.fromARGB(255, 149, 219, 219),
        250,
        ["Celebrate", "Cultural & ", "Social Events"],
        AssetImagePath.connect,
        130,
        300,
        const Offset(0, 0.08),
        "Experience Unity in Diversity with Abhiyaan Community",
      ),
      onboardingPage(
        context,
        const Color.fromARGB(255, 192, 230, 149),
        310,
        ["Unleash the", "Power of App"],
        AssetImagePath.events,
        100,
        250,
        const Offset(0, 0.06),
        "Access Exclusive Event Details & \nReal-time College Updates",
      ),
      // Add more onboarding pages here as needed
    ];
  }

  static Widget onboardingPage(
    BuildContext context,
    Color backgroundColor,
    double width,
    List<String> quote,
    String imagePath,
    double left,
    double top,
    Offset offset,
    String description, // Adding description here
  ) {
    return Container(
      color: backgroundColor,
      child: Column(
        children: [
          const SizedBox(height: 50),
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 600.h,
                padding: const EdgeInsets.only(left: 20, top: 20),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(72, 249, 233, 232),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var quoteText in quote)
                      Text(
                        quoteText,
                        style: FontThemeClass().display(
                          context,
                          color: const Color.fromARGB(255, 69, 69, 69),
                          fontWeight: FontWeight.w700,
                        ),
                      ).animate(delay: 400.ms).slideY(
                            delay: 100.ms,
                            curve: Curves.easeInOut,
                            duration: 500.ms,
                          ),
                    const SizedBox(
                        height:
                            10), // Adding spacing between heading and description
                    Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        child: Text(
                          description,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 117, 117, 117),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ).animate(delay: 200.ms).fadeIn(
                    delay: 100.ms,
                    curve: Curves.easeInOut,
                    duration: 1000.ms,
                  ),
              _FloatingImage(
                endOffset: offset,
                left: left,
                top: top,
                width: width,
                imagePath: imagePath,
                duration: const Duration(seconds: 4),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class OnboardingPageView extends ViewModelWidget<OnboardingViewModel> {
  const OnboardingPageView({super.key});

  @override
  Widget build(BuildContext context, OnboardingViewModel viewModel) {
    return PageView(
      onPageChanged: (index) {
        viewModel.index(index);
      },
      controller: viewModel.pageController,
      children: [
        for (var onboardingPages
            in OnboardingComponents.getOnboardingPages(context))
          onboardingPages,
      ],
    );
  }
}
