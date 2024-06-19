import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mashgh/core/params/shape_params.dart';
import 'package:mashgh/core/usecase/use_case.dart';
import 'package:mashgh/core/utils/constants.dart';
import 'package:mashgh/core/utils/geometry/geometry.dart';
import 'package:mashgh/features/feature_document_worksheet/presentation/bloc/toolbar/shapes/circle/circle_bloc.dart';
import 'package:mashgh/features/feature_document_worksheet/presentation/bloc/toolbar/shapes/circle/save_circle_toolbar_status.dart';
import 'package:uuid/uuid.dart';

class ShapesToolbarWidget extends StatelessWidget {
  const ShapesToolbarWidget({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BlocConsumer<CircleBloc, CircleState>(
            key: const ValueKey('Toolbar_Saved_Shape'),
            buildWhen: (previous, current) {
              if (current.saveCircleToolbarStatus ==
                  previous.saveCircleToolbarStatus) {
                return false;
              }
              return true;
            },
            listenWhen: (previous, current) {
              if (current.saveCircleToolbarStatus ==
                  previous.saveCircleToolbarStatus) {
                return false;
              }
              return true;
            },
            listener: (context, state) {
              if (state.saveCircleToolbarStatus is SaveCircleToolbarCompleted) {
                NoParams noParams = NoParams();
                BlocProvider.of<CircleBloc>(context)
                    .add(SaveCircleToolbarInitialEvent(noParams));
                ShapeParams shapeParams = ShapeParams(
                  type: ShapesType.circle.name,
                  worksheetUniqueId: null,
                );
                BlocProvider.of<CircleBloc>(context)
                    .add(GetAllCircleEvent(shapeParams));
              }
              if (state.saveCircleToolbarStatus is SaveCircleToolbarError) {
                /// cast for getting Error
                final SaveCircleToolbarError saveCircleError =
                    state.saveCircleToolbarStatus as SaveCircleToolbarError;

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(saveCircleError.message!),
                    behavior: SnackBarBehavior.floating, // Add this line
                  ),
                );
              }
            },
            builder: (context, state) {
              return Draggable(
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
                  String uniqueId = const Uuid().v4();

                  /// call save circle event

                  /// 36.0 pixels for the yPosition related to the ScrollController of the page is reduced due to the toolbox placed in the appbar at the top of the page

                  ShapeParams shapeParams = ShapeParams(
                    uniqueId: uniqueId,
                    worksheetUniqueId: null,
                    content: '',
                    type: ShapesType.circle.name,
                    xPosition: details.offset.dx,
                    yPosition:
                        details.offset.dy + scrollController.offset - 36.0,
                  );
                  // Offset newPosition = Offset(
                  //   details.offset.dx,
                  //   details.offset.dy + scrollController.offset,
                  // );

                  BlocProvider.of<CircleBloc>(context)
                      .positionsCircle[uniqueId] = {
                    'worksheetUniqueId': null,
                    'content': '',
                    'type': ShapesType.circle.name,
                    'xPosition': details.offset.dx,
                    'yPosition':
                        details.offset.dy + scrollController.offset - 36.0,
                  };
                  BlocProvider.of<CircleBloc>(context)
                      .add(SaveCirlceToolbarEvent(shapeParams));
                  // if (uniqueId == true) {
                  //   idPositionsCircle = const Uuid().v4();
                  //   positionsCircle[idPositionsCircle] = const Offset(0, 0);
                  // }
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
              );
            },
          ),
          Draggable(
            maxSimultaneousDrags: 1,
            feedback: Container(
              width: Geometry.createRect().width * 2.5,
              height: Geometry.createRect().height * 1.4,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black, width: 2),
              ),
            ),
            onDragEnd: (details) {
              // updatePosition(
              //   Offset(
              //     details.offset.dx,
              //     details.offset.dy + widget.scrollController.offset,
              //   ),
              //   uniqueId: true,
              //   idPosition: idPositionsCircle,
              //   shape: 'circle',
              // );
            },
            childWhenDragging: Opacity(
              opacity: .3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: Geometry.createRect().width * 2.5,
                  height: Geometry.createRect().height * 1.4,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
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
                  width: Geometry.createRect().width * 2.5,
                  height: Geometry.createRect().height * 1.4,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
