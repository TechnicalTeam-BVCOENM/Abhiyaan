import 'package:darpan/file_exporter.dart';
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
            backgroundColor: ColorThemeClass.backgroundColor,
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
                      style: FontThemeClass().large(),
                    ),
                    const SizedBox(
                      height: 70,
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
                        fillColor: ColorThemeClass.secondaryWhiteColor,
                        filled: true,
                        focusColor: ColorThemeClass.secondaryWhiteColor,
                        hintText: 'Student Email ID',
                        hintStyle: FontThemeClass().subHeading2(),
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
                        hintStyle: FontThemeClass().subHeading2(),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.symmetric(vertical: 10),
                        child: Text(
                          'Forget password?',
                          style: FontThemeClass()
                              .subHeading2(color: ColorThemeClass.primaryColor),
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
                              ColorThemeClass.primaryColor),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                          ),
                        ),
                        child: Text(
                          'Sign In',
                          style: FontThemeClass().heading(
                              color: ColorThemeClass.secondaryWhiteColor),
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
                              color: ColorThemeClass.secondaryBlackColor),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Report issue',
                              style: FontThemeClass().subHeading2(
                                  color: ColorThemeClass.primaryColor),
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
