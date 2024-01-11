import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:intl/intl.dart' as intl;

class TestEditor extends StatefulWidget {
  const TestEditor({super.key});

  @override
  State<TestEditor> createState() => _TestEditorState();
}

class _TestEditorState extends State<TestEditor> {
  final QuillController _controller = QuillController.basic();
  final _textDirection = ValueNotifier<TextDirection>(TextDirection.ltr);

  TextDirection getDirection(String text) {
    bool isRtl = intl.Bidi.detectRtlDirectionality(text);
    return isRtl ? TextDirection.rtl : TextDirection.ltr;
  }

  void _updateTextDirection() {
    final text = _controller.document.toPlainText();
    if (text.isNotEmpty) {
      print(text);
      _textDirection.value = getDirection(text);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.removeListener(_updateTextDirection);
    _controller.dispose();
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _controller.addListener(_updateTextDirection);
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _controller.addListener(_updateTextDirection);

    /// set rtl direction in document
    QuillController _controller = QuillController(
      document: Document(),
      selection: const TextSelection.collapsed(offset: 0),
    );
    final int length = _controller.document.length;
    if (length > 0) {
      _controller.document.format(
        length - 1,
        0,
        const Attribute('direction', AttributeScope.block, 'rtl'),
      );
    }
    _controller.updateSelection(
        TextSelection.collapsed(offset: _controller.document.length),
        ChangeSource.local);
  }

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   // _controller.addListener(_updateTextDirection);

  //   _controller.addListener(() {
  //     print(intl.Bidi.detectRtlDirectionality(
  //         _controller.plainTextEditingValue.text));
  //     QuillController _quillController = QuillController(
  //       document: Document(),
  //       selection: const TextSelection.collapsed(offset: 0),
  //     );
  //     final int length = _quillController.document.length;

  //     var rtlAttribute =
  //         const Attribute('direction', AttributeScope.block, 'rtl');
  //     var ltrAttribute =
  //         const Attribute('direction', AttributeScope.block, 'ltr');

  //     _quillController.document.format(length - 1, 0, rtlAttribute);

  //     _quillController.updateSelection(
  //         TextSelection.collapsed(offset: _controller.document.length),
  //         ChangeSource.local);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // QuillController _controller = QuillController(
    //   document: Document(),
    //   selection: const TextSelection.collapsed(offset: 0),
    // );
    // final int length = _controller.document.length;

    // if (length > 0) {
    //   var rtlAttribute = const Attribute('direction', AttributeScope.block, 'rtl');
    //   _controller.document.format(length - 1, 0, rtlAttribute);
    // }
    // String text = "متن فارسی که می‌خواهیم راست‌چین شود.\n";
    // // _controller.document.insert(length, text);
    // _controller.updateSelection(
    //     TextSelection.collapsed(offset: _controller.document.length),
    //     ChangeSource.local);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            QuillToolbar.simple(
              configurations: QuillSimpleToolbarConfigurations(
                customButtons: [
                  QuillToolbarCustomButtonOptions(
                    icon: const Icon(Icons.ac_unit),
                    onPressed: () {
                      debugPrint('snowflake1');
                    },
                  ),
                ],
                buttonOptions: const QuillSimpleToolbarButtonOptions(
                  base: QuillToolbarBaseButtonOptions(
                    iconTheme: QuillIconTheme(
                      iconButtonUnselectedData:
                          IconButtonData(color: Colors.black),
                      iconButtonSelectedData: IconButtonData(color: Colors.red),
                    ),
                  ),
                ),
                color: Colors.white,
                multiRowsDisplay: false,
                showAlignmentButtons: true,
                controller: _controller,
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
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 500,
                child: QuillEditor.basic(
                  configurations: QuillEditorConfigurations(
                    showCursor: true,
                    dialogTheme: const QuillDialogTheme(
                      inputTextStyle: TextStyle(color: Colors.white),
                      dialogBackgroundColor: Colors.white,
                      buttonTextStyle: TextStyle(color: Colors.white),
                      labelTextStyle: TextStyle(color: Colors.white),
                    ),
                    controller: _controller,
                    readOnly: false,
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
