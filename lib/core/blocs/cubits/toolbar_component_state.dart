part of 'toolbar_component_cubit.dart';

class ToolbarComponentState {
  bool shapeIsOpen;
  bool editIsOpen;

  ToolbarComponentState({required this.shapeIsOpen, required this.editIsOpen});

  ToolbarComponentState copyWith({
    bool? newShapeStatus,
    bool? newEditStatus,
  }) {
    return ToolbarComponentState(
      shapeIsOpen: newShapeStatus ?? shapeIsOpen,
      editIsOpen: newEditStatus ?? editIsOpen,
    );
  }
}
