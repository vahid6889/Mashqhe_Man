import 'dart:async';
import 'package:bloc/bloc.dart';

class ResendTimeOtpCubit extends Cubit<int> {
  Timer? countDownTime;

  ResendTimeOtpCubit()
      : super(
          0,
        );

  void startTimer() {
    countDownTime?.cancel();
    emit(0);
    countDownTime = Timer.periodic(const Duration(seconds: 1), (timer) {
      emit(state - 1);
      if (state < 1) {
        countDownTime?.cancel();
      }
    });
  }

  void dispose() {
    countDownTime?.cancel();
  }
}
