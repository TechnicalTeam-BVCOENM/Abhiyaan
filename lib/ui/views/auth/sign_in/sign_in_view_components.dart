part of 'sign_in_view.dart';

ClipRRect buildLoginButton(BuildContext context, SignInViewModel model) {
  return ClipRRect(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30.r),
      topRight: Radius.circular(30.r),
    ),
    child: Container(
      width: double.infinity,
      color: context.colorScheme.backgroundDark,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: 0,
            ).r,
            child: TextButton(
              onPressed: () async {
                await model.login(
                  model.emailIdTextController.text,
                  model.passwordTextController.text,
                  context,
                );
              },
              style: ButtonStyle(
                minimumSize:
                    const WidgetStatePropertyAll(Size(double.infinity, 50)),
                backgroundColor:
                    WidgetStatePropertyAll(context.colorScheme.accentColor),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0).r,
                  ),
                ),
              ),
              child: Text(
                'Sign In',
                style: FontThemeClass().title2(
                  context,
                  color: context.colorScheme.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ).animate(delay: 500.ms).fadeIn(
                delay: 100.ms,
                curve: Curves.easeInOut,
                duration: 500.ms,
              ),
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('AppCheck').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                if (snapshot.hasError) {
                  return const SizedBox();
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return 30.verticalSpace;
                }
                return snapshot.data!.docs[0]['value']
                    ? Padding(
                        padding:
                            EdgeInsetsDirectional.only(top: 10.r, bottom: 10.r),
                        child: RichText(
                          text: TextSpan(
                            text: 'New Here?  ',
                            style: FontThemeClass().caption(
                              context,
                              color: context.colorScheme
                                  .white, // Change this to inverse of primaryText
                              fontWeight: FontWeight.w500,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Sign Up',
                                style: FontThemeClass().caption(
                                  context,
                                  color: context.colorScheme.accentColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    model.toRegisterPage(context);
                                  },
                              ),
                            ],
                          ),
                        ),
                      )
                    : 30.verticalSpace;
              }),
          Padding(
            padding: EdgeInsetsDirectional.only(top: 10.r, bottom: 20.r),
            child: RichText(
              text: TextSpan(
                text: 'By Continuing, you agree Terms of Service & ',
                style: FontThemeClass().caption(
                  context,
                  color: context.colorScheme
                      .white, // Change this to inverse of primaryText
                  fontWeight: FontWeight.w500,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Privacy Policy',
                    style: FontThemeClass().caption(
                      context,
                      color: context.colorScheme.accentColor,
                      fontWeight: FontWeight.w500,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        model.navigateToPrivacyPolicy();
                      },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

InkWell buildForgotPasswordWidget(BuildContext context, SignInViewModel model) {
  return InkWell(
    onTap: () {
      FocusScope.of(context).requestFocus(FocusNode());
      model.changePassword(context);
    },
    child: Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsetsDirectional.only(top: 10.r),
        child: Text(
          'Forgot password?',
          style: FontThemeClass().caption(
            context,
            color: context.colorScheme.accentColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  );
}

TextFormField buildPasswordTextfield(
    BuildContext context, SignInViewModel model) {
  return TextFormField(
    cursorColor: context.colorScheme.accentColor,
    controller: model.passwordTextController,
    obscureText: model.isPasswordVisible ? false : true,
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
      focusColor: Colors.white,
      suffixIcon: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          model.togglePasswordVisibility();
        },
        child: model.isPasswordVisible
            ? Icon(
                Icons.visibility_off,
                color: context.colorScheme.secondaryText,
              )
            : Icon(
                Icons.visibility,
                color: context.colorScheme.secondaryText,
              ),
      ),
      hintText: 'Password',
      hintStyle: model.fontTheme.caption(
        context,
        color: context.colorScheme.secondaryText,
        fontWeight: FontWeight.w500,
      ),
      errorText: model.isPasswordValid ? null : model.passwordErrorText,
    ),
  );
}

TextFormField buildEmailTextfield(BuildContext context, SignInViewModel model) {
  return TextFormField(
    cursorColor: context.colorScheme.accentColor,
    controller: model.emailIdTextController,
    onChanged: (value) {
      model.emailIdTextController.text =
          model.emailIdTextController.text.trim();
    },
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 15,
      ).r,
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
      hintStyle: model.fontTheme.caption(
        context,
        color: context.colorScheme.secondaryText,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Column buildInfoWidget(BuildContext context) {
  return Column(
    children: [
      Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: context.colorScheme.primary,
                    spreadRadius: -45,
                    blurRadius: 70.0, // Adjust for desired fade
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
            duration: 500.ms,
          ),
      Text("Abhiyaan",
              textAlign: TextAlign.center,
              style: FontThemeClass().header(
                context,
              )).animate(delay: 100.ms).fadeIn(
            delay: 100.ms,
            curve: Curves.easeInOut,
            duration: 500.ms,
          ),
      Text("Connect with Students, Teachers & Alumni",
              textAlign: TextAlign.center,
              style: FontThemeClass().body(
                context,
                color: context.colorScheme.secondaryText,
                fontWeight: FontWeight.w500,
              )).animate(delay: 300.ms).fadeIn(
            delay: 100.ms,
            curve: Curves.easeInOut,
            duration: 500.ms,
          ),
    ],
  );
}
