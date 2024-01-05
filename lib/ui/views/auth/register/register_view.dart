import 'package:abhiyaan/ui/views/auth/onboarding/onboarding_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/services/auth_service.dart';
import 'package:abhiyaan/theme/responsive_utils.dart';
import 'package:abhiyaan/ui/common/url_launcher.dart';
import 'package:abhiyaan/ui/common/toast_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_animate/flutter_animate.dart';
part 'register_view_model.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
        viewModelBuilder: () => RegisterViewModel(),
        builder: (context, model, child) {
          return GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: context.colorScheme.backgroundColor,
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
                        cursorColor: context.colorScheme.primaryColor,
                        controller: model.emailIdTextController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15)
                              .r,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                const Radius.circular(15).r,
                              ),
                              borderSide: BorderSide.none),
                          fillColor: context.colorScheme.secondaryWhiteColor,
                          filled: true,
                          focusColor: context.colorScheme.secondaryWhiteColor,
                          hintText: 'Student Email ID',
                          errorText: model.isEmailIdValid
                              ? null
                              : model.emailIdErrorText,
                          hintStyle: model.fontTheme.caption(context,
                              color: context.colorScheme.secondarySectionColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ).animate(delay: 300.ms).fadeIn(
                            delay: 100.ms,
                            curve: Curves.easeInOut,
                            duration: 700.ms,
                          ),
                      15.verticalSpace,
                      TextFormField(
                        cursorColor: context.colorScheme.primaryColor,
                        controller: model.userNameController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15)
                              .r,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                const Radius.circular(15).r,
                              ),
                              borderSide: BorderSide.none),
                          fillColor: context.colorScheme.secondaryWhiteColor,
                          filled: true,
                          focusColor: context.colorScheme.secondaryWhiteColor,
                          hintText: 'Enter Username',
                          errorText: model.isEmailIdValid
                              ? null
                              : model.emailIdErrorText,
                          hintStyle: model.fontTheme.caption(context,
                              color: context.colorScheme.secondarySectionColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ).animate(delay: 400.ms).fadeIn(
                            delay: 100.ms,
                            curve: Curves.easeInOut,
                            duration: 700.ms,
                          ),
                      15.verticalSpace,
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        cursorColor: context.colorScheme.primaryColor,
                        controller: model.createpasswordTextController,
                        obscureText:
                            model.isCreatePasswordVisible ? false : true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15)
                              .r,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                const Radius.circular(15).r,
                              ),
                              borderSide: BorderSide.none),
                          fillColor: context.colorScheme.secondaryWhiteColor,
                          filled: true,
                          focusColor: Colors.white,
                          suffixIcon: InkWell(
                            splashColor:
                                context.colorScheme.secondaryLPurpleColor,
                            onTap: () {
                              model.toggleCreatePasswordVisibility();
                            },
                            child: model.isCreatePasswordVisible
                                ? Icon(
                                    Icons.visibility_off,
                                    color: context.colorScheme.iconColor,
                                  )
                                : const Icon(Icons.visibility),
                          ),
                          hintText: 'Create Password',
                          hintStyle: model.fontTheme.caption(context,
                              color: context.colorScheme.secondarySectionColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ).animate(delay: 500.ms).fadeIn(
                            delay: 100.ms,
                            curve: Curves.easeInOut,
                            duration: 700.ms,
                          ),
                      15.verticalSpace,
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        cursorColor: context.colorScheme.primaryColor,
                        controller: model.confirmpasswordTextController,
                        obscureText:
                            model.isConfirmPasswordVisible ? false : true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15)
                              .r,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                const Radius.circular(15).r,
                              ),
                              borderSide: BorderSide.none),
                          fillColor: context.colorScheme.secondaryWhiteColor,
                          filled: true,
                          focusColor: Colors.white,
                          suffixIcon: InkWell(
                            splashColor:
                                context.colorScheme.secondaryLPurpleColor,
                            onTap: () {
                              model.toggleConfirmPasswordVisibility();
                            },
                            child: model.isConfirmPasswordVisible
                                ? Icon(
                                    Icons.visibility_off,
                                    color: context.colorScheme.iconColor,
                                  )
                                : const Icon(Icons.visibility),
                          ),
                          hintText: 'Confirm Password',
                          hintStyle: model.fontTheme.caption(context,
                              color: context.colorScheme.secondarySectionColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ).animate(delay: 600.ms).fadeIn(
                            delay: 100.ms,
                            curve: Curves.easeInOut,
                            duration: 700.ms,
                          ),
                      25.verticalSpace,
                      TextButton(
                        onPressed: () async {
                          await model.register(context);
                        },
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                              const Size(double.infinity, 50)),
                          backgroundColor: MaterialStateProperty.all(
                              context.colorScheme.primaryColor),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0).r,
                            ),
                          ),
                        ),
                        child: Text(
                          'Register',
                          style: FontThemeClass().title(context,
                              color: context.colorScheme.signInTextColor),
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
                          style: FontThemeClass().caption(context,
                              color: context.colorScheme.secondaryBlackColor,
                              fontWeight: FontWeight.w500),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Sign In',
                              style: FontThemeClass().caption(context,
                                  color: context.colorScheme.primaryColor,
                                  fontWeight: FontWeight.w500),
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
                            style: FontThemeClass().caption(context,
                                color: context.colorScheme.secondaryBlackColor,
                                fontWeight: FontWeight.w500),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Report Issue',
                                style: FontThemeClass().caption(context,
                                    color: context.colorScheme.primaryColor,
                                    fontWeight: FontWeight.w500),
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
                        'Abhiyaan v1.0.0',
                        textAlign: TextAlign.center,
                        style: FontThemeClass().caption(context,
                            color: context.colorScheme.secondarySectionColor,
                            fontWeight: FontWeight.w500),
                      ).animate(delay: 1000.ms).fadeIn(
                            delay: 100.ms,
                            curve: Curves.easeInOut,
                            duration: 700.ms,
                          ),
                      10.verticalSpace,
                    ],
                  ),
                ),
              ));
        });
  }
}
