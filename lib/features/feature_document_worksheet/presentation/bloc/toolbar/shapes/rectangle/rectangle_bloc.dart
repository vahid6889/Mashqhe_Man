import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'rectangle_event.dart';
part 'rectangle_state.dart';

class RectangleBloc extends Bloc<RectangleEvent, RectangleState> {
  RectangleBloc() : super(RectangleInitial()) {
    on<RectangleEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
