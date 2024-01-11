import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mashgh/core/blocs/cubits/toolbar_component_cubit.dart';
import 'package:mashgh/core/utils/color_manager.dart';

class ToolbarComponent extends StatelessWidget {
  const ToolbarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BlocBuilder<ToolbarComponentCubit, ToolbarComponentState>(
          builder: (context, visibleStatus) {
            return Visibility(
              visible: visibleStatus.shapeIsOpen ? false : true,
              child: SizedBox(
                height: 40.0,
                width: 40.0,
                child: Material(
                  color: Colors.transparent,
                  child: IconButton(
                    padding: const EdgeInsets.all(0.0),
                    color: ColorManager.black,
                    icon: const Icon(
                      Icons.format_shapes_outlined,
                      size: 40.0,
                    ),
                    onPressed: () {
                      BlocProvider.of<ToolbarComponentCubit>(context)
                          .shapeVisibility(true);
                    },
                  ),
                ),
              ),
            );
          },
        ),
        BlocBuilder<ToolbarComponentCubit, ToolbarComponentState>(
          builder: (context, visibleStatus) {
            return Visibility(
              visible: visibleStatus.editIsOpen ? false : true,
              child: SizedBox(
                height: 40.0,
                width: 40.0,
                child: Material(
                  color: Colors.transparent,
                  child: IconButton(
                    padding: const EdgeInsets.all(0.0),
                    color: ColorManager.black,
                    icon: const Icon(
                      Icons.edit_document,
                      size: 40.0,
                    ),
                    onPressed: () {
                      BlocProvider.of<ToolbarComponentCubit>(context)
                          .editVisibility(true);
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
