import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'form_event.dart';

class FormBloc extends Bloc<FormEvent, bool> {
  FormBloc() : super(true) {
    on<ObscureTextInitialEvent>((event, emit) {
      emit(event._isObscure);
    });

    //while choice chip switch is onPressed
    on<ObscureTextSwitchEvent>((event, emit) {
      emit(event._isObscure);
    });
  }
}
