part of 'register_view.dart';

// BUTTONS
Column buildRegisterButton(RegisterViewModel model, BuildContext context) {
  return Column(
    children: [
      TextButton(
        onPressed: () async {
          model.register(context);
        },
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(Size(double.infinity, 50)),
          backgroundColor:
              WidgetStatePropertyAll(context.colorScheme.accentColor),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0).r,
            ),
          ),
        ),
        child: Text(
          'Register',
          style: FontThemeClass().title2(
            context,
            color: context.colorScheme.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ).animate(delay: 700.ms).fadeIn(
            delay: 100.ms,
            curve: Curves.easeInOut,
            duration: 700.ms,
          ),
      10.verticalSpace,
      GestureDetector(
        onTap: () => model.navigateToHelpSupport(),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Problem with Registration? ',
            style: FontThemeClass().caption(
              context,
              color: context.colorScheme.secondaryText,
              fontWeight: FontWeight.w500,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'Report Issue',
                style: FontThemeClass().caption(
                  context,
                  color: context.colorScheme.accentColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ).animate(delay: 900.ms).fadeIn(
            delay: 100.ms,
            curve: Curves.easeInOut,
            duration: 700.ms,
          ),
    ],
  );
}

// TEXTFIELDS
TextFormField buildPasswordConfirmTextfield(
    BuildContext context, RegisterViewModel model) {
  return TextFormField(
    keyboardType: TextInputType.visiblePassword,
    cursorColor: context.colorScheme.accentColor,
    controller: model.confirmpasswordTextController,
    obscureText: model.isConfirmPasswordVisible ? false : true,
    decoration: InputDecoration(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 30, vertical: 15).r,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          const Radius.circular(150).r,
        ),
        borderSide: BorderSide.none,
      ),
      fillColor: context.colorScheme.card,
      filled: true,
      focusColor: context.colorScheme.card,
      suffixIcon: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          model.toggleConfirmPasswordVisibility();
        },
        child: model.isConfirmPasswordVisible
            ? Icon(
                Icons.visibility_off,
                color: context.colorScheme.secondaryText,
              )
            : Icon(
                Icons.visibility,
                color: context.colorScheme.secondaryText,
              ),
      ),
      hintText: 'Confirm Password',
      hintStyle: model.fontTheme.caption(
        context,
        color: context.colorScheme.secondaryText,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

TextFormField buildPasswordTextfield(
    BuildContext context, RegisterViewModel model) {
  return TextFormField(
    keyboardType: TextInputType.visiblePassword,
    cursorColor: context.colorScheme.accentColor,
    controller: model.createpasswordTextController,
    obscureText: model.isCreatePasswordVisible ? false : true,
    decoration: InputDecoration(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 30, vertical: 15).r,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            const Radius.circular(150).r,
          ),
          borderSide: BorderSide.none),
      fillColor: context.colorScheme.card,
      filled: true,
      focusColor: context.colorScheme.card,
      suffixIcon: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          model.toggleCreatePasswordVisibility();
        },
        child: model.isCreatePasswordVisible
            ? Icon(
                Icons.visibility_off,
                color: context.colorScheme.secondaryText,
              )
            : Icon(
                Icons.visibility,
                color: context.colorScheme.secondaryText,
              ),
      ),
      hintText: 'Create Password',
      hintStyle: model.fontTheme.caption(
        context,
        color: context.colorScheme.secondaryText,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

TextFormField buildUsernameTextfield(
    BuildContext context, RegisterViewModel model) {
  return TextFormField(
    cursorColor: context.colorScheme.accentColor,
    controller: model.userNameController,
    decoration: InputDecoration(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 30, vertical: 15).r,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          const Radius.circular(150).r,
        ),
        borderSide: BorderSide.none,
      ),
      fillColor: context.colorScheme.card,
      filled: true,
      focusColor: context.colorScheme.card,
      hintText: 'Username',
      errorText: model.isEmailIdValid ? null : model.emailIdErrorText,
      hintStyle: model.fontTheme.caption(
        context,
        color: context.colorScheme.secondaryText,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

TextFormField buildEmailTextfield(
    BuildContext context, RegisterViewModel model) {
  return TextFormField(
    keyboardType: TextInputType.emailAddress,
    cursorColor: context.colorScheme.accentColor,
    controller: model.emailIdTextController,
    onChanged: (value) {
      model.emailIdTextController.text =
          model.emailIdTextController.text.trim();
    },
    decoration: InputDecoration(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 30, vertical: 15).r,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          const Radius.circular(150).r,
        ),
        borderSide: BorderSide.none,
      ),
      fillColor: context.colorScheme.card,
      filled: true,
      focusColor: context.colorScheme.card,
      hintText: 'Email ID',
      errorText: model.isEmailIdValid ? null : model.emailIdErrorText,
      hintStyle: model.fontTheme.caption(
        context,
        color: context.colorScheme.secondaryText,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

// OTHERS
Column buildInfoWidget(BuildContext context) {
  return Column(
    children: [
      Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: context.colorScheme.primary,
                    spreadRadius: -45,
                    blurRadius: 70.0,
                  ),
                ],
              ),
              child: SizedBox(
                width: 200.w,
                height: 200.h,
                child: Image.asset(
                  AssetImagePath.logoImg,
                ),
              )).animate(delay: 100.ms).fadeIn(
            delay: 100.ms,
            curve: Curves.easeInOut,
            duration: 700.ms,
          ),
      Text("Abhiyaan",
              textAlign: TextAlign.center,
              style: FontThemeClass().header(
                context,
              )).animate(delay: 100.ms).fadeIn(
            delay: 200.ms,
            curve: Curves.easeInOut,
            duration: 500.ms,
          ),
      Text("Connect with Students, Teachers & Alumni",
              textAlign: TextAlign.center,
              style: FontThemeClass().body(
                context,
                color: context.colorScheme.secondaryText,
                fontWeight: FontWeight.w500,
              )).animate(delay: 200.ms).fadeIn(
            delay: 100.ms,
            curve: Curves.easeInOut,
            duration: 500.ms,
          ),
    ],
  );
}

Text buildVersionInfoWidget(BuildContext context) {
  return Text(
    'Abhiyaan v${AppConstants.appVersion}',
    textAlign: TextAlign.center,
    style: FontThemeClass().caption(
      context,
      color: context.colorScheme.secondaryText.withOpacity(0.18),
      fontWeight: FontWeight.w500,
    ),
  );
}

Column buildRegisterDisabledWidget(
    FontThemeClass font, BuildContext context, RegisterViewModel model) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      320.verticalSpace,
      Image.asset(
        "assets/images/auth/road_closure.png",
        width: 100.w,
      ),
      20.verticalSpace,
      Text(
        "We're sorry, this feature is currently not available.".toUpperCase(),
        textAlign: TextAlign.center,
        style: font.body(
          context,
          color: context.colorScheme.primaryText,
          fontWeight: FontWeight.w800,
        ),
      ),
      10.verticalSpace,
      Text(
        "Please try again later.".toUpperCase(),
        textAlign: TextAlign.center,
        style: font.small(
          context,
          color: context.colorScheme.primaryText.withOpacity(0.5),
          fontWeight: FontWeight.w600,
        ),
      ),
      10.verticalSpace,
      TextButton(
          onPressed: () {
            model.navigateToAuth();
          },
          child: Text("Go Back",
              style: font.caption(
                context,
                color: context.colorScheme.accentColor,
                fontWeight: FontWeight.w500,
              ))),
    ],
  );
}
