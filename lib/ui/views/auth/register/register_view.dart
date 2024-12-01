import 'dart:math';
import 'package:abhiyaan/app/app.packageInfo.dart';
import 'package:abhiyaan/ui/views/auth/onboarding/onboarding_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/services/auth_service.dart';
import 'package:abhiyaan/ui/common/url_launcher.dart';
import 'package:abhiyaan/ui/common/toast_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:pinput/pinput.dart';

part 'register_view_model.dart';
part 'register_view_components.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
      viewModelBuilder: () => RegisterViewModel(),
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, model, child) {
        final font = FontThemeClass();
        return model.isBusy
            ? const Scaffold()
            : GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: context.colorScheme.scaffold,
                  body: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 40),
                    child: Column(
                      children: [
                        model.shouldShowUI
                            ? Column(
                                children: [
                                  // INFO WIDGET
                                  buildInfoWidget(context),
                                  40.verticalSpace,

                                  // EMAIL ID
                                  buildEmailTextfield(context, model)
                                      .animate(delay: 300.ms)
                                      .fadeIn(
                                        delay: 100.ms,
                                        curve: Curves.easeInOut,
                                        duration: 700.ms,
                                      ),
                                  15.verticalSpace,

                                  // USERNAME
                                  buildUsernameTextfield(context, model)
                                      .animate(delay: 400.ms)
                                      .fadeIn(
                                        delay: 100.ms,
                                        curve: Curves.easeInOut,
                                        duration: 700.ms,
                                      ),
                                  15.verticalSpace,

                                  // PASSWORD
                                  buildPasswordTextfield(context, model)
                                      .animate(delay: 500.ms)
                                      .fadeIn(
                                        delay: 100.ms,
                                        curve: Curves.easeInOut,
                                        duration: 700.ms,
                                      ),
                                  15.verticalSpace,

                                  // CONFIRM PASSWORD
                                  buildPasswordConfirmTextfield(context, model)
                                      .animate(delay: 600.ms)
                                      .fadeIn(
                                        delay: 100.ms,
                                        curve: Curves.easeInOut,
                                        duration: 700.ms,
                                      ),
                                  25.verticalSpace,

                                  // REGISTER BUTTON
                                  buildRegisterButton(model, context)
                                ],
                              )
                            :
                            // REGISTER DISABLED WIDGET
                            buildRegisterDisabledWidget(font, context, model),

                        const Spacer(),

                        // VERSION INFO
                        buildVersionInfoWidget(context)
                            .animate(delay: 1000.ms)
                            .fadeIn(
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
