import 'package:darpan/file_exporter.dart';
import 'package:darpan/services/auth_service.dart';
import 'package:darpan/theme/responsive_utils.dart';
import 'package:darpan/ui/common/toast_message.dart';
import 'package:darpan/ui/views/settings/settings_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'auth_view_model.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthViewModel>.reactive(
      viewModelBuilder: () => AuthViewModel(),
      builder: (context, model, child) {
        
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Scaffold(
            backgroundColor: context.colorScheme.backgroundColor,
            body: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Container(
                  height: 870.h,
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 40, bottom: 175).r,
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
                      Text(
                        'Darpan',
                        style: model.fontTheme.large(context),
                      ),
                      const Expanded(child: Text("")),
                      TextFormField(
                        cursorColor: context.colorScheme.primaryColor,
                        controller: model.emailIdTextController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15).r,
                          border:  OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                const Radius.circular(15).r,
                              ),
                              borderSide: BorderSide.none),
                          fillColor: context.colorScheme.secondaryWhiteColor,
                          filled: true,
                          focusColor: context.colorScheme.secondaryWhiteColor,
                          hintText: 'Student Email ID',
                          hintStyle: model.fontTheme.subHeading2(context,
                              context.colorScheme.secondarySectionColor),
                        ),
                      ),
                       SizedBox(
                        height: 15.h,
                      ),
                      TextFormField(
                        cursorColor: context.colorScheme.primaryColor,
                        controller: model.passwordTextController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15).r,
                          border:  OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                const Radius.circular(15).r,
                              ),
                              borderSide: BorderSide.none),
                          fillColor: context.colorScheme.secondaryWhiteColor,
                          filled: true,
                          focusColor: Colors.white,
                          hintText: 'Password',
                          hintStyle: model.fontTheme.subHeading2(context,
                              context.colorScheme.secondarySectionColor),
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>
                            SettingsViewModel().changePassword(context),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(top: 10.r) ,
                            child: Text(
                              'Forgot password?',
                              style: model.fontTheme.subHeading2(
                                  context, context.colorScheme.primaryColor),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsetsDirectional.only(top: 10.r),
                        child: TextButton(
                          onPressed: () async {
                            await model.login(model.emailIdTextController.text,
                                model.passwordTextController.text, context);
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
                            style: FontThemeClass().heading(context,
                                color: context.colorScheme.signInTextColor),
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsetsDirectional.only(top: 10.r),
                        child: RichText(
                          text: TextSpan(
                            text: 'Problem with Sign in? ',
                            style: FontThemeClass().subHeading2(context,
                                context.colorScheme.secondaryBlackColor),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Report issue',
                                style: FontThemeClass().subHeading2(
                                    context, context.colorScheme.primaryColor),
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
                  child:Text(
                  'Darpan v.1.0.0',
                  style: model.fontTheme.subHeading(
                      context, context.colorScheme.secondarySectionColor),
                ),
             ) ],
            ),
          ),
        );
      },
    );
  }
}
