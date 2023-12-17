import 'package:darpan/file_exporter.dart';
import 'package:darpan/services/auth_service.dart';
import 'package:darpan/theme/responsive_utils.dart';
import 'package:darpan/ui/common/toast_message.dart';
import 'package:darpan/ui/views/auth/sign_in/sign_in_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
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
                body: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Container(
                      height: 873.h,
                      padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 40, bottom: 105)
                          .r,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Expanded(child: Text("")),
                          SizedBox(
                            width: ResponsiveUtils.screenWidth(context) * 0.6,
                            child: Image.asset(
                              AssetImagePath.logoImg,
                            ),
                          ),
                          const Expanded(child: Text("")),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0).r,
                            child: PopupMenuButton<String>(
                              itemBuilder: (BuildContext context) {
                                final model = Provider.of<RegisterViewModel>(
                                    context,
                                    listen: false);
                                return dropdownItems.map((String value) {
                                  return PopupMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: model.fontTheme.caption(
                                        context,
                                        color: context
                                            .colorScheme.secondaryBlackColor,
                                      ),
                                    ),
                                  );
                                }).toList();
                              },
                              onSelected: (String value) {
                                final model = Provider.of<RegisterViewModel>(
                                    context,
                                    listen: false);
                                model.setSelectedValue(value);
                              },
                              child: Consumer<RegisterViewModel>(
                                builder: (context, model, child) =>
                                    InputDecorator(
                                  decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                                  horizontal: 15, vertical: 15)
                                              .r,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            const Radius.circular(15).r),
                                        borderSide: BorderSide.none,
                                      ),
                                      fillColor: context
                                          .colorScheme.secondaryWhiteColor,
                                      filled: true,
                                      suffixIcon: const Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        size: 25,
                                      )),
                                  child: Text(model.selectedValue),
                                ),
                              ),
                            ),
                          ),
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
                              hintStyle: model.fontTheme.caption(
                                context,
                                color:
                                    context.colorScheme.secondarySectionColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          TextFormField(
                            cursorColor: context.colorScheme.primaryColor,
                            controller: model.misnoTextController,
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
                              hintText: 'Enter MIS Number',
                              hintStyle: model.fontTheme.caption(
                                context,
                                color:
                                    context.colorScheme.secondarySectionColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          TextFormField(
                            cursorColor: context.colorScheme.primaryColor,
                            controller: model.createpasswordTextController,
                            obscureText: obscureText,
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
                              hintText: 'Create Password',
                              hintStyle: model.fontTheme.caption(
                                context,
                                color:
                                    context.colorScheme.secondarySectionColor,
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () => model.toggleCreatePassword(),
                                child: Icon(
                                  obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                          ),
                          15.verticalSpace,
                          TextFormField(
                            cursorColor: context.colorScheme.primaryColor,
                            controller: model.confirmpasswordTextController,
                            obscureText: obscureText,
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
                              hintText: 'Confirm Password',
                              hintStyle: model.fontTheme.caption(
                                context,
                                color:
                                    context.colorScheme.secondarySectionColor,
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () => model.toggleConfirmPassword(),
                                child: Icon(
                                  obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
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
                                    model.selectedValue,
                                    model.misnoTextController.text,
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
                                'Register',
                                style: FontThemeClass().title(context,
                                    color: context
                                        .colorScheme.secondaryWhiteColor),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(top: 10.r),
                            child: RichText(
                              text: TextSpan(
                                text: 'Already have an account? ',
                                style: FontThemeClass().caption(
                                  context,
                                  color:
                                      context.colorScheme.secondaryBlackColor,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Sign In',
                                    style: FontThemeClass().caption(
                                      context,
                                      color: context.colorScheme.primaryColor,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignInView()),
                                        );
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(top: 10.r),
                            child: RichText(
                              text: TextSpan(
                                text: 'Problem with Registration? ',
                                style: FontThemeClass().caption(
                                  context,
                                  color:
                                      context.colorScheme.secondaryBlackColor,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Report Issue',
                                    style: FontThemeClass().caption(
                                      context,
                                      color: context.colorScheme.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Expanded(child: Text("")),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: Text('Abhiyaan v1.0.0',
                          style: FontThemeClass().caption(
                            context,
                            color: context.colorScheme.secondarySectionColor,
                          )),
                    ),
                  ],
                ),
              ));
        });
  }
}

// void setState(Null Function() param0) {}
