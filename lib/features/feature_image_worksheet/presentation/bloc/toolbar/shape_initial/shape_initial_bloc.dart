import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'shape_initial_event.dart';
part 'shape_initial_state.dart';

class ShapeInitialBloc extends Bloc<ShapeInitialEvent, ShapeInitialState> {
  ShapeInitialBloc() : super(ShapeInitialInitial()) {
    on<ShapeInitialEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
