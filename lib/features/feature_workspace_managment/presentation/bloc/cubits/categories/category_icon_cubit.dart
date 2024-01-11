import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class ChangeCategoryIconCubit extends Cubit<IconData> {
  int? selectedIcon;
  bool isChangeIcon = false;
  ChangeCategoryIconCubit()
      : super(
          const IconData(
            63668,
            fontFamily: 'MaterialIcons',
          ),
        );

  changeCategoryIcon(newIcon) {
    selectedIcon = newIcon.codePoint;
    emit(newIcon);
  }
}
