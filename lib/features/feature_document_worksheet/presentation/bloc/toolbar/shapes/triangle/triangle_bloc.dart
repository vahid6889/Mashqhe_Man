import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'triangle_event.dart';
part 'triangle_state.dart';

class TriangleBloc extends Bloc<TriangleEvent, TriangleState> {
  TriangleBloc() : super(TriangleInitial()) {
    on<TriangleEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
