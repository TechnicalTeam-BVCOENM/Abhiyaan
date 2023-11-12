import 'package:darpan/file_exporter.dart';
import 'package:darpan/utils/extension.dart';
import 'package:flutter/material.dart';
import 'academics_viewmodel.dart';
import 'package:path/path.dart';

class AcademicsView extends StatelessWidget {
  const AcademicsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AcademicsViewModel>.reactive(
      viewModelBuilder: () => AcademicsViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Academics",
              style: model.fontTheme.appBarText(context),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      height: 408.0, // Set your desired height
                      child: MyGrid(),
                    ),
                  ),
                  const SectionText(
                    title: "Academic Updates",
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    height: 135.hWise,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: context.colorScheme.secondaryWhiteColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    height: 135.hWise,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: context.colorScheme.secondaryWhiteColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    height: 135.hWise,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: context.colorScheme.secondaryWhiteColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  SizedBox(height: 10.hWise),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

final List<String> assets = [
  'assets/images/timetable.png',
  'assets/images/syllabus.png',
  'assets/images/student section.png',
  'assets/images/class notes.png',
  'assets/images/practicals.png',
  'assets/images/PYQ.png',
  'assets/images/courses.png',
  'assets/images/result.png',
  'assets/images/attendance.png',
];

class MyGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: assets.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
      ),
      itemBuilder: (context, index) {
        String imageName = basenameWithoutExtension(assets[index]);

        return Column(
          children: [
            Container(
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: context.colorScheme.secondaryLPurpleColor,
                borderRadius: BorderRadius.circular(35.0),
              ),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    assets[index],
                    height: 93.0, // Adjust the height as needed
                  ),
                  SizedBox(height: 6.0), // Add spacing between image and text
                ],
              ),
            ),
            // SizedBox(height: 1.0), // Add spacing between GridView items
            Text(
              imageName,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w700,
                letterSpacing: 0.1,
                color: context.colorScheme.secondarySectionColor,
              ),
            ),
          ],
        );
      },
    );
  }
}
