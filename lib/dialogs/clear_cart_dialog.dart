import 'package:flutter/material.dart' show BuildContext;

import 'generic_dialog.dart';

Future<bool> showClearCartDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Clear Cart',
    content:
        'Are you sure you want to clear the cart? You cannot undo this action!',
    optionsBuilder: () => {
      'Cancel': false,
      'Clear': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
