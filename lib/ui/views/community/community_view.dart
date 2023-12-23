import 'dart:ffi';

import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part "community_view_components.dart";
part "community_view_model.dart";

class CommunityView extends StatelessWidget {
  const CommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CommunityViewModel>.reactive(
        viewModelBuilder: () => CommunityViewModel(),
        onViewModelReady: (viewModel) => viewModel.init(context),
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
                style: fontThemeClass.title(context,
                    color: context.colorScheme.secondaryBlackColor),
              ),
              centerTitle: true,
            ),
            backgroundColor: context.colorScheme.backgroundColor,
            body: SafeArea(
              minimum: const EdgeInsets.symmetric(horizontal: 18).r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionText(title: "Blogs"),
                  // Add Blogs here
                  SizedBox(
                    height: 280.h,
                    child: ListView.builder(
                      itemCount: model.blogsData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CommunityBlogs(blogsData: model.blogsData[index]);
                      },
                    ),
                  ),
                  const SectionText(title: "Departmental Clubs"),
                  // Add Departmental Clubs here
                  const SectionText(title: "Qoute of the day"),
                  // Add Qoute of the day here
                ],
              ),
            ),
          );
        });
  }
}
