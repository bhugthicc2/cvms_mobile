import 'package:flutter/material.dart';
import '../widgets/custom_bottom_sheet.dart';

Future<T?> showCustomBottomSheet<T>({
  required BuildContext context,
  required String title,
  required Widget child,
  VoidCallback? onSubmit,
  VoidCallback? onCancel,
  String submitText = "Submit",
  String cancelText = 'Cancel',
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return CustomBottomSheet(
        title: title,
        onSubmit: onSubmit,
        onCancel: onCancel,
        submitText: submitText,

        child: child,
      );
    },
  );
}
