// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:abhiyaan/ui/dialogs/alert/alert_dialog.dart';
import 'package:stacked_services/stacked_services.dart';
import 'app.locator.dart';

enum DialogType {
  alert,
}

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
    DialogType.alert: (context, request, completer) =>
        AlertDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
