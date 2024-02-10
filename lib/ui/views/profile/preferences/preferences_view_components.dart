part of 'preferences_view.dart';

class LogoutButton extends ViewModelWidget<PreferencesViewModel> {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, PreferencesViewModel viewModel) {
    return GestureDetector(
      onTap: () => viewModel.logoutAlert(context),
      child: Center(
        child: Text(
          "Logout",
          style: viewModel.fontTheme.body(
            context,
            color: Colors.red.withOpacity(0.8),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class PasswordChangeTile extends ViewModelWidget<PreferencesViewModel> {
  const PasswordChangeTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, PreferencesViewModel viewModel) {
    return GestureDetector(
      onTap: () {
        viewModel.passwordChangeAlert(context);
      },
      child: ListTile(
        minVerticalPadding: 15.r,
        tileColor: context.colorScheme.primaryCardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20).r,
        ),
        leading: SizedBox(
          width: 60.w,
          child: Icon(
            Icons.lock_outline_rounded,
            size: 30.r,
            color: context.colorScheme.primaryAccentColor,
          ),
        ),
        subtitle: Text(
          "Click to change your password",
          style: FontThemeClass().caption(
            context,
            color: context.colorScheme.secondaryTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        title: Text(
          "Change Password",
          style: viewModel.fontTheme.body(
            context,
            color: context.colorScheme.primaryTextColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: GestureDetector(
          onTap: () {
            viewModel.passwordChangeAlert(context);
          },
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            color: context.colorScheme.primaryTextColor,
          ),
        ),
      ),
    );
  }
}

class MisNumberTile extends ViewModelWidget<PreferencesViewModel> {
  const MisNumberTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, PreferencesViewModel viewModel) {
    final misNumber =
        viewModel.localStorageService.read('userMisNo').toString();
    return ListTile(
      minVerticalPadding: 15.r,
      tileColor: context.colorScheme.primaryCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20).r,
      ),
      leading: SizedBox(
        width: 60.w,
        child: Icon(
          Icons.school_outlined,
          size: 30.r,
          color: context.colorScheme.primaryAccentColor,
        ),
      ),
      trailing: GestureDetector(
        onTap: () {
          viewModel.copyText("MIS Number", misNumber, context);
        },
        child: Icon(
          Icons.copy_outlined,
          color: context.colorScheme.primaryTextColor,
        ),
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "MIS Number",
            style: FontThemeClass().body(
              context,
              color: context.colorScheme.primaryTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            misNumber,
            style: FontThemeClass().caption(
              context,
              color: context.colorScheme.secondaryTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class EmailAdressTile extends ViewModelWidget<PreferencesViewModel> {
  const EmailAdressTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, PreferencesViewModel viewModel) {
    final emailID = viewModel.localStorageService.read('userEmail').toString();
    return ListTile(
      minVerticalPadding: 15.r,
      tileColor: context.colorScheme.primaryCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20).r,
      ),
      leading: SizedBox(
        width: 60.w,
        child: Icon(
          Icons.email_outlined,
          size: 30.r,
          color: context.colorScheme.primaryAccentColor,
        ),
      ),
      trailing: GestureDetector(
        onTap: () {
          viewModel.copyText("Email Id", emailID, context);
        },
        child: Icon(
          Icons.copy_outlined,
          color: context.colorScheme.primaryTextColor,
        ),
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Email Id",
            style: FontThemeClass().body(
              context,
              color: context.colorScheme.primaryTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            emailID,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: FontThemeClass().caption(
              context,
              color: context.colorScheme.secondaryTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
