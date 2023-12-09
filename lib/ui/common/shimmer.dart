import 'package:darpan/theme/app_color.dart';
import 'package:darpan/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingWidget extends StatelessWidget {
  const ShimmerLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.colorScheme.backgroundColor,
      highlightColor: context.colorScheme.secondaryLPurpleColor,
      child: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity, // Adjust the height as needed
      ),
    );
  }
}
