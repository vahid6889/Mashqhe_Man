part of 'form_bloc.dart';

@immutable
abstract class FormEvent extends Equatable {}

class ObscureTextInitialEvent extends FormEvent {
  final bool _isObscure = true;
  @override
  List<Object?> get props => [_isObscure];
}

class ObscureTextSwitchEvent extends FormEvent {
  final bool _isObscure;

  ObscureTextSwitchEvent(this._isObscure);
  @override
  List<Object?> get props => [_isObscure];
}
