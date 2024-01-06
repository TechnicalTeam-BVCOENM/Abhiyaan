import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/services/auth_service.dart';
import 'package:abhiyaan/ui/common/url_launcher.dart';
import 'package:abhiyaan/ui/common/toast_message.dart';
import 'package:abhiyaan/ui/views/profile/settings/settings_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_animate/flutter_animate.dart';
part 'sign_in_view_model.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
        viewModelBuilder: () => SignInViewModel(),
        onViewModelReady: (viewModel) => viewModel.init(),
        builder: (context, model, child) {
          return GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: context.colorScheme.backgroundColor,
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 40, bottom: 10)
                        .r,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 90).r,
                          child: SizedBox(
                            width: 320.w,
                            child: Image.asset(
                              AssetImagePath.logoImg,
                            ),
                          ).animate(delay: 100.ms).fadeIn(
                                delay: 100.ms,
                                curve: Curves.easeInOut,
                                duration: 500.ms,
                              ),
                        ),
                        TextFormField(
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
                            hintStyle: model.fontTheme.caption(context,
                                color:
                                    context.colorScheme.secondarySectionColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ).animate(delay: 300.ms).fadeIn(
                              delay: 100.ms,
                              curve: Curves.easeInOut,
                              duration: 500.ms,
                            ),
                        SizedBox(
                          height: 15.h,
                        ),
                        TextFormField(
                          cursorColor: context.colorScheme.primaryColor,
                          controller: model.passwordTextController,
                          obscureText: model.isPasswordVisible ? false : true,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15)
                                  .r,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    const Radius.circular(15).r,
                                  ),
                                  borderSide: BorderSide.none),
                              fillColor:
                                  context.colorScheme.secondaryWhiteColor,
                              filled: true,
                              focusColor: Colors.white,
                              suffixIcon: InkWell(
                                splashColor:
                                    context.colorScheme.secondaryLPurpleColor,
                                onTap: () {
                                  model.togglePasswordVisibility();
                                },
                                child: model.isPasswordVisible
                                    ? Icon(
                                        Icons.visibility_off,
                                        color: context.colorScheme.iconColor,
                                      )
                                    : const Icon(Icons.visibility),
                              ),
                              hintText: 'Password',
                              hintStyle: model.fontTheme.caption(context,
                                  color:
                                      context.colorScheme.secondarySectionColor,
                                  fontWeight: FontWeight.w500),
                              errorText: model.isPasswordValid
                                  ? null
                                  : model.passwordErrorText),
                        ).animate(delay: 300.ms).fadeIn(
                              delay: 100.ms,
                              curve: Curves.easeInOut,
                              duration: 500.ms,
                            ),
                        InkWell(
                          onTap: () => model.changePassword(context),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(top: 10.r),
                              child: Text(
                                'Forgot password?',
                                style: FontThemeClass().caption(context,
                                    color: context.colorScheme.primaryColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ).animate(delay: 400.ms).fadeIn(
                              delay: 100.ms,
                              curve: Curves.easeInOut,
                              duration: 500.ms,
                            ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(top: 10.r),
                          child: TextButton(
                            onPressed: () async {
                              await model.login(
                                  model.emailIdTextController.text,
                                  model.passwordTextController.text,
                                  context);
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
                              'Sign In',
                              style: FontThemeClass().title(context,
                                  color: context.colorScheme.signInTextColor),
                            ),
                          ),
                        ).animate(delay: 500.ms).fadeIn(
                              delay: 100.ms,
                              curve: Curves.easeInOut,
                              duration: 500.ms,
                            ),
                        model.showRegister
                            ? Padding(
                                padding: EdgeInsetsDirectional.only(top: 15.r),
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Don\'t have an account? ',
                                    style: FontThemeClass().caption(context,
                                        color: context
                                            .colorScheme.secondaryBlackColor,
                                        fontWeight: FontWeight.w500),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Register Now',
                                        style: FontThemeClass().caption(context,
                                            color: context
                                                .colorScheme.primaryColor,
                                            fontWeight: FontWeight.w500),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            model.toRegisterPage(context);
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ).animate(delay: 600.ms).fadeIn(
                                  delay: 100.ms,
                                  curve: Curves.easeInOut,
                                  duration: 500.ms,
                                )
                            : Container(),
                        model.showRegister ? const Spacer() : 10.verticalSpace,
                        Padding(
                          padding: EdgeInsetsDirectional.only(top: 10.r),
                          child: InkWell(
                            onTap: () => model.navigateToHelpSupport(),
                            child: RichText(
                              text: TextSpan(
                                text: 'Problem with Sign In? ',
                                style: FontThemeClass().caption(context,
                                    color:
                                        context.colorScheme.secondaryBlackColor,
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
                          ),
                        ).animate(delay: 700.ms).fadeIn(
                              delay: 100.ms,
                              curve: Curves.easeInOut,
                              duration: 500.ms,
                            ),
                        model.showRegister ? 10.verticalSpace : const Spacer(),
                        Container(
                          alignment: Alignment.center,
                          child: Text('Abhiyaan v1.0.0',
                              textAlign: TextAlign.center,
                              style: FontThemeClass().caption(context,
                                  color:
                                      context.colorScheme.secondarySectionColor,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }
}
