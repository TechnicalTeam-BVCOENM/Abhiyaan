import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/services/auth_service.dart';
import 'package:abhiyaan/ui/common/url_launcher.dart';
import 'package:abhiyaan/ui/common/toast_message.dart';
import "package:abhiyaan/ui/views/profile/preferences/preferences_view.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:abhiyaan/ui/views/auth/register/register_view.dart';

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
            backgroundColor: context.colorScheme.scaffold,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                ).r,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ).r,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 30).r,
                                 decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: context.colorScheme.primary,
                spreadRadius: -55,
                blurRadius: 60.0, // Adjust for desired fade
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
                          
                              SizedBox(
                            height: 25.h,
                              ),
                          TextFormField(
                            cursorColor: context.colorScheme.accentColor,
                            controller: model.emailIdTextController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 15,
                              ).r,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  const Radius.circular(15).r,
                                ),
                                borderSide: BorderSide.none,
                              ),
                              fillColor: context.colorScheme.card,
                              filled: true,
                              focusColor: context.colorScheme.card,
                              hintText: 'Student Email ID',
                              hintStyle: model.fontTheme.caption(
                                context,
                                color: context.colorScheme.secondaryText,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ).animate(delay: 100.ms).fadeIn(
                                delay: 100.ms,
                                curve: Curves.easeInOut,
                                duration: 500.ms,
                              ),
                          SizedBox(
                            height: 15.h,
                          ),
                          TextFormField(
                            cursorColor: context.colorScheme.accentColor,
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
                                        color:
                                            context.colorScheme.secondaryText,
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        color:
                                            context.colorScheme.secondaryText,
                                      ),
                              ),
                              hintText: 'Password',
                              hintStyle: model.fontTheme.caption(
                                context,
                                color: context.colorScheme.secondaryText,
                                fontWeight: FontWeight.w500,
                              ),
                              errorText: model.isPasswordValid
                                  ? null
                                  : model.passwordErrorText,
                            ),
                          ).animate(delay: 300.ms).fadeIn(
                                delay: 100.ms,
                                curve: Curves.easeInOut,
                                duration: 500.ms,
                              ),
                          InkWell(
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
                          ).animate(delay: 400.ms).fadeIn(
                                delay: 100.ms,
                                curve: Curves.easeInOut,
                                duration: 500.ms,
                              ),
                        ],
                      ),
                    ),
                    // model.showRegister
                    //     ? Padding(
                    //         padding: EdgeInsetsDirectional.only(top: 15.r),
                    //         child: RichText(
                    //           text: TextSpan(
                    //             text: 'Don\'t have an account? ',
                    //             style: FontThemeClass().caption(
                    //               context,
                    //               color: context.colorScheme.secondaryText,
                    //               fontWeight: FontWeight.w500,
                    //             ),
                    //             children: <TextSpan>[
                    //               TextSpan(
                    //                 text: 'Register Now',
                    //                 style: FontThemeClass().caption(
                    //                   context,
                    //                   color: context.colorScheme.accentColor,
                    //                   fontWeight: FontWeight.w500,
                    //                 ),
                    //                 recognizer: TapGestureRecognizer()
                    //                   ..onTap = () {
                    //                     model.toRegisterPage(context);
                    //                   },
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ).animate(delay: 600.ms).fadeIn(
                    //           delay: 100.ms,
                    //           curve: Curves.easeInOut,
                    //           duration: 500.ms,
                    //         )
                    //     : Container(),
                    // model.showRegister ? const Spacer() : 10.verticalSpace,
                    // Padding(
                    //   padding: EdgeInsetsDirectional.only(top: 10.r),
                    //   child: InkWell(
                    //     onTap: () => model.navigateToHelpSupport(),
                    //     child: RichText(
                    //       text: TextSpan(
                    //         text: 'Problem with Sign In? ',
                    //         style: FontThemeClass().caption(
                    //           context,
                    //           color: context.colorScheme.secondaryText,
                    //           fontWeight: FontWeight.w500,
                    //         ),
                    //         children: <TextSpan>[
                    //           TextSpan(
                    //             text: 'Report Issue',
                    //             style: FontThemeClass().caption(
                    //               context,
                    //               color: context.colorScheme.accentColor,
                    //               fontWeight: FontWeight.w500,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ).animate(delay: 700.ms).fadeIn(
                    //       delay: 100.ms,
                    //       curve: Curves.easeInOut,
                    //       duration: 500.ms,
                    //     ),
                    model.showRegister ? 10.verticalSpace : const Spacer(),
                    // Container(
                    //   alignment: Alignment.center,
                    //   child: Text(
                    //     'Abhiyaan v1.0.5',
                    //     textAlign: TextAlign.center,
                    //     style: FontThemeClass().caption(
                    //       context,
                    //       color: context.colorScheme.secondaryText,
                    //       fontWeight: FontWeight.w500,
                    //     ),
                    //   ),
                    // ),
                    const Spacer(),
                    ClipRRect(
                      borderRadius:  BorderRadius.only(
                        topLeft: Radius.circular(30.r),
                        topRight: Radius.circular(30.r),
                      ),
                      child: Container(
                        width: double.infinity,
                        color: context.colorScheme
                            .darkScaffold, // Change this to inverse of scaffold
                        // decoration: const BoxDecoration(
                        //   borderRadius: BorderRadius.only(
                        //     topLeft: Radius.circular(15),
                        //     topRight: Radius.circular(15),
                        //   ),
                        // ),
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
                                  minimumSize: const WidgetStatePropertyAll(
                                      Size(double.infinity, 50)),
                                  backgroundColor: WidgetStatePropertyAll(
                                      context.colorScheme.accentColor),
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
                            Padding(
                              padding: EdgeInsetsDirectional.only(
                                  top: 10.r, bottom: 10.r),
                              child: RichText(
                                text: TextSpan(
                                  text: 'New Here? ',
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
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.only(
                                  top: 20.r, bottom: 10.r),
                              child: RichText(
                                text: TextSpan(
                                  text:
                                      'By Continuing, you agree Terms of Service & ',
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
                    ).animate(delay: 600.ms).fadeIn(
  delay: 100.ms,
  curve: Curves.easeInOut,
  duration: 700.ms,
),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
