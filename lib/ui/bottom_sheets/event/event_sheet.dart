import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

part 'event_sheet_model.dart';

class EventSheet extends StackedView<EventSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const EventSheet({
    super.key,
    required this.completer,
    required this.request,
  });

  @override
  Widget builder(
    BuildContext context,
    EventSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            request.title ?? 'Hello Stacked Sheet!!',
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
          if (request.description != null) ...[
            Text(
              request.description!,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
              maxLines: 3,
              softWrap: true,
            ),
          ],
        ],
      ),
    );
  }

  @override
  EventSheetModel viewModelBuilder(BuildContext context) => EventSheetModel();
}
