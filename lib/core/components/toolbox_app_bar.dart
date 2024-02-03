import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class ToolboxAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ToolboxAppBar({
    super.key,
    required this.quillController,
  });

  final QuillController quillController;

  @override
  Widget build(BuildContext context) {
    return QuillToolbar.simple(
      configurations: QuillSimpleToolbarConfigurations(
        customButtons: [
          QuillToolbarCustomButtonOptions(
            tooltip: 'ایجاد فاصله',
            icon: const Icon(Icons.format_indent_increase),
            onPressed: () {
              final index = quillController.selection.baseOffset;
              final length = quillController.selection.extentOffset - index;
              const space =
                  '                    '; // 20 spaces as a constant string
              quillController.replaceText(
                index,
                length,
                space,
                TextSelection.collapsed(offset: index + 20),
              );
            },
          ),
          QuillToolbarCustomButtonOptions(
            tooltip: 'حذف فاصله',
            icon: const Icon(Icons.format_indent_decrease),
            onPressed: () {
              final currentPosition = quillController.selection.baseOffset;

              if (currentPosition >= 20) {
                final textBefore = quillController.document
                    .toPlainText()
                    .substring(0, currentPosition);
                if (textBefore.endsWith('                    ')) {
                  quillController.replaceText(
                    currentPosition - 20,
                    19,
                    '',
                    TextSelection.collapsed(
                      offset: currentPosition - 20,
                    ),
                  );
                }
              }
            },
          ),
        ],
        buttonOptions: const QuillSimpleToolbarButtonOptions(
          base: QuillToolbarBaseButtonOptions(
            iconTheme: QuillIconTheme(
              iconButtonUnselectedData: IconButtonData(color: Colors.black),
              iconButtonSelectedData: IconButtonData(color: Colors.red),
            ),
          ),
        ),
        showIndent: false,
        showSearchButton: false,
        showLink: false,
        showSubscript: false,
        showSuperscript: false,
        showBoldButton: false,
        showItalicButton: false,
        showFontFamily: false,
        color: Colors.white,
        multiRowsDisplay: false,
        showAlignmentButtons: true,
        controller: quillController,
        dialogTheme: const QuillDialogTheme(
          inputTextStyle: TextStyle(color: Colors.white),
          dialogBackgroundColor: Colors.white,
          buttonTextStyle: TextStyle(color: Colors.white),
          labelTextStyle: TextStyle(color: Colors.white),
        ),
        sharedConfigurations: const QuillSharedConfigurations(
          dialogBarrierColor: Colors.white,
          dialogTheme: QuillDialogTheme(
            inputTextStyle: TextStyle(color: Colors.white),
            dialogBackgroundColor: Colors.white,
            buttonTextStyle: TextStyle(color: Colors.white),
            labelTextStyle: TextStyle(color: Colors.white),
          ),
          locale: Locale('fa', 'IR'),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(55.0);
}
