import 'package:darpan/file_exporter.dart';
import 'package:darpan/services/auth_service.dart';
import 'package:darpan/theme/responsive_utils.dart';
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
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                  child: Container(
                    height: 610.sp,
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
                          'Sign In',
                          style: model.fontTheme.large(context),
                        ),
                        const Expanded(child: Text("")),
                        TextFormField(
                          cursorColor: context.colorScheme.primaryColor,
                          controller: model.emailIdTextController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
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
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          cursorColor: context.colorScheme.primaryColor,
                          controller: model.passwordTextController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                borderSide: BorderSide.none),
                            fillColor: Colors.white,
                            filled: true,
                            focusColor: Colors.white,
                            hintText: 'Password',
                            hintStyle: model.fontTheme.subHeading2(context,
                                context.colorScheme.secondarySectionColor),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsetsDirectional.symmetric(
                                vertical: 10),
                            child: Text(
                              'Forgot password?',
                              style: model.fontTheme.subHeading2(
                                  context, context.colorScheme.primaryColor),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.symmetric(
                              vertical: 10),
                          child: TextButton(
                            onPressed: () async {
                              await model.login(
                                  model.emailIdTextController.text,
                                  model.passwordTextController.text);
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                  const Size(double.infinity, 50)),
                              backgroundColor: MaterialStateProperty.all(
                                  context.colorScheme.primaryColor),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                              ),
                            ),
                            child: Text(
                              'Sign In',
                              style: FontThemeClass().heading(context,
                                  color:
                                      context.colorScheme.secondaryWhiteColor),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.symmetric(
                              vertical: 10),
                          child: RichText(
                            text: TextSpan(
                              text: 'Problem with sign in? ',
                              style: FontThemeClass().subHeading2(context,
                                  context.colorScheme.secondaryBlackColor),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Report issue',
                                  style: FontThemeClass().subHeading2(context,
                                      context.colorScheme.primaryColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Text(""),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      Text(
                        'Darpan v.1.0.0',
                        style: model.fontTheme.subHeading(
                          context,
                          context.colorScheme.secondarySectionColor,
                        ),
                      ),
                      Text(
                        'Made with ❤️ by Technical Team ',
                        style: model.fontTheme.smallSubHeading(
                          context,
                          context.colorScheme.secondarySectionColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
