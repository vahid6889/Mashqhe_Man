import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.fromHex('#177FB0');
  static Color black = HexColor.fromHex('#000000');
  static Color lightBlack1 = HexColor.fromHex('#262626');
  static Color lightPurple = HexColor.fromHex('#BE8DEA');
  static Color grey = HexColor.fromHex('#737477');
  static Color darkGrey = HexColor.fromHex('#525252');
  static Color lightGrey = HexColor.fromHex('#525252');
  static Color white = HexColor.fromHex('#FFFFFF');
  static Color darkWhite1 = HexColor.fromHex('##FFF7EF');
  static Color darkWhite2 = HexColor.fromHex('##E1D9D1');
  static Color darkWhite3 = HexColor.fromHex('##DBDBDB');
  static Color darkWhite4 = HexColor.fromHex('##F5EDE5');
  static Color darkWhite5 = HexColor.fromHex('##EBE3DB');
  static Color error = HexColor.fromHex('#e61f34'); // red color
  static Color lightBlue1 = HexColor.fromHex('##4d88ff');
  static Color redAccent = HexColor.fromHex('##FF5252');
  static Color darkRed = HexColor.fromHex('##F12A00');
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = 'FF$hexColorString'; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
