import 'package:abhiyaan/file_exporter.dart';
import 'package:flutter_animate/flutter_animate.dart';
part 'auth_view_model.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthViewModel>.reactive(
      viewModelBuilder: () => AuthViewModel(),
      builder: (context, model, child) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: context.colorScheme.backgroundColor,
              toolbarHeight: 100,
              title: SizedBox(
                  width: 180.w,
                  child: Image(image: Image.asset(AssetImagePath.logoImg).image)
                      .animate(delay: 200.ms)
                      .fadeIn(
                        delay: 100.ms,
                        curve: Curves.easeInOut,
                        duration: 500.ms,
                      )),
            ),
            backgroundColor: context.colorScheme.secondaryBlackColor,
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                          margin: EdgeInsets.symmetric(vertical: 50.r),
                          child: Image(
                              image: Image.asset(AssetImagePath.login).image))
                      .animate(delay: 200.ms)
                      .fadeIn(
                        delay: 100.ms,
                        curve: Curves.easeInOut,
                        duration: 600.ms,
                      ),
                  16.verticalSpace,
                  GestureDetector(
                    onTap: () {
                      model.toSignInPage(context);
                    },
                    child: Container(
                      width: 100,
                      margin: const EdgeInsets.symmetric(horizontal: 36),
                      padding: const EdgeInsets.all(10).r,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15).r,
                        color: context.colorScheme.primaryColor,
                      ),
                      child: Center(
                        child: Text(
                          'Sign In',
                          style: FontThemeClass().title(context,
                              color: context.colorScheme.signInTextColor),
                        ),
                      ),
                    ),
                  ).animate(delay: 200.ms).fadeIn(
                        delay: 100.ms,
                        curve: Curves.easeInOut,
                        duration: 700.ms,
                      ),
                  20.verticalSpace,
                  GestureDetector(
                    onTap: () {
                      model.toRegisterPage(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10).r,
                      margin: const EdgeInsets.symmetric(horizontal: 36),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15).r,
                        color: context.colorScheme.primaryColor,
                      ),
                      child: Center(
                        child: Text(
                          'Register',
                          style: FontThemeClass().title(context,
                              color: context.colorScheme.signInTextColor),
                        ),
                      ),
                    ),
                  ).animate(delay: 200.ms).fadeIn(
                        delay: 100.ms,
                        curve: Curves.easeInOut,
                        duration: 700.ms,
                      ),
                  const Expanded(child: Text("")),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Abhiyaan v1.0.0',
                        style: FontThemeClass().caption(context,
                            color: context.colorScheme.secondarySectionColor,
                            fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
