// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mashgh/core/data/entities/shape_entity.dart';
import 'package:mashgh/core/params/shape_params.dart';
import 'package:mashgh/core/usecase/use_case.dart';
import 'package:mashgh/core/utils/constants.dart';
import 'package:mashgh/features/feature_document_worksheet/presentation/bloc/toolbar/shapes/circle/circle_bloc.dart';
import 'package:mashgh/features/feature_document_worksheet/presentation/bloc/toolbar/shapes/circle/get_all_circle_status.dart';
import 'package:mashgh/features/feature_document_worksheet/presentation/bloc/toolbar/shapes/circle/save_circle_worksheet_status.dart';
import 'package:mashgh/features/feature_document_worksheet/presentation/components/circles_component.dart';

class ShapesWorksheetWidget extends StatelessWidget {
  // final TextEditingController textWorksheetController;
  final ScrollController scrollController;
  final int maxLinesInTextField;
  final int heightLineInTextField;
  const ShapesWorksheetWidget({
    super.key,
    // required this.textWorksheetController,
    required this.scrollController,
    required this.maxLinesInTextField,
    required this.heightLineInTextField,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          BlocConsumer<CircleBloc, CircleState>(
            listenWhen: (previous, current) {
              if (current.saveCircleWorksheetStatus ==
                  previous.saveCircleWorksheetStatus) {
                return false;
              }
              return true;
            },
            listener: (context, state) {
              if (state.saveCircleWorksheetStatus
                  is SaveCircleWorksheetCompleted) {
                NoParams noParams = NoParams();
                BlocProvider.of<CircleBloc>(context)
                    .add(SaveCircleWorksheetInitialEvent(noParams));
                ShapeParams shapeParams = ShapeParams(
                  type: ShapesType.circle.name,
                  worksheetUniqueId: null,
                );
                BlocProvider.of<CircleBloc>(context)
                    .add(GetAllCircleEvent(shapeParams));
              }
            },
            buildWhen: (previous, current) {
              if (current.getAllCircleStatus == previous.getAllCircleStatus) {
                return false;
              }
              return true;
            },
            builder: (context, state) {
              if (state.getAllCircleStatus is GetAllCircleCompleted) {
                /// cast data
                final GetAllCircleCompleted _getAllCircleCompleted =
                    state.getAllCircleStatus as GetAllCircleCompleted;

                final List<ShapeEntity?> _shapeEntity =
                    _getAllCircleCompleted.shapeEntity;

                for (var shapeEntity in _shapeEntity) {
                  BlocProvider.of<CircleBloc>(context)
                      .positionsCircle[shapeEntity!.uniqueId!] = {
                    'worksheetUniqueId': shapeEntity.uniqueId!,
                    'content': '',
                    'type': ShapesType.circle.name,
                    'xPosition': shapeEntity.xPosition!,
                    'yPosition': shapeEntity.yPosition!,
                  };
                }
                return CirclesComponent(
                  positionsCircle:
                      BlocProvider.of<CircleBloc>(context).positionsCircle,
                  // textWorksheetController: textWorksheetController,
                  scrollController: scrollController,
                  maxLinesInTextField: maxLinesInTextField,
                  heightLineInTextField: heightLineInTextField,
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
