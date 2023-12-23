import 'dart:ffi';

import 'package:abhiyaan/file_exporter.dart';
part "community_view_components.dart";
part "community_view_model.dart";

class CommunityView extends StatelessWidget {
  const CommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CommunityViewModel>.reactive(
        viewModelBuilder: () => CommunityViewModel(),
        builder: (context, model, child) {
          FontThemeClass fontThemeClass = FontThemeClass();
          return Scaffold(
            appBar: AppBar(
              backgroundColor: context.colorScheme.backgroundColor,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context); // pop to home screen
                },
                icon: Icon(
                  Icons.arrow_back_rounded,
                  size: 30.sp,
                  color: context.colorScheme.secondaryBlackColor,
                ),
              ),
              title: Text(
                "Community",
                style: fontThemeClass.title(context,color: context.colorScheme.secondaryBlackColor),
              ),
              centerTitle: true,
            ),
            backgroundColor: context.colorScheme.backgroundColor,
            body:  SafeArea(
              minimum: const EdgeInsets.symmetric(horizontal: 18).r,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionText(title: "Blogs"),
                  SectionText(title: "Departmental Clubs"),
                  SectionText(title: "Qoute of the day"),
                ],
              ),
            ),
          );
        });
  }
}
