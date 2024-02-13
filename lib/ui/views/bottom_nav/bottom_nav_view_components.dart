part of 'bottom_nav_view.dart';

class BottomNavActiveIcon extends ViewModelWidget<BottomNavViewModel> {
  final IconData icon;
  final String text;
  const BottomNavActiveIcon({
    required this.text,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context, BottomNavViewModel viewModel) {
    return Container(
      height: kBottomNavigationBarHeight,
      margin: EdgeInsets.symmetric(horizontal: 0.sp),
      decoration: BoxDecoration(
        color: context.colorScheme.primaryAccentColor.withOpacity(0.1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 3.sp,
            decoration: BoxDecoration(
              color: context.colorScheme.selectedBottomNavIcon,
            ),
          ),
          const Spacer(),
          Icon(
            icon,
            color: context.colorScheme.selectedBottomNavIcon,
          ),
          SizedBox(height: 2.sp),
          Text(
            text,
            style: TextStyle(
              fontSize: 12.sp,
              color: context.colorScheme.selectedBottomNavIcon,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4.sp),
        ],
      ),
    );
  }
}
