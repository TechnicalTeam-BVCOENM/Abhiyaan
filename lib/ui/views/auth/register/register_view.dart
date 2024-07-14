import 'dart:math';
import 'package:abhiyaan/ui/views/auth/onboarding/onboarding_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/services/auth_service.dart';
import 'package:abhiyaan/ui/common/url_launcher.dart';
import 'package:abhiyaan/ui/common/toast_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:pinput/pinput.dart';

part 'register_view_model.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
      viewModelBuilder: () => RegisterViewModel(),
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: context.colorScheme.scaffoldBackgroundColor,
            body: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 50),
                    width: 320.w,
                    child: Image.asset(
                      AssetImagePath.logoImg,
                    ),
                  ).animate(delay: 200.ms).fadeIn(
                        delay: 100.ms,
                        curve: Curves.easeInOut,
                        duration: 700.ms,
                      ),
                  30.verticalSpace,
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: context.colorScheme.primaryAccentColor,
                    controller: model.emailIdTextController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15)
                          .r,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          const Radius.circular(15).r,
                        ),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: context.colorScheme.primaryCardColor,
                      filled: true,
                      focusColor: context.colorScheme.primaryCardColor,
                      hintText: 'Student Email ID',
                      errorText:
                          model.isEmailIdValid ? null : model.emailIdErrorText,
                      hintStyle: model.fontTheme.caption(
                        context,
                        color: context.colorScheme.secondaryTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ).animate(delay: 300.ms).fadeIn(
                        delay: 100.ms,
                        curve: Curves.easeInOut,
                        duration: 700.ms,
                      ),
                  15.verticalSpace,
                  TextFormField(
                    cursorColor: context.colorScheme.primaryAccentColor,
                    controller: model.userNameController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15)
                          .r,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          const Radius.circular(15).r,
                        ),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: context.colorScheme.primaryCardColor,
                      filled: true,
                      focusColor: context.colorScheme.primaryCardColor,
                      hintText: 'Enter Username',
                      errorText:
                          model.isEmailIdValid ? null : model.emailIdErrorText,
                      hintStyle: model.fontTheme.caption(
                        context,
                        color: context.colorScheme.secondaryTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ).animate(delay: 400.ms).fadeIn(
                        delay: 100.ms,
                        curve: Curves.easeInOut,
                        duration: 700.ms,
                      ),
                  15.verticalSpace,
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    cursorColor: context.colorScheme.primaryAccentColor,
                    controller: model.createpasswordTextController,
                    obscureText: model.isCreatePasswordVisible ? false : true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15)
                          .r,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            const Radius.circular(15).r,
                          ),
                          borderSide: BorderSide.none),
                      fillColor: context.colorScheme.primaryCardColor,
                      filled: true,
                      focusColor: context.colorScheme.primaryCardColor,
                      suffixIcon: InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          model.toggleCreatePasswordVisibility();
                        },
                        child: model.isCreatePasswordVisible
                            ? Icon(
                                Icons.visibility_off,
                                color: context.colorScheme.secondaryTextColor,
                              )
                            : Icon(
                                Icons.visibility,
                                color: context.colorScheme.secondaryTextColor,
                              ),
                      ),
                      hintText: 'Create Password',
                      hintStyle: model.fontTheme.caption(
                        context,
                        color: context.colorScheme.secondaryTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ).animate(delay: 500.ms).fadeIn(
                        delay: 100.ms,
                        curve: Curves.easeInOut,
                        duration: 700.ms,
                      ),
                  15.verticalSpace,
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    cursorColor: context.colorScheme.primaryAccentColor,
                    controller: model.confirmpasswordTextController,
                    obscureText: model.isConfirmPasswordVisible ? false : true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15)
                          .r,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          const Radius.circular(15).r,
                        ),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: context.colorScheme.primaryCardColor,
                      filled: true,
                      focusColor: context.colorScheme.primaryCardColor,
                      suffixIcon: InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          model.toggleConfirmPasswordVisibility();
                        },
                        child: model.isConfirmPasswordVisible
                            ? Icon(
                                Icons.visibility_off,
                                color: context.colorScheme.secondaryTextColor,
                              )
                            : Icon(
                                Icons.visibility,
                                color: context.colorScheme.secondaryTextColor,
                              ),
                      ),
                      hintText: 'Confirm Password',
                      hintStyle: model.fontTheme.caption(
                        context,
                        color: context.colorScheme.secondaryTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ).animate(delay: 600.ms).fadeIn(
                        delay: 100.ms,
                        curve: Curves.easeInOut,
                        duration: 700.ms,
                      ),
                  25.verticalSpace,
                  TextButton(
                    onPressed: () async {
                      model.register(context);
                    },
                    style: ButtonStyle(
                      minimumSize: const WidgetStatePropertyAll(
                          Size(double.infinity, 50)),
                      backgroundColor: WidgetStatePropertyAll(
                          context.colorScheme.primaryAccentColor),
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
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: FontThemeClass().caption(
                        context,
                        color: context.colorScheme.secondaryTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign In',
                          style: FontThemeClass().caption(
                            context,
                            color: context.colorScheme.primaryAccentColor,
                            fontWeight: FontWeight.w500,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              model.navigateToSignIn();
                            },
                        ),
                      ],
                    ),
                  ).animate(delay: 800.ms).fadeIn(
                        delay: 100.ms,
                        curve: Curves.easeInOut,
                        duration: 700.ms,
                      ),
                  const Spacer(),
                  InkWell(
                    onTap: () => model.navigateToHelpSupport(),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Problem with Registration? ',
                        style: FontThemeClass().caption(
                          context,
                          color: context.colorScheme.secondaryTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Report Issue',
                            style: FontThemeClass().caption(
                              context,
                              color: context.colorScheme.primaryAccentColor,
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
                  10.verticalSpace,
                  Text(
                    'Abhiyaan v1.0.5',
                    textAlign: TextAlign.center,
                    style: FontThemeClass().caption(
                      context,
                      color: context.colorScheme.secondaryTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ).animate(delay: 1000.ms).fadeIn(
                        delay: 100.ms,
                        curve: Curves.easeInOut,
                        duration: 700.ms,
                      ),
                  10.verticalSpace,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
