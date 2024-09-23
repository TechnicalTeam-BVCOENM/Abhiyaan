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
          value: "Social Links button clicked",
        );
        UrlLauncher externalUrlHandler = UrlLauncher();
        externalUrlHandler.launchURL(url);
      },
      child: Container(
        width: 52.r,
        height: 52.r,
        decoration: BoxDecoration(
          color: context.colorScheme.card,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12).r,
          child: Image.asset(iconpath),
        ),
      ),
    );
  }
}

class Cerificatation extends StatelessWidget {
  const Cerificatation({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: ListTile(
        tileColor: context.colorScheme.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        leading: SizedBox(
          child: Icon(
            Icons.credit_card_outlined,
            size: 30.r,
            color: context.colorScheme.secondary.withOpacity(0.6),
          ),
        ),
        title: Text(
          "Certification",
          style: FontThemeClass().body(
            context,
            color: context.colorScheme.primaryText,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          "There are no certifications available",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: FontThemeClass().caption(
            context,
            color: context.colorScheme.secondaryText,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 20.r,
          color: context.colorScheme.primaryText.withOpacity(0.5),
        ),
      ),
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
      backgroundColor: context.colorScheme.scaffold,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Center(
        child: Text(
          "Profile",
          style: FontThemeClass().title(context),
        ),
      ),
    );
  }
}

class ProfileImageWidget extends ViewModelWidget<ProfileViewModel> {
  const ProfileImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    final font = FontThemeClass();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.r),
      child: Column(
        children: [
          ColoredBox(
            color: Colors.transparent,
            child: Hero(
              tag: "profileImage",
              child: ClipOval(
                child: CachedNetworkImage(
                  width: 100.r,
                  height: 100.r,
                  fit: BoxFit.cover,
                  imageUrl: AssetUrls.profileImageUrl == '' ||
                          AssetUrls.profileImageUrl == 'Not Available'
                      ? AssetUrls.dummyImageUrl
                      : AssetUrls.profileImageUrl,
                  placeholder: (context, url) =>
                      const CircularLoadingIndicator(),
                  errorWidget: (context, url, error) {
                    return const Icon(Icons.error);
                  },
                ),
              ),
            ),
          ),
          Text(
            viewModel.localStorageService.read('userName'),
            style: font.title2(
              context,
              color: context.colorScheme.primaryText,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            viewModel.localStorageService.read('userProfile'),
            style: font.body(
              context,
              color: context.colorScheme.secondarySectionColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileSectionText extends ViewModelWidget<ProfileViewModel> {
  final String title;
  const ProfileSectionText({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(title,
          style: FontThemeClass().body(
            context,
            color: context.colorScheme.primaryText,
            fontWeight: FontWeight.w700,
            fontSize: 18.sp,
          )),
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
        tileColor: context.colorScheme.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        leading: SizedBox(
          child: Icon(
            Icons.person_2_outlined,
            size: 30.r,
            color: context.colorScheme.secondary.withOpacity(0.6),
          ),
        ),
        title: Text(
          "Personal Info",
          style: FontThemeClass().body(
            context,
            color: context.colorScheme.primaryText,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 20.r,
          color: context.colorScheme.primaryText.withOpacity(0.5),
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
        tileColor: context.colorScheme.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        leading: SizedBox(
          child: Icon(
            Icons.warning_amber_rounded,
            size: 30.r,
            color: context.colorScheme.secondary.withOpacity(0.6),
          ),
        ),
        title: Text(
          "Help & Support",
          style: FontThemeClass().body(
            context,
            color: context.colorScheme.primaryText,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 20.r,
          color: context.colorScheme.primaryText.withOpacity(0.5),
        ),
      ),
    );
  }
}

class RateAppTile extends ViewModelWidget<ProfileViewModel> {
  const RateAppTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    return GestureDetector(
      onTap: () {
        viewModel.rateApp(context);
      },
      child: ListTile(
        tileColor: context.colorScheme.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        leading: SizedBox(
          child: Icon(
            Icons.star_border_outlined,
            size: 30.r,
            color: context.colorScheme.secondary.withOpacity(0.6),
          ),
        ),
        title: Text(
          "Rate App",
          style: FontThemeClass().body(
            context,
            color: context.colorScheme.primaryText,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 20.r,
          color: context.colorScheme.primaryText.withOpacity(0.5),
        ),
      ),
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
        tileColor: context.colorScheme.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        leading: SizedBox(
          child: Icon(
            Icons.privacy_tip_outlined,
            size: 30.r,
            color: context.colorScheme.secondary.withOpacity(0.6),
          ),
        ),
        title: Text(
          "Privacy Policy",
          style: FontThemeClass().body(
            context,
            color: context.colorScheme.primaryText,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 20.r,
          color: context.colorScheme.primaryText.withOpacity(0.5),
        ),
      ),
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
        tileColor: context.colorScheme.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        leading: SizedBox(
          child: Icon(
            Icons.dark_mode_outlined,
            size: 30.r,
            color: context.colorScheme.secondary.withOpacity(0.6),
          ),
        ),
        title: Text(
          "Dark Mode",
          style: FontThemeClass().body(
            context,
            color: context.colorScheme.primaryText,
            fontWeight: FontWeight.w500,
          ),
        ),
        contentPadding: EdgeInsets.only(left: 16.r, right: 10.r),
        trailing: Transform.scale(
            scale: 0.85, // Adjust the scale factor as needed
            child: Switch.adaptive(
              activeColor: context.colorScheme.accentColor,
              inactiveThumbColor:
                  context.colorScheme.secondary.withOpacity(0.7),
              inactiveTrackColor: context.colorScheme.lightScaffold,
              trackOutlineColor: WidgetStateColor.resolveWith(
                (states) => context.colorScheme.secondary.withOpacity(0.7),
              ),
              value: viewModel._themeService.valueListenable.value,
              onChanged: (val) => viewModel.changeTheme(),
            )));
  }
}

// Widget PaddingWrapper(List<Widget> children) {
//   return Padding(
//     padding: EdgeInsets.symmetric(horizontal: 16.r),
//     child: children,
//   );
// }
