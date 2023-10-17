import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'diamond_event.dart';
part 'diamond_state.dart';

class DiamondBloc extends Bloc<DiamondEvent, DiamondState> {
  DiamondBloc() : super(DiamondInitial()) {
    on<DiamondEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
