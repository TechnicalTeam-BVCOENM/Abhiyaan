import 'package:darpan/file_exporter.dart';
import 'package:darpan/theme/responsive_utils.dart';
import 'package:darpan/utils/extension.dart';
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
            body: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 45),
                      width: ResponsiveUtils.screenWidth(context) * 0.6,
                      child: Image.asset(
                        'assets/images/logo.png',
                      ),
                    ),
                    Text(
                      'Sign In',
                      style: model.fontTheme.large(context),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    TextFormField(
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
                        hintStyle: model.fontTheme.subHeading2(
                            context, context.colorScheme.secondarySectionColor),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
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
                        hintStyle: model.fontTheme.subHeading2(
                            context, context.colorScheme.secondarySectionColor),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.symmetric(vertical: 10),
                        child: Text(
                          'Forget password?',
                          style: model.fontTheme.subHeading2(
                              context, context.colorScheme.primaryColor),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.symmetric(vertical: 10),
                      child: TextButton(
                        onPressed: () {
                          model.toHomePage(context);
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
                          style: FontThemeClass().heading(
                              context, context.colorScheme.secondaryWhiteColor),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.symmetric(vertical: 10),
                      child: RichText(
                        text: TextSpan(
                          text: 'Problem with sign in? ',
                          style: FontThemeClass().subHeading2(
                              context, context.colorScheme.secondaryBlackColor),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Report issue',
                              style: FontThemeClass().subHeading2(
                                  context, context.colorScheme.primaryColor),
                            ),
                          ],
                        ),
                      ),
                    )
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
