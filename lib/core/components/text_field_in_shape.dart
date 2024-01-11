import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mashgh/core/utils/value_manager.dart';

class TextFieldInShape extends StatefulWidget {
  const TextFieldInShape({
    super.key,
    required this.maxLength,
  });
  final int maxLength;

  @override
  State<TextFieldInShape> createState() => _TextFieldInShapeState();
}

class _TextFieldInShapeState extends State<TextFieldInShape> {
  final textInputController = TextEditingController();
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();

    // listen to focus changes
    // focusNode.addListener(
    //     () => print('focusNode updated: hasFocus: ${focusNode.hasFocus}'));
  }

  void setFocus() {
    FocusScope.of(context).requestFocus(focusNode);
  }

  int findWordStart(String text, TextSelection selection) {
    var start = selection.baseOffset - 1;
    while (start >= 0 && RegExp(r'\w').hasMatch(text[start])) {
      start--;
    }
    return start + 1;
  }

  int findWordEnd(String text, TextSelection selection) {
    var end = selection.extentOffset;
    while (end < text.length && RegExp(r'\w').hasMatch(text[end])) {
      end++;
    }
    return end;
  }

  @override
  void dispose() {
    super.dispose();
    textInputController.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: textInputController,
          contextMenuBuilder: (context, editableTextState) {
            return AdaptiveTextSelectionToolbar(
              anchors: editableTextState.contextMenuAnchors,
              children: [
                InkWell(
                  onTap: () {
                    print('Save');
                  },
                  child: SizedBox(
                    width: 45.0,
                    height: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.0150,
                        left: width * 0.02,
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          fontSize: AppSize.s14,
                        ),
                      ),
                    ),
                  ),
                ),
                const VerticalDivider(
                  color: Colors.grey,
                  width: 1,
                ),
                InkWell(
                  onTap: () {
                    final text = textInputController.text;
                    Clipboard.setData(ClipboardData(text: text));
                    textInputController.clear();
                  },
                  child: SizedBox(
                    width: 45.0,
                    height: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.0150,
                        left: width * 0.02,
                      ),
                      child: const Text(
                        'Cute',
                        style: TextStyle(
                          fontSize: AppSize.s14,
                        ),
                      ),
                    ),
                  ),
                ),
                const VerticalDivider(
                  color: Colors.grey,
                  width: 1,
                ),
                InkWell(
                  onTap: () {
                    final text = textInputController.text;
                    Clipboard.setData(ClipboardData(text: text));
                  },
                  child: SizedBox(
                    width: 45.0,
                    height: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.0150,
                        left: width * 0.02,
                      ),
                      child: const Text(
                        'Copy',
                        style: TextStyle(
                          fontSize: AppSize.s14,
                        ),
                      ),
                    ),
                  ),
                ),
                const VerticalDivider(
                  color: Colors.grey,
                  width: 1,
                ),
                InkWell(
                  onTap: () async {
                    final clipboardData =
                        await Clipboard.getData(Clipboard.kTextPlain);
                    textInputController.text += clipboardData!.text!;
                  },
                  child: SizedBox(
                    width: 50.0,
                    height: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.0150,
                        left: width * 0.02,
                      ),
                      child: const Text(
                        'Paste',
                        style: TextStyle(
                          fontSize: AppSize.s14,
                        ),
                      ),
                    ),
                  ),
                ),
                const VerticalDivider(
                  color: Colors.grey,
                  width: 1,
                ),
                InkWell(
                  // onTap: () {
                  //   if (idPositionsCircle !=
                  //       key) {
                  //     setState(
                  //       () {
                  //         positionsCircle
                  //             .remove(key);
                  //       },
                  //     );
                  //   }
                  // },
                  child: SizedBox(
                    width: 65.0,
                    height: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.0150,
                        left: width * 0.02,
                      ),
                      child: const Text(
                        'Remove',
                        style: TextStyle(
                          fontSize: AppSize.s14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          onTapOutside: (event) =>
              FocusManager.instance.primaryFocus?.unfocus(),
          // enableInteractiveSelection: false,
          onTap: () => setFocus(),
          // onChanged: (value) => setFocus(),
          // autofocus: true,
          focusNode: focusNode,
          style: const TextStyle(
            fontWeight: FontWeight.bold, // make bold
          ),
          textAlign: TextAlign.center,
          maxLength: widget.maxLength,
          decoration: const InputDecoration(
            isDense: true,
            counterText: "",
            border: InputBorder.none,
          ),
        ),
      ],
    );
  }
}
