import '../file_exporter.dart';

class CircularLoadingIndicator extends StatelessWidget {
  final double height;

  const CircularLoadingIndicator({Key? key, this.height = 100.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height.sp,
        width: height.sp,
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            context.colorScheme.secondarySectionColor,
          ),
        ),
      ),
    );
  }
}