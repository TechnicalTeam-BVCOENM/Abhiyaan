// ignore_for_file: unused_element

import 'package:abhiyaan/file_exporter.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OnboardingComponents {
  static List<Widget> getOnboardingPages(BuildContext context) {
    return [
      onboardingPage(
          context,
          const Color.fromARGB(255, 193, 192, 238),
          500,
          ["Let's", "Explore", "Bvcoenm"],
          AssetImagePath.boy,
          30,
          0,
          const Offset(0, 0.02)),
      onboardingPage(
          context,
          const Color.fromARGB(255, 149, 219, 219),
          250,
          ["Build", "New", "Network"],
          AssetImagePath.connect,
          130,
          300,
          const Offset(0, 0.08)),
      onboardingPage(
          context,
          const Color.fromARGB(255, 192, 230, 149),
          310,
          ["Get", "Latest", "Updates"],
          AssetImagePath.events,
          100,
          250,
          const Offset(0, 0.06)),
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
      Offset offset) {
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
                padding: const EdgeInsets.only(left: 20, top: 20, right: 140),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(72, 249, 233, 232),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var quote in quote)
                      Text(
                        quote,
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
