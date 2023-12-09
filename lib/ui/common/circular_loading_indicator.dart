import '../../file_exporter.dart';

class CircularLoadingIndicator extends StatelessWidget {
  final double height;

  const CircularLoadingIndicator({super.key, this.height = 100.0});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height.sp,
        width: height.sp,
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          backgroundColor: context.colorScheme.secondaryWhiteColor,
          valueColor: AlwaysStoppedAnimation<Color>(
            context.colorScheme.secondarySectionColor,
          ),
        ),
      ),
    );
  }
}
