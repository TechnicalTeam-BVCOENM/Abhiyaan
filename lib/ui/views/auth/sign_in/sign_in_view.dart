import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/services/auth_service.dart';
import 'package:abhiyaan/ui/common/url_launcher.dart';
import 'package:abhiyaan/ui/common/toast_message.dart';
import 'package:abhiyaan/ui/views/auth/onboarding/onboarding_view.dart';
import "package:abhiyaan/ui/views/profile/preferences/preferences_view.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:abhiyaan/ui/views/auth/register/register_view.dart';

part 'sign_in_view_model.dart';
part 'sign_in_view_components.dart';

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
            drawerEnableOpenDragGesture: false,
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
                          // INFO WIDGET
                          buildInfoWidget(context),
                          50.verticalSpace,

                          // EMAIL ID
                          buildEmailTextfield(context, model)
                              .animate(delay: 100.ms)
                              .fadeIn(
                                delay: 100.ms,
                                curve: Curves.easeInOut,
                                duration: 500.ms,
                              ),
                          15.verticalSpace,

                          // PASSWORD
                          buildPasswordTextfield(context, model)
                              .animate(delay: 300.ms)
                              .fadeIn(
                                delay: 100.ms,
                                curve: Curves.easeInOut,
                                duration: 500.ms,
                              ),
                          buildForgotPasswordWidget(context, model)
                              .animate(delay: 400.ms)
                              .fadeIn(
                                delay: 100.ms,
                                curve: Curves.easeInOut,
                                duration: 500.ms,
                              ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    buildLoginButton(context, model)
                        .animate(delay: 600.ms)
                        .fadeIn(
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
