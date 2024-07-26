import 'package:abhiyaan/file_exporter.dart';
import 'package:flutter/cupertino.dart';

class CircularLoadingIndicator extends StatelessWidget {
  final double height;

  const CircularLoadingIndicator({super.key, this.height = 100.0});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        color: context.colorScheme.primaryText,
      ),
    );
  }
}
