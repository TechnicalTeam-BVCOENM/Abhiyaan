// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:darpan/file_exporter.dart';
import 'package:darpan/ui/common/common_component_model.dart';
import 'package:darpan/ui/sub_views/academics/results/results_view.dart';

class SemesterResult extends ViewModelWidget<ResultsViewModel> {
  // final ResultsViewModel model;
  final String semester;
  // ignore: non_constant_identifier_names
  final String ut1_link;
  // ignore: non_constant_identifier_names
  final String ut2_link;
  // ignore: non_constant_identifier_names
  final String gazette_link;
  // ignore: non_constant_identifier_names
  final String marksheet_link;
  final int index;
  const SemesterResult({
    super.key,
    // required this.model,
    required this.semester,
    // ignore: non_constant_identifier_names
    required this.ut1_link,
    // ignore: non_constant_identifier_names
    required this.ut2_link,
    // ignore: non_constant_identifier_names
    required this.gazette_link,
    // ignore: non_constant_identifier_names
    required this.marksheet_link,
    required this.index,
  });

  @override
  Widget build(BuildContext context, ResultsViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Card(
        shadowColor: null,
        margin: const EdgeInsets.only(bottom: 8),
        elevation: 0,
        clipBehavior: Clip.hardEdge,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Column(
          children: [
            ExpansionTile(
              clipBehavior: Clip.hardEdge,
              trailing: Icon(
                viewModel.expandedSemesterIndices.contains(index)
                    ? Icons.expand_less
                    : Icons.expand_more,
                color: viewModel.expandedSemesterIndices.contains(index)
                    ? context.colorScheme.primaryColor
                    : context.colorScheme.primaryDarkColor,
              ),
              onExpansionChanged: (bool expanded) {
                // viewModel.updateExpansionState(expanded);
                viewModel.updateExpandedSemesterIndices(index, expanded);
              },
              title: Text(
                semester,
                style: FontThemeClass()
                    .heading(context, color: context.colorScheme.primaryColor),
              ),
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildElevatedButton(
                        model: viewModel,
                        title: 'UT1',
                        link: ut1_link,
                        index: 0,
                        sem_index: index,
                      ),
                      buildElevatedButton(
                        model: viewModel,
                        title: 'UT2',
                        link: ut2_link,
                        index: 1,
                        sem_index: index,
                      ),
                      buildElevatedButton(
                        model: viewModel,
                        title: 'Gazette',
                        link: gazette_link,
                        index: 2,
                        sem_index: index,
                      ),
                      buildElevatedButton(
                        model: viewModel,
                        title: 'Marksheet',
                        link: marksheet_link,
                        index: 3,
                        sem_index: index,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types, duplicate_ignore
class buildElevatedButton extends ViewModelWidget<ResultsViewModel> {
  final ResultsViewModel model;
  final String title;
  final String link;
  final int index;
  final int sem_index;
  const buildElevatedButton(
      {super.key,
      required this.model,
      required this.title,
      required this.link,
      required this.index,
      // ignore: non_constant_identifier_names
      required this.sem_index});

  @override
  Widget build(BuildContext context, ResultsViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 8, 2, 8).r,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(80.w, 40.h),
          backgroundColor: model.buttonPressedStates(sem_index)[index]
              ? context.colorScheme.primaryColor
              : context.colorScheme.secondaryWhiteColor,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                5,
              ),
            ),
          ),
          side: BorderSide(color: context.colorScheme.primaryColor),
        ),
        onPressed: () {
          model.updateButtonPressedState(sem_index, index, true);
          UrlLauncher().launchURL(link);
          // print(link);
        },
        child: Text(
          title,
          style: FontThemeClass().subHeading(
            context,
            model.buttonPressedStates(sem_index)[index]
                ? Colors.white
                : context.colorScheme.primaryDarkColor,
          ),
        ),
      ),
    );
  }
}
