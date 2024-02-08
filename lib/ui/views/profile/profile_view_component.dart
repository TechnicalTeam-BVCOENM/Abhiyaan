part of 'profile_view.dart';

final _analyticsService = locator<AnalyticsService>();

class SocialLinks extends StatelessWidget {
  final String iconpath;
  final String url;
  const SocialLinks({super.key, required this.iconpath, required this.url});
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          _analyticsService.logEvent(
              eventName: "Profile_Social_Links",
              value: "Social Links button clicked");
          UrlLauncher externalUrlHandler = UrlLauncher();
          externalUrlHandler.launchURL(
            url,
          );
        },
        child: Container(
          width: 47.r,
          height: 47.r,
          decoration: BoxDecoration(
            color: context.colorScheme.secondaryWhiteColor,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Padding(
            padding: const EdgeInsets.all(9).r,
            child: Image.asset(iconpath),
          ),
        ));
  }
}

class Cerificatation extends StatelessWidget {
  const Cerificatation({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: ListTile(
        minVerticalPadding: 15.r,
        tileColor: context.colorScheme.secondaryWhiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        leading: SizedBox(
          width: 60.w,
          child: Icon(
            Icons.credit_card_outlined,
            size: 30.r,
            color: context.colorScheme.primaryColor,
          ),
        ),
        title: Text(
          "Certification",
          style: FontThemeClass().body(
            context,
            color: context.colorScheme.secondaryBlackColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          "There are no certifications available",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: FontThemeClass().caption(
            context,
            color: context.colorScheme.secondaryBlackColor.withOpacity(0.6),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 25.r,
          color: context.colorScheme.secondaryBlackColor.withOpacity(0.8),
        ),
      ),
    ).animate(delay: 100.ms).fadeIn(
          delay: 200.ms,
          curve: Curves.easeInOut,
          duration: 600.ms,
        );
  }
}

class AppBarWidget extends ViewModelWidget<ProfileViewModel> {
  const AppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    return AppBar(
      backgroundColor: context.colorScheme.backgroundColor,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      // title: Center(
      //   child: Text(
      //     "Profile",
      //     style: FontThemeClass().title(
      //       context,
      //       fontWeight: FontWeight.w600,
      //       color: context.colorScheme.secondaryBlackColor,
      //     ),
      //   ),
      // ),
    );
  }
}

class ProfileCard extends ViewModelWidget<ProfileViewModel> {
  const ProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    return GestureDetector(
      onTap: () => viewModel._navigationService.navigateToPreferencesView(),
      child: ListTile(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        tileColor: context.colorScheme.secondaryWhiteColor,
        minVerticalPadding: 10.r,
        title: Row(
          children: [
            Hero(
              tag: "profileImage",
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100).r,
                clipBehavior: Clip.hardEdge,
                child: CachedNetworkImage(
                  imageUrl: AssetUrls.dummyImageUrl,
                  width: 50.w,
                  height: 50.h,
                ),
              ),
            ),
            12.horizontalSpace,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  viewModel.localStorageService.read('userName'),
                  style: FontThemeClass().title2(
                    context,
                    color: context.colorScheme.secondaryBlackColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "View Profile Information",
                  style: FontThemeClass().caption(
                    context,
                    color: context.colorScheme.secondaryBlackColor
                        .withOpacity(0.8),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  "View",
                  style: FontThemeClass().body(context,
                      color: context.colorScheme.secondaryBlackColor
                          .withOpacity(0.6),
                      fontWeight: FontWeight.w600),
                ),
                4.horizontalSpace,
                Icon(
                  Icons.arrow_forward_ios_sharp,
                  color:
                      context.colorScheme.secondaryBlackColor.withOpacity(0.8),
                  size: 15.r,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HelpSupportTile extends ViewModelWidget<ProfileViewModel> {
  const HelpSupportTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    return GestureDetector(
      onTap: () {
        viewModel.navigateToHelpSupport();
      },
      child: ListTile(
        minVerticalPadding: 25.r,
        tileColor: context.colorScheme.secondaryWhiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        leading: SizedBox(
          width: 60.w,
          child: Icon(
            Icons.warning_amber_rounded,
            size: 30.r,
            color: context.colorScheme.primaryColor,
          ),
        ),
        title: Text(
          "Help & Support",
          style: FontThemeClass().body(
            context,
            color: context.colorScheme.secondaryBlackColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 25.r,
          color: context.colorScheme.secondaryBlackColor.withOpacity(0.8),
        ),
      ),
    ).animate(delay: 100.ms).fadeIn(
          delay: 200.ms,
          curve: Curves.easeInOut,
          duration: 600.ms,
        );
  }
}

class PrivacyPolicyTile extends ViewModelWidget<ProfileViewModel> {
  const PrivacyPolicyTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    return GestureDetector(
      onTap: () {
        viewModel.navigateToPrivacyPolicy();
      },
      child: ListTile(
        minVerticalPadding: 25.r,
        tileColor: context.colorScheme.secondaryWhiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        leading: SizedBox(
          width: 60.w,
          child: Icon(
            Icons.privacy_tip_outlined,
            size: 30.r,
            color: context.colorScheme.primaryColor,
          ),
        ),
        title: Text(
          "Privacy Policy",
          style: FontThemeClass().body(
            context,
            color: context.colorScheme.secondaryBlackColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 25.r,
          color: context.colorScheme.secondaryBlackColor.withOpacity(0.8),
        ),
      ),
    ).animate(delay: 100.ms).fadeIn(
          delay: 200.ms,
          curve: Curves.easeInOut,
          duration: 600.ms,
        );
  }
}

class DarkModeTile extends ViewModelWidget<ProfileViewModel> {
  const DarkModeTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    return ListTile(
      minVerticalPadding: 25.r,
      tileColor: context.colorScheme.secondaryWhiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      leading: SizedBox(
        width: 60.w,
        child: Icon(
          Icons.dark_mode_outlined,
          size: 30.r,
          color: context.colorScheme.primaryColor,
        ),
      ),
      title: Text(
        "Dark Mode",
        style: FontThemeClass().body(
          context,
          color: context.colorScheme.secondaryBlackColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Switch.adaptive(
        activeColor: context.colorScheme.switchColor,
        value: viewModel._themeService.valueListenable.value,
        onChanged: (val) => viewModel.changeTheme(),
      ),
    ).animate(delay: 100.ms).fadeIn(
          delay: 200.ms,
          curve: Curves.easeInOut,
          duration: 600.ms,
        );
  }
}
