import 'package:darpan/file_exporter.dart';
part 'auth_view_model.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthViewModel>.reactive(
      viewModelBuilder: () => AuthViewModel(),
      builder: (context, model, child) {
        return Scaffold(
            backgroundColor: context.colorScheme.backgroundColor,
            body: SafeArea(
              child: Center(
                child: Column(
                  children: [
                    const Expanded(child: Text('')),
                    Image(image: Image.asset(AssetImagePath.logoImg).image),
                    16.verticalSpace,
                    InkWell(
                      splashColor: context.colorScheme.secondaryLPurpleColor,
                      onTap: () {
                        model.toSignInPage(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10).r,
                        width: 334.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30).r,
                          color: context.colorScheme.primaryColor,
                        ),
                        child: Center(
                          child: Text(
                            'Sign In',
                            style: FontThemeClass().title(context,
                                color: context.colorScheme.secondaryWhiteColor),
                          ),
                        ),
                      ),
                    ),
                    20.verticalSpace,
                    InkWell(
                      splashColor: context.colorScheme.secondaryLPurpleColor,
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(10).r,
                        width: 334.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30).r,
                          color: context.colorScheme.primaryColor,
                        ),
                        child: Center(
                          child: Text(
                            'Register',
                            style: FontThemeClass().title(context,
                                color: context.colorScheme.secondaryWhiteColor),
                          ),
                        ),
                      ),
                    ),
                    const Expanded(child: Text('')),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Abhiyaan v1.0.0',
                          style: FontThemeClass().caption(context,
                              color: context.colorScheme.secondaryBlackColor)),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
