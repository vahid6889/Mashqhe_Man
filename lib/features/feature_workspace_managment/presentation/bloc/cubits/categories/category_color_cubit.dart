import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class ChangeCategoryColorCubit extends Cubit<Color> {
  int? selectedColor;
  bool isChangeColor = false;

  ChangeCategoryColorCubit()
      : super(
          Colors.pink,
        );

  void reset() => emit(
        Colors.pink,
      );

  changeCategoryColor(newColor) {
    selectedColor = newColor.value;
    emit(newColor);
  }
}
