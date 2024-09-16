part of 'preferences_view.dart';

PreferredSizeWidget _appBar(BuildContext context) {
  final model = PreferencesViewModel();
  return AppBar(
    leading: GestureDetector(
      onTap: () {
        model._navigationService.back();
      },
      child: Container(
        color: context.colorScheme.scaffold,
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: context.colorScheme.primaryText,
        ),
      ),
    ),
    backgroundColor: context.colorScheme.scaffold,
    centerTitle: true,
    elevation: 0,
    title: Text(
      "My Details",
      style: model.fontTheme.title(
        context,
        color: context.colorScheme.primaryText,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

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
            fontSize: 18.sp,
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
        tileColor: context.colorScheme.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20).r,
        ),
        leading: SizedBox(
          child: Icon(
            Icons.lock_outline_rounded,
            size: 35.r,
            color: context.colorScheme.secondary.withOpacity(0.6),
          ),
        ),
        subtitle: Text(
          "Click to change your password",
          style: FontThemeClass().caption(
            context,
            color: context.colorScheme.secondaryText,
            fontWeight: FontWeight.w500,
          ),
        ),
        title: Text(
          "Change Password",
          style: viewModel.fontTheme.body(
            context,
            color: context.colorScheme.primaryText,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: GestureDetector(
          onTap: () {
            viewModel.passwordChangeAlert(context);
          },
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 25.r,
            color: context.colorScheme.primaryText.withOpacity(0.6),
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
      tileColor: context.colorScheme.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12).r,
      ),
      leading: SizedBox(
        child: Icon(
          Icons.school_outlined,
          size: 35.r,
          color: context.colorScheme.secondary.withOpacity(0.6),
        ),
      ),
      trailing: GestureDetector(
        onTap: () {
          viewModel.copyText("Unique ID", misNumber, context);
        },
        child: Icon(
          Icons.copy_outlined,
          color: context.colorScheme.primaryText.withOpacity(0.6),
          size: 25.r,
        ),
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Unique ID",
            style: FontThemeClass().body(
              context,
              color: context.colorScheme.primaryText,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            misNumber,
            style: FontThemeClass().caption(
              context,
              color: context.colorScheme.secondaryText,
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
      tileColor: context.colorScheme.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12).r,
      ),
      leading: SizedBox(
        child: Icon(
          Icons.email_outlined,
          size: 35.r,
          color: context.colorScheme.secondary.withOpacity(0.6),
        ),
      ),
      trailing: GestureDetector(
        onTap: () {
          viewModel.copyText("Email Id", emailID, context);
        },
        child: Icon(
          Icons.copy_outlined,
          color: context.colorScheme.primaryText.withOpacity(0.6),
          size: 25.r,
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
              color: context.colorScheme.primaryText,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            emailID,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: FontThemeClass().caption(
              context,
              color: context.colorScheme.secondaryText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
