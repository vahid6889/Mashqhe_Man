// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_field, unused_element

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:mashgh/core/blocs/cubits/toolbar_component_cubit.dart';
import 'package:mashgh/core/components/toolbar_component.dart';
import 'package:mashgh/core/components/toolbox_app_bar.dart';
import 'package:mashgh/core/config/toolbar/colors.dart';
import 'package:mashgh/core/data/entities/worksheet_entity.dart';
import 'package:mashgh/core/params/worksheet_params.dart';
import 'package:mashgh/core/presentation/ui/main_wrapper.dart';
import 'package:mashgh/core/presentation/widgets/back_floating_action_button_widget.dart';
import 'package:mashgh/core/usecase/use_case.dart';
import 'package:mashgh/features/feature_document_worksheet/presentation/bloc/toolbar/shapes/circle/circle_bloc.dart';
import 'package:mashgh/features/feature_document_worksheet/presentation/bloc/worksheet/document/document_bloc.dart';
import 'package:mashgh/features/feature_document_worksheet/presentation/widgets/shapes_toolbar_widget.dart';
import 'package:mashgh/features/feature_document_worksheet/presentation/widgets/shapes_worksheet_widget.dart';
import 'package:mashgh/features/feature_workspace_managment/presentation/bloc/workspace/worksheets_bloc/get_worksheet_by_id_status.dart';
import 'package:mashgh/features/feature_workspace_managment/presentation/bloc/workspace/worksheets_bloc/workspace_worksheet_bloc.dart';
import 'package:intl/intl.dart' as intl;
import 'package:uuid/uuid.dart';

class DocumentWorksheetPage extends StatefulWidget {
  static const routeName = "/document_worksheet";
  const DocumentWorksheetPage({super.key});

  @override
  State<DocumentWorksheetPage> createState() => _BottomToolBoxState();
}

class _BottomToolBoxState extends State<DocumentWorksheetPage> {
  TextEditingController _textWorksheetController = TextEditingController();
  final ScrollController _scrollControllerScreen = ScrollController();
  final QuillController _quillController = QuillController(
    document: Document(),
    selection: const TextSelection.collapsed(offset: 0),
  );
  ScrollController? _scrollControllerToolbar;
  FocusNode textFieldFocusNode = FocusNode();
  // Map<String, Offset> positionsCircle = {};
  // String idPositionsCircle = const Uuid().v4();
  double? charInLineTextField;
  int maxLinesInTextField = 15;
  int? maxLengthInTextField;
  int heightLineInTextField = 85;
  String _navigationMethod = '';
  String? _documentUniqueId;
  int? _documentId;
  int? _documentDate;

  int numLines = 0;
  // Offset? globalPosition;
  // double? globalPositionDy;
  // double? verticalPosition;
  // double? scrollPosition;

  double prevScale = 1;
  double scale = 1;

  void updateScale(double zoom) => setState(() => scale = prevScale * zoom);
  void commitScale() => setState(() => prevScale = scale);
  // void updatePosition(
  //   Offset newPosition, {
  //   bool? uniqueId,
  //   String? idPosition,
  //   String? shape,
  // }) {
  //   switch (shape) {
  //     case 'circle':
  //       setState(
  //         () {
  //           positionsCircle[idPosition!] = newPosition;
  //           idPosition = '';

  //           if (uniqueId == true) {
  //             idPositionsCircle = const Uuid().v4();
  //             positionsCircle[idPositionsCircle] = const Offset(0, 0);
  //           }
  //         },
  //       );
  //       break;
  //     default:
  //   }
  // }

  TextDirection getDirection(String text) {
    bool isRtl = intl.Bidi.detectRtlDirectionality(text);
    return isRtl ? TextDirection.rtl : TextDirection.ltr;
  }

  @override
  void initState() {
    super.initState();
    _textWorksheetController = TextEditingController();
    // _scrollController.addListener(() {
    //   scrollPosition = _scrollController.offset;
    // });

    /// delete all temporary shapes on worksheet if worksheet unique id is null
    BlocProvider.of<DocumentBloc>(context)
        .add(DeleteAllTempShapeEvent(NoParams()));
  }

  @override
  void dispose() {
    _textWorksheetController.dispose();
    _scrollControllerScreen.dispose();
    _scrollControllerToolbar!.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    /// save temp document when user left the page
    List<int> listTextWorksheetController =
        utf8.encode(_textWorksheetController.text);
    Uint8List uint8ListTextWorksheetController =
        Uint8List.fromList(listTextWorksheetController);

    WorksheetParams worksheetParams = WorksheetParams(
      id: _documentId,
      uniqueId: _documentUniqueId,
      categoryId: null,
      content: uint8ListTextWorksheetController,
      name: null,
      worksheetType: WorksheetEntity.TYPE_WORKSHEET_DOCUMENT,
      date: _documentDate,
    );

    BlocProvider.of<DocumentBloc>(context)
        .add(SaveTempDocumentEvent(worksheetParams));

    /// set initial worksheet by id event
    NoParams noParams = NoParams();
    BlocProvider.of<WorkspaceWorksheetBloc>(context)
        .add(GetWorksheetByIdInitialEvent(noParams));

    BlocProvider.of<CircleBloc>(context)
        .add(GetAllCircleInitialEvent(noParams));

    _documentUniqueId = null;

    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    /// set rtl direction in document
    _quillController.document.format(
      _quillController.document.length - 1,
      0,
      const Attribute(
        'direction',
        AttributeScope.block,
        'rtl',
      ),
    );

    /// get argument from navigator pages
    final Map<String, dynamic>? _args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    _navigationMethod = _args?['navigationMethod'] ?? 'unknown';
    _documentUniqueId = _args?['documentUniqueId'] ?? const Uuid().v4();
    _documentId = _args?['documentId'];
    _documentDate = _args?['documentDate'];

    /// operating max length characters text field
    charInLineTextField = width / (maxLinesInTextField - 1) + 5;
    maxLengthInTextField =
        charInLineTextField!.round() * (maxLinesInTextField - 1);

    return Scaffold(
      floatingActionButton: Visibility(
        visible: _navigationMethod == 'pushNamedAndRemoveUntil' ? true : false,
        child: BackFloatingActionButtonWidget(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              MainWrapper.routeName,
              ModalRoute.withName(MainWrapper.routeName),
            );
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.arrow_back),
        ),
      ),
      appBar: ToolboxAppBar(
        quillController: _quillController,
      ),
      body: GestureDetector(
        // onScaleUpdate: (details) => updateScale(details.scale),
        onScaleEnd: (_) => commitScale(),
        child: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              controller: _scrollControllerScreen,
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlocBuilder<WorkspaceWorksheetBloc, WorksheetState>(
                          buildWhen: (previous, current) {
                            if (current.getWorksheetByIdStatus ==
                                previous.getWorksheetByIdStatus) {
                              return false;
                            }
                            return true;
                          },
                          builder: (context, state) {
                            if (state.getWorksheetByIdStatus
                                is GetWorksheetByIdCompleted) {
                              /// cast data
                              final GetWorksheetByIdCompleted
                                  _getWorksheetByIdCompleted =
                                  state.getWorksheetByIdStatus
                                      as GetWorksheetByIdCompleted;

                              final WorksheetEntity? _worksheeTempEntity =
                                  _getWorksheetByIdCompleted.worksheetEntity;

                              _textWorksheetController.text =
                                  utf8.decode(_worksheeTempEntity!.content!);

                              return TextField(
                                focusNode: textFieldFocusNode,
                                controller: _textWorksheetController,
                                textDirection:
                                    getDirection(_textWorksheetController.text),
                                textAlign: intl.Bidi.detectRtlDirectionality(
                                        _textWorksheetController.text)
                                    ? TextAlign.right
                                    : TextAlign.left,
                                textInputAction: TextInputAction.newline,
                                onChanged: (text) {
                                  if (text.contains('\n') &&
                                      text.codeUnits.isNotEmpty &&
                                      text.codeUnits.last == 10) {
                                    numLines = '\n'.allMatches(text).length;

                                    if (numLines > 14) {
                                      textFieldFocusNode.unfocus();
                                      // text.trim();
                                    }
                                  }
                                },
                                style: const TextStyle(
                                  wordSpacing: 20,
                                  height: 4,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  hintText: intl.Bidi.detectRtlDirectionality(
                                          _textWorksheetController.text)
                                      ? "شروع ..."
                                      : " Start ...",
                                  hintStyle: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  hintTextDirection: getDirection(
                                      _textWorksheetController.text),
                                ),
                                scrollPadding: const EdgeInsets.all(20.0),
                                keyboardType: TextInputType.multiline,
                                maxLines: maxLinesInTextField,
                                cursorHeight: 120,
                                maxLength: maxLengthInTextField,
                                maxLengthEnforcement:
                                    MaxLengthEnforcement.enforced,
                                // cursorWidth: 5,
                              );
                            }

                            // return TextField(
                            //   focusNode: textFieldFocusNode,
                            //   controller: _textWorksheetController,
                            //   textDirection:
                            //       getDirection(_textWorksheetController.text),
                            //   textAlign: intl.Bidi.detectRtlDirectionality(
                            //           _textWorksheetController.text)
                            //       ? TextAlign.right
                            //       : TextAlign.left,
                            //   textInputAction: TextInputAction.newline,
                            //   onChanged: (text) {
                            //     setState(() {});
                            //     if (text.contains('\n') &&
                            //         text.codeUnits.isNotEmpty &&
                            //         text.codeUnits.last == 10) {
                            //       numLines = '\n'.allMatches(text).length;

                            //       if (numLines > 14) {
                            //         textFieldFocusNode.unfocus();
                            //         // text.trim();
                            //       }
                            //     }

                            //     // numLines = '\n'.allMatches(text).length + 1;

                            //     // if (numLines > 14 &&
                            //     //     text.codeUnits.isNotEmpty &&
                            //     //     text.codeUnits.last == 10) {
                            //     //   setState(() {});

                            //     //   textFieldFocusNode.unfocus();
                            //     // }

                            //     //   if (text.contains('\n')) {
                            //     //     numLines = '\n'.allMatches(text).length + 1;
                            //     //     // if(numLines > 15) {
                            //     //     //   textWorksheetController
                            //     //     // }
                            //     //     // print(text);
                            //     //     // enterCounter++;

                            //     //     // if (enterCounter > 15) {
                            //     //     //   textWorksheetController.text = textWorksheetController
                            //     //     //       .text
                            //     //     //       .replaceAll('\n', '');
                            //     //     //   ScaffoldMessenger.of(context).showSnackBar(
                            //     //     //     const SnackBar(
                            //     //     //       content: Text("Reached max lines"),
                            //     //     //     ),
                            //     //     //   );
                            //     //     //   MaxLengthEnforcement.enforced;
                            //     //     // }
                            //     //   }
                            //   },
                            //   style: const TextStyle(
                            //     // wordSpacing: 50,
                            //     height: 4,
                            //     fontSize: 20,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            //   decoration: InputDecoration(
                            //     contentPadding: const EdgeInsets.symmetric(
                            //       horizontal: 5.0,
                            //     ),
                            //     hintText: intl.Bidi.detectRtlDirectionality(
                            //             _textWorksheetController.text)
                            //         ? "شروع ..."
                            //         : " Start ...",
                            //     hintStyle: const TextStyle(
                            //       fontSize: 20.0,
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //     hintTextDirection: getDirection(
                            //         _textWorksheetController.text),
                            //   ),
                            //   scrollPadding: const EdgeInsets.all(20.0),
                            //   keyboardType: TextInputType.multiline,
                            //   maxLines: maxLinesInTextField,
                            //   cursorHeight: 120,
                            //   maxLength: maxLengthInTextField,
                            //   maxLengthEnforcement:
                            //       MaxLengthEnforcement.enforced,
                            //   // cursorWidth: 5,
                            // );
                            return Padding(
                              padding: const EdgeInsets.only(
                                top: 8.0,
                                right: 8.0,
                                left: 8.0,
                              ),
                              child: QuillEditor.basic(
                                configurations: QuillEditorConfigurations(
                                  scrollable: true,
                                  // scrollBottomInset: 1.0,
                                  scrollPhysics: const BouncingScrollPhysics(),
                                  maxHeight: height * 1.5,
                                  minHeight: height * 1.5,
                                  showCursor: true,
                                  dialogTheme: const QuillDialogTheme(
                                    inputTextStyle:
                                        TextStyle(color: Colors.white),
                                    dialogBackgroundColor: Colors.white,
                                    buttonTextStyle:
                                        TextStyle(color: Colors.white),
                                    labelTextStyle:
                                        TextStyle(color: Colors.white),
                                  ),
                                  controller: _quillController,
                                  readOnly: false,
                                  sharedConfigurations:
                                      const QuillSharedConfigurations(
                                    dialogBarrierColor: Colors.white,
                                    dialogTheme: QuillDialogTheme(
                                      inputTextStyle:
                                          TextStyle(color: Colors.white),
                                      dialogBackgroundColor: Colors.white,
                                      buttonTextStyle:
                                          TextStyle(color: Colors.white),
                                      labelTextStyle:
                                          TextStyle(color: Colors.white),
                                    ),
                                    locale: Locale('fa', 'IR'),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  ShapesWorksheetWidget(
                    // textWorksheetController: textWorksheetController,
                    scrollController: _scrollControllerScreen,
                    maxLinesInTextField: maxLinesInTextField,
                    heightLineInTextField: heightLineInTextField,
                  ),
                  // Positioned.fill(
                  //   child: Stack(
                  //     children: [
                  //       ...positionsCircle
                  //           .map(
                  //             (key, value) {
                  //               if (value.dx != 0 && value.dy != 0) {
                  //                 textWorksheetController.text = '';
                  //                 return MapEntry(
                  //                   key,
                  //                   Positioned(
                  //                     left: value.dx,
                  //                     top: value.dy,
                  //                     child: Draggable(
                  //                       maxSimultaneousDrags: 1,
                  //                       feedback: Container(
                  //                         width:
                  //                             Geometry.createCircle().radius * 12,
                  //                         height:
                  //                             Geometry.createCircle().radius * 12,
                  //                         decoration: BoxDecoration(
                  //                           shape: BoxShape.circle,
                  //                           border: Border.all(
                  //                             color: Colors.black,
                  //                             width: 2,
                  //                           ),
                  //                         ),
                  //                       ),
                  //                       onDragUpdate: (details) {
                  //                         // print(height);
                  //                         double dy = details.globalPosition.dy;
                  //                         if (details.globalPosition.dy > 768) {
                  //                           // Calculate extra scroll amount
                  //                           final extraScroll = dy -
                  //                               MediaQuery.of(context)
                  //                                   .size
                  //                                   .height;

                  //                           _scrollController.animateTo(
                  //                             extraScroll +
                  //                                 (maxLinesInTextField *
                  //                                     heightLineInTextField) -
                  //                                 height,
                  //                             duration: const Duration(
                  //                                 milliseconds: 2000),
                  //                             curve: Curves.ease,
                  //                           );
                  //                           // globalPosition = Offset(
                  //                           //     details.globalPosition.dx,
                  //                           //     extraScroll +
                  //                           //         (maxLinesInTextField *
                  //                           //             heightLineInTextField) -
                  //                           //         details.globalPosition.dy);
                  //                           // print((maxLinesInTextField *
                  //                           //     heightLineInTextField)); // 1275
                  //                           // print(dy + extraScroll); // 919
                  //                           // print((maxLinesInTextField *
                  //                           //         heightLineInTextField) -
                  //                           //     details.globalPosition
                  //                           //         .dy); // 449 to 402

                  //                           // globalPositionDy = dy + extraScroll;
                  //                         }
                  //                         // double ddyy = (maxLinesInTextField *
                  //                         //         heightLineInTextField) -
                  //                         //     (MediaQuery.of(context)
                  //                         //             .size
                  //                         //             .height -
                  //                         //         dy);
                  //                         // globalPositionDy = ddyy;

                  //                         // scrollController.addListener(() {
                  //                         //   if (scrollController.position
                  //                         //           .userScrollDirection ==
                  //                         //       ScrollDirection.forward) {
                  //                         //     verticalPosition = scrollController
                  //                         //         .position.pixels;
                  //                         //   }
                  //                         // });
                  //                         // if (dy > 760) {

                  //                         // }
                  //                         // print(scrollPosition);
                  //                       },
                  //                       onDraggableCanceled:
                  //                           (velocity, offset) {},
                  //                       onDragEnd: (details) {
                  //                         // print(details.offset.dy);
                  //                         updatePosition(
                  //                           // globalPositionDy != null
                  //                           //     ? Offset(details.offset.dx,
                  //                           //         globalPositionDy!)
                  //                           //     : details.offset,
                  //                           // details.offset,
                  //                           Offset(
                  //                               details.offset.dx,
                  //                               details.offset.dy +
                  //                                   _scrollController.offset),
                  //                           uniqueId: (idPositionsCircle == key)
                  //                               ? true
                  //                               : false,
                  //                           idPosition: (idPositionsCircle == key)
                  //                               ? idPositionsCircle
                  //                               : key,
                  //                           shape: 'circle',
                  //                         );
                  //                       },
                  //                       childWhenDragging: Opacity(
                  //                         opacity: .3,
                  //                         child: Padding(
                  //                           padding: const EdgeInsets.all(8.0),
                  //                           child: Container(
                  //                             width:
                  //                                 Geometry.createCircle().radius *
                  //                                     12,
                  //                             height:
                  //                                 Geometry.createCircle().radius *
                  //                                     12,
                  //                             decoration: BoxDecoration(
                  //                               shape: BoxShape.circle,
                  //                               border: Border.all(
                  //                                 color: Colors.black,
                  //                                 width: 2,
                  //                               ),
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                       child: SingleChildScrollView(
                  //                         // controller: scrollController,
                  //                         scrollDirection: Axis.vertical,
                  //                         // child: Stack(
                  //                         //   children: [
                  //                         //     GestureDetector(
                  //                         //       behavior:
                  //                         //           HitTestBehavior.translucent,
                  //                         //       onDoubleTap: () {
                  //                         //         if (idPositionsCircle !=
                  //                         //             key) {
                  //                         //           setState(
                  //                         //             () {
                  //                         //               positionsCircle
                  //                         //                   .remove(key);
                  //                         //             },
                  //                         //           );
                  //                         //         }
                  //                         //       },
                  //                         child: Container(
                  //                           width:
                  //                               Geometry.createCircle().radius *
                  //                                   12,
                  //                           height:
                  //                               Geometry.createCircle().radius *
                  //                                   12,
                  //                           decoration: BoxDecoration(
                  //                             shape: BoxShape.circle,
                  //                             border: Border.all(
                  //                               color: Colors.black,
                  //                               width: 2,
                  //                             ),
                  //                           ),
                  //                           child: const TextFieldInShape(
                  //                             maxLength: 4,
                  //                           ),
                  //                         ),
                  //                         // ),
                  //                         //     Padding(
                  //                         //       padding: const EdgeInsets.only(
                  //                         //         top: 20.0,
                  //                         //         // bottom: 18.0,
                  //                         //       ),
                  //                         //       child: Positioned(
                  //                         //         left: value.dx,
                  //                         //         top: value.dy,
                  //                         //         child: Listener(
                  //                         //           onPointerDown: (event) {
                  //                         //             pressStartTime =
                  //                         //                 DateTime.now();

                  //                         //             Timer(
                  //                         //                 const Duration(
                  //                         //                     seconds: 1), () {
                  //                         //               final elapsed = DateTime
                  //                         //                       .now()
                  //                         //                   .difference(
                  //                         //                       pressStartTime!);

                  //                         //               if (elapsed >=
                  //                         //                   const Duration(
                  //                         //                       seconds: 1)) {
                  //                         //                 print("Long Press");
                  //                         //               }
                  //                         //             });
                  //                         //             // start long press timer
                  //                         //             // Timer(duration, () {
                  //                         //             //   longPressActive = true;
                  //                         //             //   // onLongPress();
                  //                         //             //   print('onLongPress');
                  //                         //             // });
                  //                         //           },
                  //                         //           onPointerUp: (event) {
                  //                         //             // cancel any active long press
                  //                         //             longPressActive = false;
                  //                         //           },
                  //                         //           child: Container(
                  //                         //             width: 60,
                  //                         //             height: 20,
                  //                         //             child: TextField(
                  //                         //               onTapOutside: (event) =>
                  //                         //                   FocusManager
                  //                         //                       .instance
                  //                         //                       .primaryFocus
                  //                         //                       ?.unfocus(),
                  //                         //               // enableInteractiveSelection: false,
                  //                         //               // onTap: () => setFocus(),
                  //                         //               // onChanged: (value) => setFocus(),
                  //                         //               // autofocus: true,
                  //                         //               focusNode: focusNode,
                  //                         //               style: const TextStyle(
                  //                         //                 fontWeight: FontWeight
                  //                         //                     .bold, // make bold
                  //                         //               ),
                  //                         //               textAlign:
                  //                         //                   TextAlign.center,
                  //                         //               maxLength: 4,
                  //                         //               // controller: textInputController,
                  //                         //               decoration:
                  //                         //                   const InputDecoration(
                  //                         //                 isDense: true,
                  //                         //                 counterText: "",
                  //                         //                 border:
                  //                         //                     InputBorder.none,
                  //                         //               ),
                  //                         //             ),
                  //                         //           ),
                  //                         //         ),
                  //                         //       ),
                  //                         //     ),
                  //                         //   ],
                  //                         // ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 );
                  //               }

                  //               return MapEntry(key, Container());
                  //             },
                  //           )
                  //           .values
                  //           .toList(),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),

            /// toolbar handler
            Positioned.fill(
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    height: height * 0.110,
                    color: toolbarBackgroundColor,
                    child: const ToolbarComponent(),
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: BlocBuilder<ToolbarComponentCubit,
                        ToolbarComponentState>(
                      builder: (context, stateToolbar) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          height: stateToolbar.shapeIsOpen ? height * 0.110 : 0,
                          color: toolbarBackgroundShapeColor,
                          width: width,
                          child: CustomScrollView(
                            controller: _scrollControllerToolbar,
                            scrollDirection: Axis.horizontal,
                            slivers: [
                              SliverAppBar(
                                backgroundColor: Colors.amberAccent,
                                pinned: true,
                                floating: true,
                                collapsedHeight: 45,
                                toolbarHeight: 20,
                                flexibleSpace: FlexibleSpaceBar(
                                  title: IconButton(
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      BlocProvider.of<ToolbarComponentCubit>(
                                              context)
                                          .shapeVisibility(false);
                                    },
                                  ),
                                  centerTitle: true,
                                ),
                              ),
                              ShapesToolbarWidget(
                                scrollController: _scrollControllerScreen,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Positioned.fill(
            //   child: Stack(
            //     alignment: Alignment.bottomLeft,
            //     children: [
            //       Container(
            //         height: height * 0.110,
            //         color: Colors.amber,
            //       ),
            //       Positioned(
            //         left: 0,
            //         bottom: 0,
            //         child: Draggable(
            //           maxSimultaneousDrags: 1,
            //           feedback: Container(
            //             width: Geometry.createCircle().radius * 12,
            //             height: Geometry.createCircle().radius * 12,
            //             decoration: BoxDecoration(
            //               shape: BoxShape.circle,
            //               border: Border.all(color: Colors.black, width: 2),
            //             ),
            //           ),
            //           onDragEnd: (details) {
            //             updatePosition(
            //               Offset(
            //                 details.offset.dx,
            //                 details.offset.dy + _scrollController.offset,
            //               ),
            //               uniqueId: true,
            //               idPosition: idPositionsCircle,
            //               shape: 'circle',
            //             );
            //           },
            //           childWhenDragging: Opacity(
            //             opacity: .3,
            //             child: Padding(
            //               padding: const EdgeInsets.all(8.0),
            //               child: Container(
            //                 width: Geometry.createCircle().radius * 12,
            //                 height: Geometry.createCircle().radius * 12,
            //                 decoration: BoxDecoration(
            //                   shape: BoxShape.circle,
            //                   border: Border.all(color: Colors.black, width: 2),
            //                 ),
            //               ),
            //             ),
            //           ),
            //           child: SingleChildScrollView(
            //             scrollDirection: Axis.vertical,
            //             // controller: scrollController,
            //             child: Padding(
            //               padding: const EdgeInsets.all(8.0),
            //               child: Container(
            //                 width: Geometry.createCircle().radius * 12,
            //                 height: Geometry.createCircle().radius * 12,
            //                 decoration: BoxDecoration(
            //                   shape: BoxShape.circle,
            //                   border: Border.all(color: Colors.black, width: 2),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

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
