import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/services/auth_service.dart';
import 'package:abhiyaan/theme/theme_service.dart';
import 'package:abhiyaan/ui/common/common_component_model.dart';
import 'package:abhiyaan/ui/common/toast_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'settings_view_model.dart';
part 'settings_view_components.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
      viewModelBuilder: () => SettingsViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: context.colorScheme.backgroundColor,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: context
                  .colorScheme.secondaryBlackColor, //change your color here
            ),
            backgroundColor: context.colorScheme.backgroundColor,
            elevation: 0,
            title: Text(
              'Settings',
              style: model.fontTheme.title(context,
                  color: context.colorScheme.secondaryBlackColor,
                  fontWeight: FontWeight.w500),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Container(
              padding: const EdgeInsets.only(top: 20),
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: [
                  Column(
                    children: [
                      settingsListTile(
                        model,
                        context,
                        title: model.settings[0].title,
                        trailingIcon: Switch.adaptive(
                          activeColor: context.colorScheme.switchColor,
                          value: model._themeService.valueListenable.value,
                          // trackColor: context.colorScheme.secondarySectionColor,
                          onChanged: (val) => model.changeTheme(),
                        ),
                        leadingIcon: model.settings[0].leading,
                      ),
                      GestureDetector(
                        onTap: () {
                          model.passwordChangeAlert(context);
                        },
                        child: settingsListTile(model, context,
                            title: model.settings[1].title,
                            trailingIcon: Icon(
                              model.settings[1].trailing,
                              color: context.colorScheme.secondaryBlackColor,
                            ),
                            leadingIcon: model.settings[1].leading),
                      ),
                      GestureDetector(
                        onTap: () => model.navigateToHelpSupport(),
                        child: settingsListTile(model, context,
                            title: model.settings[2].title,
                            trailingIcon: Icon(
                              model.settings[2].trailing,
                              color: context.colorScheme.secondaryBlackColor,
                            ),
                            leadingIcon: model.settings[2].leading),
                      ),
                      GestureDetector(
                        onTap: () => model.navigateToPrivacyPolicy(),
                        child: settingsListTile(model, context,
                            title: model.settings[3].title,
                            trailingIcon: Icon(
                              model.settings[3].trailing,
                              color: context.colorScheme.secondaryBlackColor,
                            ),
                            leadingIcon: model.settings[3].leading),
                      ),
                      GestureDetector(
                        onTap: () => model.logoutAlert(context),
                        child: settingsListTile(model, context,
                            title: model.settings[4].title,
                            trailingIcon: Icon(
                              model.settings[4].trailing,
                              color: context.colorScheme.secondaryBlackColor,
                            ),
                            leadingIcon: model.settings[4].leading),
                      )
                    ],
                  ),
                  const Expanded(
                    child: Text(''),
                  ),
                  Text(
                    'abhiyaan v.1.0.0',
                    style: model.fontTheme.paragraph(context,
                        color: context.colorScheme.secondarySectionColor,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Made with ❤️ by Technical Team ',
                    style: model.fontTheme.caption(context,
                        color: context.colorScheme.secondarySectionColor),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}