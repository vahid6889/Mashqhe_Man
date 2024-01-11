import 'package:flutter/material.dart';

Future<T?> ShowModalBottomSheetComponent<T>({
  required BuildContext context,
  required Widget child,
  bool? isScrollControlled,
  ShapeBorder? shape,
  bool isDismissible = true,
}) {
  return showModalBottomSheet<T>(
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    backgroundColor: Colors.white,
    isDismissible: isDismissible,
    context: context,
    isScrollControlled: isScrollControlled ?? true,
    enableDrag: true,
    builder: (BuildContext context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: child,
      );
    },
  );
}
