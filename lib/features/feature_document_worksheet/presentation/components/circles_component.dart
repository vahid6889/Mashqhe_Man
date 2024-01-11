import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mashgh/core/components/text_field_in_shape.dart';
import 'package:mashgh/core/params/shape_params.dart';
import 'package:mashgh/core/usecase/use_case.dart';
import 'package:mashgh/core/utils/constants.dart';
import 'package:mashgh/core/utils/geometry/geometry.dart';
import 'package:mashgh/features/feature_document_worksheet/presentation/bloc/toolbar/shapes/circle/circle_bloc.dart';
import 'package:mashgh/features/feature_document_worksheet/presentation/bloc/toolbar/shapes/circle/get_all_circle_status.dart';
import 'package:mashgh/features/feature_document_worksheet/presentation/bloc/toolbar/shapes/circle/save_circle_worksheet_status.dart';

class CirclesComponent extends StatelessWidget {
  final Map<String, Map<String, dynamic>> positionsCircle;
  // final TextEditingController textWorksheepController;
  final ScrollController scrollController;
  final int maxLinesInTextField;
  final int heightLineInTextField;
  const CirclesComponent({
    super.key,
    required this.positionsCircle,
    // required this.textWorksheepController,
    required this.scrollController,
    required this.maxLinesInTextField,
    required this.heightLineInTextField,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return Stack(
      children: [
        ...positionsCircle
            .map(
              (key, value) {
                if (value['xPosition'] != 0 && value['yPosition'] != 0) {
                  // textWorksheetController.text = '';

                  return MapEntry(
                    key,
                    Positioned(
                      left: value['xPosition'],
                      top: value['yPosition'],
                      child: Draggable(
                        maxSimultaneousDrags: 1,
                        feedback: Container(
                          width: Geometry.createCircle().radius * 12,
                          height: Geometry.createCircle().radius * 12,
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
                          // double dy = details.globalPosition.dy;
                          // if (details.globalPosition.dy > 768) {
                          //   // Calculate extra scroll amount
                          //   final extraScroll =
                          //       dy - MediaQuery.of(context).size.height;

                          //   scrollController.animateTo(
                          //     extraScroll +
                          //         (maxLinesInTextField *
                          //             heightLineInTextField) -
                          //         height,
                          //     duration: const Duration(milliseconds: 2000),
                          //     curve: Curves.ease,
                          //   );
                          //   // globalPosition = Offset(
                          //   //     details.globalPosition.dx,
                          //   //     extraScroll +
                          //   //         (maxLinesInTextField *
                          //   //             heightLineInTextField) -
                          //   //         details.globalPosition.dy);
                          //   // print((maxLinesInTextField *
                          //   //     heightLineInTextField)); // 1275
                          //   // print(dy + extraScroll); // 919
                          //   // print((maxLinesInTextField *
                          //   //         heightLineInTextField) -
                          //   //     details.globalPosition
                          //   //         .dy); // 449 to 402

                          //   // globalPositionDy = dy + extraScroll;
                          // }
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
                        onDraggableCanceled: (velocity, offset) {},
                        onDragEnd: (details) {
                          /// call save circle event

                          /// 36.0 pixels for the yPosition related to the ScrollController of the page is reduced due to the toolbox placed in the appbar at the top of the page
                          ShapeParams shapeParams = ShapeParams(
                            uniqueId: key,
                            worksheetUniqueId: null,
                            content: '',
                            type: value['type'],
                            xPosition: details.offset.dx,
                            yPosition: details.offset.dy +
                                scrollController.offset -
                                36.0,
                          );
                          BlocProvider.of<CircleBloc>(context)
                              .positionsCircle[key] = {
                            'worksheetUniqueId': null,
                            'content': '',
                            'type': ShapesType.circle.name,
                            'xPosition': details.offset.dx,
                            'yPosition': details.offset.dy +
                                scrollController.offset -
                                36.0,
                          };
                          BlocProvider.of<CircleBloc>(context)
                              .add(SaveCirlceWorksheetEvent(shapeParams));
                          // print(key);
                          // print(details.offset.dy);
                          // updatePosition(
                          //   // globalPositionDy != null
                          //   //     ? Offset(details.offset.dx,
                          //   //         globalPositionDy!)
                          //   //     : details.offset,
                          //   // details.offset,
                          //   Offset(details.offset.dx,
                          //       details.offset.dy + _scrollController.offset),
                          //   uniqueId:
                          //       (idPositionsCircle == key) ? true : false,
                          //   idPosition: (idPositionsCircle == key)
                          //       ? idPositionsCircle
                          //       : key,
                          //   shape: 'circle',
                          // );
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
                            width: Geometry.createCircle().radius * 12,
                            height: Geometry.createCircle().radius * 12,
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
    );
  }
}
