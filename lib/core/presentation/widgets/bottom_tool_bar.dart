import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mashgh/core/components/custom_text_field.dart';
import 'package:mashgh/core/utils/geometry/geometry.dart';
import 'package:uuid/uuid.dart';

class BottomToolBar extends StatefulWidget {
  const BottomToolBar({super.key});

  @override
  State<BottomToolBar> createState() => _BottomToolBoxState();
}

class _BottomToolBoxState extends State<BottomToolBar> {
  final textWorksheepController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  FocusNode textFieldFocusNode = FocusNode();
  Map<String, Offset> positionsCircle = {};
  String idPositionsCircle = const Uuid().v4();
  double? charInLineTextField;
  int maxLinesInTextField = 15;
  int? maxLengthInTextField;
  int heightLineInTextField = 85;

  int numLines = 0;
  // Offset? globalPosition;
  // double? globalPositionDy;
  // double? verticalPosition;
  double? scrollPosition;

  double prevScale = 1;
  double scale = 1;

  void updateScale(double zoom) => setState(() => scale = prevScale * zoom);
  void commitScale() => setState(() => prevScale = scale);
  void updatePosition(
    Offset newPosition, {
    bool? uniqueId,
    String? idPosition,
    String? shape,
  }) {
    switch (shape) {
      case 'circle':
        setState(
          () {
            positionsCircle[idPosition!] = newPosition;
            idPosition = '';

            if (uniqueId == true) {
              idPositionsCircle = const Uuid().v4();
              positionsCircle[idPositionsCircle] = const Offset(0, 0);
            }
          },
        );
        break;
      default:
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      scrollPosition = _scrollController.offset;
    });
  }

  @override
  void dispose() {
    super.dispose();
    textWorksheepController.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    /// operating max length characters text field
    charInLineTextField = width / (maxLinesInTextField - 1) + 5;
    maxLengthInTextField =
        charInLineTextField!.round() * (maxLinesInTextField - 1);

    return GestureDetector(
      // onScaleUpdate: (details) => updateScale(details.scale),
      onScaleEnd: (_) => commitScale(),
      child: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            controller: _scrollController,
            child: Stack(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(right: 8.0, left: 8.0, top: 35.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          focusNode: textFieldFocusNode,
                          controller: textWorksheepController,
                          textInputAction: TextInputAction.newline,
                          onChanged: (text) {
                            if (text.contains('\n') &&
                                text.codeUnits.isNotEmpty &&
                                text.codeUnits.last == 10) {
                              numLines = '\n'.allMatches(text).length;
                              debugPrint('numLines $numLines');
                              if (numLines > 14) {
                                textFieldFocusNode.unfocus();
                              }
                            }

                            // numLines = '\n'.allMatches(text).length + 1;

                            // if (numLines > 14 &&
                            //     text.codeUnits.isNotEmpty &&
                            //     text.codeUnits.last == 10) {
                            //   setState(() {});

                            //   textFieldFocusNode.unfocus();
                            // }

                            //   if (text.contains('\n')) {
                            //     numLines = '\n'.allMatches(text).length + 1;
                            //     // if(numLines > 15) {
                            //     //   textWorksheepController
                            //     // }
                            //     // print(text);
                            //     // enterCounter++;

                            //     // if (enterCounter > 15) {
                            //     //   textWorksheepController.text = textWorksheepController
                            //     //       .text
                            //     //       .replaceAll('\n', '');
                            //     //   ScaffoldMessenger.of(context).showSnackBar(
                            //     //     const SnackBar(
                            //     //       content: Text("Reached max lines"),
                            //     //     ),
                            //     //   );
                            //     //   MaxLengthEnforcement.enforced;
                            //     // }
                            //   }
                          },
                          style: const TextStyle(
                            wordSpacing: 20,
                            height: 4,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 5.0),
                            hintText: "Insert your message",
                            hintStyle: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          scrollPadding: const EdgeInsets.all(20.0),
                          keyboardType: TextInputType.multiline,
                          maxLines: maxLinesInTextField,
                          cursorHeight: 120,
                          maxLength: maxLengthInTextField,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          // cursorWidth: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Stack(
                    children: [
                      ...positionsCircle
                          .map(
                            (key, value) {
                              if (value.dx != 0 && value.dy != 0) {
                                textWorksheepController.text = '';
                                return MapEntry(
                                  key,
                                  Positioned(
                                    left: value.dx,
                                    top: value.dy,
                                    child: Draggable(
                                      maxSimultaneousDrags: 1,
                                      feedback: Container(
                                        width:
                                            Geometry.createCircle().radius * 12,
                                        height:
                                            Geometry.createCircle().radius * 12,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      onDragUpdate: (details) {
                                        // print(height);
                                        double dy = details.globalPosition.dy;
                                        if (details.globalPosition.dy > 768) {
                                          // Calculate extra scroll amount
                                          final extraScroll = dy -
                                              MediaQuery.of(context)
                                                  .size
                                                  .height;

                                          _scrollController.animateTo(
                                            extraScroll +
                                                (maxLinesInTextField *
                                                    heightLineInTextField) -
                                                height,
                                            duration: const Duration(
                                                milliseconds: 2000),
                                            curve: Curves.ease,
                                          );
                                          // globalPosition = Offset(
                                          //     details.globalPosition.dx,
                                          //     extraScroll +
                                          //         (maxLinesInTextField *
                                          //             heightLineInTextField) -
                                          //         details.globalPosition.dy);
                                          // print((maxLinesInTextField *
                                          //     heightLineInTextField)); // 1275
                                          // print(dy + extraScroll); // 919
                                          // print((maxLinesInTextField *
                                          //         heightLineInTextField) -
                                          //     details.globalPosition
                                          //         .dy); // 449 to 402

                                          // globalPositionDy = dy + extraScroll;
                                        }
                                        // double ddyy = (maxLinesInTextField *
                                        //         heightLineInTextField) -
                                        //     (MediaQuery.of(context)
                                        //             .size
                                        //             .height -
                                        //         dy);
                                        // globalPositionDy = ddyy;

                                        // scrollController.addListener(() {
                                        //   if (scrollController.position
                                        //           .userScrollDirection ==
                                        //       ScrollDirection.forward) {
                                        //     verticalPosition = scrollController
                                        //         .position.pixels;
                                        //   }
                                        // });
                                        // if (dy > 760) {

                                        // }
                                        // print(scrollPosition);
                                      },
                                      onDraggableCanceled:
                                          (velocity, offset) {},
                                      onDragEnd: (details) {
                                        // print(details.offset.dy);
                                        updatePosition(
                                          // globalPositionDy != null
                                          //     ? Offset(details.offset.dx,
                                          //         globalPositionDy!)
                                          //     : details.offset,
                                          // details.offset,
                                          Offset(
                                              details.offset.dx,
                                              details.offset.dy +
                                                  _scrollController.offset),
                                          uniqueId: (idPositionsCircle == key)
                                              ? true
                                              : false,
                                          idPosition: (idPositionsCircle == key)
                                              ? idPositionsCircle
                                              : key,
                                          shape: 'circle',
                                        );
                                      },
                                      childWhenDragging: Opacity(
                                        opacity: .3,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width:
                                                Geometry.createCircle().radius *
                                                    12,
                                            height:
                                                Geometry.createCircle().radius *
                                                    12,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.black,
                                                width: 2,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: SingleChildScrollView(
                                        // controller: scrollController,
                                        scrollDirection: Axis.vertical,
                                        // child: Stack(
                                        //   children: [
                                        //     GestureDetector(
                                        //       behavior:
                                        //           HitTestBehavior.translucent,
                                        //       onDoubleTap: () {
                                        //         if (idPositionsCircle !=
                                        //             key) {
                                        //           setState(
                                        //             () {
                                        //               positionsCircle
                                        //                   .remove(key);
                                        //             },
                                        //           );
                                        //         }
                                        //       },
                                        child: Container(
                                          width:
                                              Geometry.createCircle().radius *
                                                  12,
                                          height:
                                              Geometry.createCircle().radius *
                                                  12,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 2,
                                            ),
                                          ),
                                          child: const TextFieldInShape(
                                            maxLength: 4,
                                          ),
                                        ),
                                        // ),
                                        //     Padding(
                                        //       padding: const EdgeInsets.only(
                                        //         top: 20.0,
                                        //         // bottom: 18.0,
                                        //       ),
                                        //       child: Positioned(
                                        //         left: value.dx,
                                        //         top: value.dy,
                                        //         child: Listener(
                                        //           onPointerDown: (event) {
                                        //             pressStartTime =
                                        //                 DateTime.now();

                                        //             Timer(
                                        //                 const Duration(
                                        //                     seconds: 1), () {
                                        //               final elapsed = DateTime
                                        //                       .now()
                                        //                   .difference(
                                        //                       pressStartTime!);

                                        //               if (elapsed >=
                                        //                   const Duration(
                                        //                       seconds: 1)) {
                                        //                 print("Long Press");
                                        //               }
                                        //             });
                                        //             // start long press timer
                                        //             // Timer(duration, () {
                                        //             //   longPressActive = true;
                                        //             //   // onLongPress();
                                        //             //   print('onLongPress');
                                        //             // });
                                        //           },
                                        //           onPointerUp: (event) {
                                        //             // cancel any active long press
                                        //             longPressActive = false;
                                        //           },
                                        //           child: Container(
                                        //             width: 60,
                                        //             height: 20,
                                        //             child: TextField(
                                        //               onTapOutside: (event) =>
                                        //                   FocusManager
                                        //                       .instance
                                        //                       .primaryFocus
                                        //                       ?.unfocus(),
                                        //               // enableInteractiveSelection: false,
                                        //               // onTap: () => setFocus(),
                                        //               // onChanged: (value) => setFocus(),
                                        //               // autofocus: true,
                                        //               focusNode: focusNode,
                                        //               style: const TextStyle(
                                        //                 fontWeight: FontWeight
                                        //                     .bold, // make bold
                                        //               ),
                                        //               textAlign:
                                        //                   TextAlign.center,
                                        //               maxLength: 4,
                                        //               // controller: textInputController,
                                        //               decoration:
                                        //                   const InputDecoration(
                                        //                 isDense: true,
                                        //                 counterText: "",
                                        //                 border:
                                        //                     InputBorder.none,
                                        //               ),
                                        //             ),
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                      ),
                                    ),
                                  ),
                                );
                              }

                              return MapEntry(key, Container());
                            },
                          )
                          .values
                          .toList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Container(
                  height: height * 0.110,
                  color: Colors.amber,
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Draggable(
                    maxSimultaneousDrags: 1,
                    feedback: Container(
                      width: Geometry.createCircle().radius * 12,
                      height: Geometry.createCircle().radius * 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                    ),
                    onDragEnd: (details) {
                      updatePosition(
                        Offset(
                          details.offset.dx,
                          details.offset.dy + _scrollController.offset,
                        ),
                        uniqueId: true,
                        idPosition: idPositionsCircle,
                        shape: 'circle',
                      );
                    },
                    childWhenDragging: Opacity(
                      opacity: .3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: Geometry.createCircle().radius * 12,
                          height: Geometry.createCircle().radius * 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                        ),
                      ),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      // controller: scrollController,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: Geometry.createCircle().radius * 12,
                          height: Geometry.createCircle().radius * 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // CustomPaint(
          //   painter: Geometry.createPolygon(rhombic: true),
          //   child: Container(),
          // ),

          // ...positions
          //     .map(
          //       (key, value) {
          //         return MapEntry(
          //           key,
          //           Positioned(
          //             left: value.dx,
          //             top: value.dy,
          //             child: Draggable(
          //               maxSimultaneousDrags: 1,
          //               feedback: Container(
          //                 width: Geometry.createRect().width * 2.5,
          //                 height: Geometry.createRect().height * 1.4,
          //                 decoration: BoxDecoration(
          //                   shape: BoxShape.rectangle,
          //                   border: Border.all(color: Colors.black, width: 2),
          //                 ),
          //               ),
          //               onDragStarted: () {},
          //               onDraggableCanceled: (velocity, offset) {},
          //               onDragEnd: (details) {
          //                 updatePosition(
          //                   details.offset,
          //                   newId: (id == key) ? true : false,
          //                   oldId: key,
          //                 );
          //               },
          //               childWhenDragging: Opacity(
          //                 opacity: .3,
          //                 child: Container(
          //                   width: Geometry.createRect().width * 2.5,
          //                   height: Geometry.createRect().height * 1.4,
          //                   decoration: BoxDecoration(
          //                     shape: BoxShape.rectangle,
          //                     border:
          //                         Border.all(color: Colors.black, width: 2),
          //                   ),
          //                 ),
          //               ),
          //               child: GestureDetector(
          //                 onDoubleTap: () {
          //                   if (id != key) {
          //                     setState(() {
          //                       positions.remove(key);
          //                     });
          //                   }
          //                 },
          //                 child: Container(
          //                   width: Geometry.createRect().width * 2.5,
          //                   height: Geometry.createRect().height * 1.4,
          //                   decoration: BoxDecoration(
          //                     shape: BoxShape.rectangle,
          //                     border:
          //                         Border.all(color: Colors.black, width: 2),
          //                   ),
          //                   child: Column(
          //                     mainAxisAlignment: MainAxisAlignment.center,
          //                     children: [
          //                       TextFormField(
          //                         textAlign: TextAlign.center,
          //                         maxLength: 5,
          //                         decoration: const InputDecoration(
          //                           isDense: true,
          //                           counterText: "",
          //                           border: InputBorder.none,
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ),
          //         );
          //       },
          //     )
          //     .values
          //     .toList(),
        ],
      ),
    );
  }
}


// class CustomTextField extends StatefulWidget {
//   const CustomTextField({super.key});

//   @override
//   State<CustomTextField> createState() => _CustomTextFieldState();
// }

// class _CustomTextFieldState extends State<CustomTextField> {
//   final textEditingController = TextEditingController();
//   late FocusNode textFieldFocusNode;

//   @override
//   void initState() {
//     textFieldFocusNode = FocusNode();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: TextField(
//           // maxLength: 1,
//           // maxLines: 1,
//           focusNode: textFieldFocusNode,
//           controller: textEditingController,
//           textAlign: TextAlign.center,
//           onChanged: (value) {
//             print(value);
//           },
//         ),
//       ),
//     );
//   }
// }
