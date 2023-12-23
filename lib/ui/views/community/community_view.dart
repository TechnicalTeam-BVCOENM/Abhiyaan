import 'dart:ffi';

import 'package:abhiyaan/file_exporter.dart';
part "community_view_components.dart";
part "community_view_model.dart";

class CommunityView extends StatelessWidget {
  const CommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    FontThemeClass fontTheme = FontThemeClass();
    return ViewModelBuilder<CommunityViewModel>.reactive(
        viewModelBuilder: () => CommunityViewModel(),
        builder: (context, model, child) {
          return const Scaffold();
        });
  }
}
