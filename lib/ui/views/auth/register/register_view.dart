import 'package:abhiyaan/ui/views/auth/onboarding/onboarding_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/services/auth_service.dart';
import 'package:abhiyaan/theme/responsive_utils.dart';
import 'package:abhiyaan/ui/common/common_component_model.dart';
import 'package:abhiyaan/ui/common/toast_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
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
                backgroundColor: context.colorScheme.backgroundColor,
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                                left: 30, right: 30, top: 40, bottom: 50)
                            .r,
                        child: Column(
                          children: [
                            SizedBox(
                              width: ResponsiveUtils.screenWidth(context) * 0.6,
                              child: Image.asset(
                                AssetImagePath.logoImg,
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: context
                                        .colorScheme.secondaryWhiteColor),
                                borderRadius: BorderRadius.circular(16.0).r,
                                color: context.colorScheme.secondaryWhiteColor,
                              ),
                              child: DropdownButton<String>(
                                elevation: 0,
                                dropdownColor:
                                    context.colorScheme.secondaryLPurpleColor,
                                borderRadius: BorderRadius.circular(20),
                                value: model.dropDownValue,
                                items: list
                                    .map<DropdownMenuItem<String>>(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ),
                                    )
                                    .toList(),

                                onChanged: (String? value) {
                                  model.changeDropDown(value);
                                },
                                underline:
                                    const SizedBox(), // Remove the default underline
                                isExpanded: true,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  size: 40.sp,
                                ),
                                style: FontThemeClass().caption(
                                  context,
                                  color:
                                      context.colorScheme.secondaryBlackColor,
                                ),
                              ),
                            ),
                            model.dropDownValue == 'BVCOE Student'
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      TextFormField(
                                        cursorColor:
                                            context.colorScheme.primaryColor,
                                        controller: model.misnoTextController,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 15)
                                                  .r,
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                const Radius.circular(15).r,
                                              ),
                                              borderSide: BorderSide.none),
                                          fillColor: context
                                              .colorScheme.secondaryWhiteColor,
                                          filled: true,
                                          focusColor: context
                                              .colorScheme.secondaryWhiteColor,
                                          hintText: 'Enter MIS Number',
                                          hintStyle: FontThemeClass().caption(
                                              context,
                                              color: context.colorScheme
                                                  .secondarySectionColor,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            SizedBox(
                              height: 15.h,
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
                                fillColor:
                                    context.colorScheme.secondaryWhiteColor,
                                filled: true,
                                focusColor:
                                    context.colorScheme.secondaryWhiteColor,
                                hintText: 'Student Email ID',
                                errorText: model.isEmailIdValid
                                    ? null
                                    : model.emailIdErrorText,
                                hintStyle: model.fontTheme.caption(context,
                                    color: context
                                        .colorScheme.secondarySectionColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            TextFormField(
                              cursorColor: context.colorScheme.primaryColor,
                              controller: model.phoneTextController,
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
                                focusColor:
                                    context.colorScheme.secondaryWhiteColor,
                                hintText: 'Enter Phone No',
                                errorText: model.isEmailIdValid
                                    ? null
                                    : model.emailIdErrorText,
                                hintStyle: model.fontTheme.caption(context,
                                    color: context
                                        .colorScheme.secondarySectionColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
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
                                fillColor:
                                    context.colorScheme.secondaryWhiteColor,
                                filled: true,
                                focusColor:
                                    context.colorScheme.secondaryWhiteColor,
                                hintText: 'Enter Username',
                                errorText: model.isEmailIdValid
                                    ? null
                                    : model.emailIdErrorText,
                                hintStyle: model.fontTheme.caption(context,
                                    color: context
                                        .colorScheme.secondarySectionColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            TextFormField(
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
                                fillColor:
                                    context.colorScheme.secondaryWhiteColor,
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
                                hintStyle: model.fontTheme.caption(
                                  context,
                                  color:
                                      context.colorScheme.secondarySectionColor,
                                ),
                              ),
                            ),
                            15.verticalSpace,
                            TextFormField(
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
                                fillColor:
                                    context.colorScheme.secondaryWhiteColor,
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
                                hintStyle: model.fontTheme.caption(
                                  context,
                                  color:
                                      context.colorScheme.secondarySectionColor,
                                ),
                              ),
                            ),
                            25.verticalSpace,
                            Padding(
                              padding: EdgeInsetsDirectional.only(top: 10.r),
                              child: TextButton(
                                onPressed: () async {
                                  await model.register(
                                      model.emailIdTextController.text,
                                      model.createpasswordTextController.text,
                                      model.confirmpasswordTextController.text,
                                      model.dropdownValue,
                                      model.misnoTextController.text,
                                      model.phoneTextController.text,
                                      model.userNameController.text,
                                      context);
                                },
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(
                                      const Size(double.infinity, 50)),
                                  backgroundColor: MaterialStateProperty.all(
                                      context.colorScheme.primaryColor),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(40.0).r,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Register',
                                  style: FontThemeClass().title(context,
                                      color:
                                          context.colorScheme.signInTextColor),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.only(top: 10.r),
                              child: RichText(
                                text: TextSpan(
                                  text: 'Already have an account? ',
                                  style: FontThemeClass().caption(context,
                                      color: context
                                          .colorScheme.secondaryBlackColor,
                                      fontWeight: FontWeight.w500),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Sign In',
                                      style: FontThemeClass().caption(context,
                                          color:
                                              context.colorScheme.primaryColor,
                                          fontWeight: FontWeight.w500),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          model.navigateToSignIn();
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.only(top: 10.r),
                              child: InkWell(
                                onTap: () => model.navigateToHelpSupport(),
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Problem with Registration? ',
                                    style: FontThemeClass().caption(context,
                                        color: context
                                            .colorScheme.secondaryBlackColor,
                                        fontWeight: FontWeight.w500),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Report Issue',
                                        style: FontThemeClass().caption(context,
                                            color: context
                                                .colorScheme.primaryColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text('Abhiyaan v1.0.0',
                          style: FontThemeClass().caption(context,
                              color: context.colorScheme.secondarySectionColor,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ));
        });
  }
}
