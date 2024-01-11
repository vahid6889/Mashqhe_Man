import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class ToolboxAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ToolboxAppBar({
    super.key,
    required this.controller,
  });
  final QuillController controller;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: Colors.white,
      elevation: 0.5,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: QuillToolbar.simple(
          configurations: QuillSimpleToolbarConfigurations(
            multiRowsDisplay: false,
            showAlignmentButtons: true,
            // toolbarSize: 36,
            controller: controller,
            sharedConfigurations: const QuillSharedConfigurations(
              locale: Locale('fa'),
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(55.0);
}
