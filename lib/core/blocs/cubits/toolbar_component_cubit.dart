import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'toolbar_component_state.dart';

class ToolbarComponentCubit extends Cubit<ToolbarComponentState> {
  ToolbarComponentCubit()
      : super(
          ToolbarComponentState(
            shapeIsOpen: false,
            editIsOpen: false,
          ),
        );
  void shapeVisibility(bool value) =>
      emit(state.copyWith(newShapeStatus: value));
  void editVisibility(bool value) => emit(state.copyWith(newEditStatus: value));
}
