// Department Updates Card
import 'package:darpan/theme/responsive_utils.dart';
import 'package:expandable/expandable.dart';
import 'package:intl/intl.dart';
import '../file_exporter.dart';

Widget updatesCard(List updateList, int i, BuildContext context ,  viewModel) {
  
  // Note :- Where you use this add isExpanded: false in respective viewModel

  return ExpandableNotifier(
    initialExpanded: false,
    child: Expandable(
      collapsed: ExpandableText(updateList: updateList, i: i , viewModel: viewModel),
      expanded: ExpandableText(updateList: updateList, i: i , viewModel: viewModel),
    ),
  );
}

// ignore: must_be_immutable
class ExpandableText extends StatelessWidget {
  List updateList;
  var viewModel;
  int i;

   ExpandableText({
    super.key,required this.updateList,required this.i, required this.viewModel
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: ResponsiveUtils.screenWidth(context),
      decoration: BoxDecoration(
        color: context.colorScheme.secondaryWhiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.colorScheme.secondaryLPurpleColor.withOpacity(0.7),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  updateList[i].title,
                  style: viewModel.fontTheme
                      .subHeading(context, context.colorScheme.primaryColor),
                ),
                Text(
                  "Posted ${DateFormat("MMM d").format((updateList[i].date).toDate())}",
                  style: viewModel.fontTheme.smallSubHeading(context),
                ),
              ],
            ),
            const SizedBox(height: 12,),
            Text(
              updateList[i].description,
              maxLines: viewModel.isExpanded ? 100 : 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: viewModel.fontTheme.smallSubHeading(
                context,
                context.colorScheme.secondaryBlackColor.withOpacity(0.8),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ExpandableButton(
                  child: InkWell(
                    onTap: () {
                      viewModel.isExpanded = !viewModel.isExpanded;
                      debugPrint("Tapped ${viewModel.isExpanded}");
                      viewModel.notifyListeners();
                    },
                    child: Text( viewModel.isExpanded ? "Read Less" :
                      "Read More",
                      style: FontThemeClass().smallSubHeading(
                        context,
                        context.colorScheme.primaryContainer,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
