import 'package:flutter/material.dart';
import 'package:mashgh/core/utils/color_manager.dart';
import 'package:toastification/toastification.dart';

class ToastificationMood {
  static void showToast({
    required BuildContext context,
    required String typeToast,
    required String titleToast,
    required String descriptionToast,
    bool applyBlurEffect = true,
  }) {
    ToastificationType whichTypeToast(String typeToast) {
      switch (typeToast) {
        case 'success':
          return ToastificationType.success;
        case 'info':
          return ToastificationType.info;
        case 'warning':
          return ToastificationType.warning;
        case 'error':
          return ToastificationType.error;
        default:
          return ToastificationType.success;
      }
    }

    Color colorDescriptionToast(String typeToast) {
      switch (typeToast) {
        case 'success':
          return ColorManager.darkGreen;
        case 'info':
          return ColorManager.seeBlue;
        case 'warning':
          return ColorManager.yellow;
        case 'error':
          return ColorManager.redAccent;
        default:
          return ColorManager.darkGreen;
      }
    }

    toastification.show(
      context: context,
      type: whichTypeToast(typeToast),
      style: ToastificationStyle.flat,
      title: Text(
        titleToast,
        style: TextStyle(
          color: ColorManager.black,
          fontSize: 12,
        ),
      ),
      description: Text(
        descriptionToast,
        style: TextStyle(
          color: colorDescriptionToast(typeToast),
          fontSize: 14,
        ),
      ),
      alignment: Alignment.topCenter,
      autoCloseDuration: const Duration(
        seconds: 6,
        milliseconds: 600,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: highModeShadow,
      showProgressBar: true,
      direction: TextDirection.rtl,
      dragToClose: true,
      applyBlurEffect: applyBlurEffect,
    );
  }
}
