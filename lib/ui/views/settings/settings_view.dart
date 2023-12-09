import 'package:darpan/file_exporter.dart';
import 'package:darpan/services/auth_service.dart';
import 'package:darpan/theme/theme_service.dart';
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
              style: model.fontTheme.heading(context),
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
                          value: model._themeService.valueListenable.value,
                          // trackColor: context.colorScheme.secondarySectionColor,
                          onChanged: (val) => model.changeTheme(),
                          activeColor: context.colorScheme.primaryColor,
                        ),
                        leadingIcon: model.settings[0].leading,
                      ),
                      GestureDetector(
                        onTap: () => model.changePassword(),
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
                        onTap: () => model.logout(),
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
                    'Darpan v.1.0.0',
                    style: model.fontTheme.subHeading(
                        context, context.colorScheme.secondarySectionColor),
                  ),
                  Text(
                    'Made with ❤️ by Technical Team ',
                    style: model.fontTheme.smallestSubHeading(
                        context, context.colorScheme.secondarySectionColor),
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
