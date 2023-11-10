part of 'bottom_nav_view.dart';

class BottomNavActiveIcon extends ViewModelWidget<BottomNavViewModel> {
  final IconData icon;
  final String text;
  const BottomNavActiveIcon({
    required this.text,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, BottomNavViewModel viewModel) {
    return Container(
      height: kBottomNavigationBarHeight,
      margin: EdgeInsets.symmetric(horizontal: 0.wWise),
      decoration: BoxDecoration(
        color: context.colorScheme.selectedBottomNavIconbg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 3.hWise,
            decoration: BoxDecoration(
              color: context.colorScheme.primaryColor,
            ),
          ),
          const Spacer(),
          Icon(
            icon,
            color: context.colorScheme.selectedBottomNavIcon,
          ),
          2.hGap,
          Text(
            text,
            style: TextStyle(
              fontSize: 12.wWise,
              color: context.colorScheme.selectedBottomNavIcon,
              fontWeight: FontWeight.w700,
            ),
          ),
          4.hGap,
        ],
      ),
    );
  }
}
