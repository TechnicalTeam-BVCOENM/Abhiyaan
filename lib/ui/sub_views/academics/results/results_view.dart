import 'package:darpan/file_exporter.dart';
import 'package:darpan/services/firestore_service.dart';
import 'package:darpan/ui/sub_views/academics/results/result_view_components.dart';
part 'results_view_model.dart';

class ResultsView extends StatelessWidget {
  const ResultsView({super.key});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ResultsViewModel>.reactive(
        viewModelBuilder: () => ResultsViewModel(),
        onViewModelReady: (model) => model.fetchResults(),
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: context.colorScheme.backgroundColor,
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: context.colorScheme.secondaryBlackColor,
              ),
              backgroundColor: context.colorScheme.backgroundColor,
              elevation: 0,
              title: Text(
                'Results',
                style: FontThemeClass().heading(context),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    children: [
                      SemesterResult(
                        model: model,
                        semester: 'Semester 1',
                        ut1_link: model.results[0].gazetteLink.toString(),
                        ut2_link: model.results[0].gazetteLink.toString(),
                        gazette_link: model.results[0].gazetteLink.toString(),
                        marksheet_link: model.results[0].gazetteLink.toString(),
                        index: 0,
                      ),
                      SemesterResult(
                        model: model,
                        semester: 'Semester 2',
                        ut1_link: 'https://example.com/',
                        ut2_link: 'https://example.com/',
                        gazette_link: 'https://example.com/',
                        marksheet_link: 'https://example.com/',
                        index: 1,
                      ),
                      SemesterResult(
                        model: model,
                        semester: 'Semester 3',
                        ut1_link: 'https://example.com/',
                        ut2_link: 'https://example.com/',
                        gazette_link: 'https://example.com/',
                        marksheet_link: 'https://example.com/',
                        index: 2,
                      ),
                      SemesterResult(
                        model: model,
                        semester: 'Semester 4',
                        ut1_link: 'https://example.com/',
                        ut2_link: 'https://example.com/',
                        gazette_link: 'https://example.com/',
                        marksheet_link: 'https://example.com/',
                        index: 3,
                      ),
                      SemesterResult(
                        model: model,
                        semester: 'Semester 5',
                        ut1_link: 'https://example.com/',
                        ut2_link: 'https://example.com/',
                        gazette_link: 'https://example.com/',
                        marksheet_link: 'https://example.com/',
                        index: 4,
                      ),
                      SemesterResult(
                        model: model,
                        semester: 'Semester 6',
                        ut1_link: 'https://example.com/',
                        ut2_link: 'https://example.com/',
                        gazette_link: 'https://example.com/',
                        marksheet_link: 'https://example.com/',
                        index: 5,
                      ),
                      SemesterResult(
                        model: model,
                        semester: 'Semester 7',
                        ut1_link: 'https://example.com/',
                        ut2_link: 'https://example.com/',
                        gazette_link: 'https://example.com/',
                        marksheet_link: 'https://example.com/',
                        index: 6,
                      ),
                      SemesterResult(
                        model: model,
                        semester: 'Semester 8',
                        ut1_link: 'https://example.com/',
                        ut2_link: 'https://example.com/',
                        gazette_link: 'https://example.com/',
                        marksheet_link: 'https://example.com/',
                        index: 7,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
