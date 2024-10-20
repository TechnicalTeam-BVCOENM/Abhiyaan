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
          final font = FontThemeClass();
          // StreamBuilder(
          //   stream:
          //       FirebaseFirestore.instance.collection('AppCheck').snapshots(),
          //   builder: (BuildContext context,
          //       AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          //     if (snapshot.hasError) {
          //       return const SizedBox();
          //     }

          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const SizedBox();
          //     }
          // return snapshot.data!.docs[0]['value']
          //     ? GestureDetector(
          //         onTap: () {
          //           model.toRegisterPage(context);
          //         },
          //         child: Container(
          //           width: MediaQuery.of(context).size.width,
          //           padding: const EdgeInsets.all(8).r,
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(12).r,
          //             color: context.colorScheme.white,
          //           ),
          //           child: Center(
          //             child: Text(
          //               'Register',
          //               style: FontThemeClass().title2(
          //                 context,
          //                 color:
          //                     context.colorScheme.primaryText,
          //                 fontWeight: FontWeight.w600,
          //               ),
          //             ),
          //           ),
          //         ),
          //       )
          //     : Container();
          return GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: context.colorScheme.scaffold,
                body: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('AppCheck')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const SizedBox();
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox();
                        }
                        return Column(
                          children: [
                            // 40.verticalSpace,
                            snapshot.data!.docs[0]['value']
                                ? Column(
                                    children: [
                                      Container(
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: context
                                                        .colorScheme.primary,
                                                    spreadRadius: -45,
                                                    blurRadius:
                                                        70.0, // Adjust for desired fade
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
                                                color: context
                                                    .colorScheme.secondaryText,
                                                fontWeight: FontWeight.w500,
                                              )).animate(delay: 200.ms).fadeIn(
                                            delay: 100.ms,
                                            curve: Curves.easeInOut,
                                            duration: 500.ms,
                                          ),
                                      40.verticalSpace,
                                      TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        cursorColor:
                                            context.colorScheme.accentColor,
                                        controller: model.emailIdTextController,
                                        onChanged: (value) {
                                          model.emailIdTextController.text =
                                              model.emailIdTextController.text
                                                  .trim();
                                        },
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                      horizontal: 30,
                                                      vertical: 15)
                                                  .r,
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
                                          errorText: model.isEmailIdValid
                                              ? null
                                              : model.emailIdErrorText,
                                          hintStyle: model.fontTheme.caption(
                                            context,
                                            color: context
                                                .colorScheme.secondaryText,
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
                                        cursorColor:
                                            context.colorScheme.accentColor,
                                        controller: model.userNameController,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                      horizontal: 30,
                                                      vertical: 15)
                                                  .r,
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
                                          errorText: model.isEmailIdValid
                                              ? null
                                              : model.emailIdErrorText,
                                          hintStyle: model.fontTheme.caption(
                                            context,
                                            color: context
                                                .colorScheme.secondaryText,
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
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        cursorColor:
                                            context.colorScheme.accentColor,
                                        controller:
                                            model.createpasswordTextController,
                                        obscureText:
                                            model.isCreatePasswordVisible
                                                ? false
                                                : true,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                      horizontal: 30,
                                                      vertical: 15)
                                                  .r,
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
                                              model
                                                  .toggleCreatePasswordVisibility();
                                            },
                                            child: model.isCreatePasswordVisible
                                                ? Icon(
                                                    Icons.visibility_off,
                                                    color: context.colorScheme
                                                        .secondaryText,
                                                  )
                                                : Icon(
                                                    Icons.visibility,
                                                    color: context.colorScheme
                                                        .secondaryText,
                                                  ),
                                          ),
                                          hintText: 'Create Password',
                                          hintStyle: model.fontTheme.caption(
                                            context,
                                            color: context
                                                .colorScheme.secondaryText,
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
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        cursorColor:
                                            context.colorScheme.accentColor,
                                        controller:
                                            model.confirmpasswordTextController,
                                        obscureText:
                                            model.isConfirmPasswordVisible
                                                ? false
                                                : true,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                      horizontal: 30,
                                                      vertical: 15)
                                                  .r,
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
                                              model
                                                  .toggleConfirmPasswordVisibility();
                                            },
                                            child:
                                                model.isConfirmPasswordVisible
                                                    ? Icon(
                                                        Icons.visibility_off,
                                                        color: context
                                                            .colorScheme
                                                            .secondaryText,
                                                      )
                                                    : Icon(
                                                        Icons.visibility,
                                                        color: context
                                                            .colorScheme
                                                            .secondaryText,
                                                      ),
                                          ),
                                          hintText: 'Confirm Password',
                                          hintStyle: model.fontTheme.caption(
                                            context,
                                            color: context
                                                .colorScheme.secondaryText,
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
                                          minimumSize:
                                              const WidgetStatePropertyAll(
                                                  Size(double.infinity, 50)),
                                          backgroundColor:
                                              WidgetStatePropertyAll(context
                                                  .colorScheme.accentColor),
                                          shape: WidgetStatePropertyAll(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40.0).r,
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
                                            color: context
                                                .colorScheme.secondaryText,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'Sign In',
                                              style: FontThemeClass().caption(
                                                context,
                                                color: context
                                                    .colorScheme.accentColor,
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
                                      // const Spacer(),
                                    ],
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      320.verticalSpace,
                                      Image.asset(
                                        "assets/images/auth/road_closure.png",
                                        width: 100.w,
                                      ),
                                      20.verticalSpace,
                                      Text(
                                        "We're sorry, this feature is currently not available."
                                            .toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: font.body(
                                          context,
                                          color:
                                              context.colorScheme.primaryText,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      10.verticalSpace,
                                      Text(
                                        "Please try again later.".toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: font.small(
                                          context,
                                          color: context.colorScheme.primaryText
                                              .withOpacity(0.5),
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
                                                color: context
                                                    .colorScheme.accentColor,
                                                fontWeight: FontWeight.w500,
                                              ))),
                                    ],
                                  ),
                            const Spacer(),
                            snapshot.data!.docs[0]['value']
                                ? GestureDetector(
                                    onTap: () => model.navigateToHelpSupport(),
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        text: 'Problem with Registration? ',
                                        style: FontThemeClass().caption(
                                          context,
                                          color:
                                              context.colorScheme.secondaryText,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Report Issue',
                                            style: FontThemeClass().caption(
                                              context,
                                              color: context
                                                  .colorScheme.accentColor,
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
                                    )
                                : Container(),
                            10.verticalSpace,
                            Text(
                              'Abhiyaan v${AppConstants.appVersion}',
                              textAlign: TextAlign.center,
                              style: FontThemeClass().caption(
                                context,
                                color: context.colorScheme.secondaryText,
                                fontWeight: FontWeight.w500,
                              ),
                            ).animate(delay: 1000.ms).fadeIn(
                                  delay: 100.ms,
                                  curve: Curves.easeInOut,
                                  duration: 700.ms,
                                ),
                            10.verticalSpace,
                          ],
                        );
                      }),
                ),
              ));
        });
  }
}
