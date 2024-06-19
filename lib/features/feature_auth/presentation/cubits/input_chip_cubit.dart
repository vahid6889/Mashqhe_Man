import 'package:bloc/bloc.dart';

class InputChipCubit extends Cubit<int> {
  InputChipCubit() : super(-1);

  //while input chip switch is onPressed
  void inputChipSwitch(int chipIndex) => emit(chipIndex);
}
