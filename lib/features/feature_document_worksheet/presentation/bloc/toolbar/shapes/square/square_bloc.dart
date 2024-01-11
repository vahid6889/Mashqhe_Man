import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'square_event.dart';
part 'square_state.dart';

class SquareBloc extends Bloc<SquareEvent, SquareState> {
  SquareBloc() : super(SquareInitial()) {
    on<SquareEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
