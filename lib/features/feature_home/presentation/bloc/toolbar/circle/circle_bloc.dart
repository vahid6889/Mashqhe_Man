import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'circle_event.dart';
part 'circle_state.dart';

class CircleBloc extends Bloc<CircleEvent, CircleState> {
  CircleBloc() : super(CircleInitial()) {
    on<CircleEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
