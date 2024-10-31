import 'dart:math';
import 'package:abhiyaan/ui/views/auth/onboarding/onboarding_view.dart';
import 'package:abhiyaan/ui/views/auth/register/register_view_component.dart';
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
                backgroundColor: context.colorScheme.scaffold,
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: StreamBuilder(
                        stream: model.registerStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const SizedBox();
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SizedBox();
                          } else if (snapshot.hasData) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const RegisterNavigateBack(),
                                snapshot.data!.docs[0]['value']
                                    ? const Column(
                                        children: [
                                          RegisterLogoQuote(),
                                          RegisterForm(),
                                          RegisterButton(),
                                        ],
                                      )
                                    : const RegsiterClosed(),
                                const Spacer(),
                                const AppVersion(),
                              ],
                            );
                          }
                          return const SizedBox();
                        }),
                  ),
                ),
              ));
        });
  }
}
