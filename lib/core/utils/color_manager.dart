import 'package:flutter/material.dart';

class ColorManager {
  /// lights
  static Color lightBlack = HexColor.fromHex('#3E404D');
  static Color lightBlack1 = HexColor.fromHex('#262626');
  static Color lightPurple = HexColor.fromHex('#BE8DEA');
  static Color lightBlue1 = HexColor.fromHex('#4d88ff');
  static Color lightBlue = HexColor.fromHex('#203387');
  static Color lightGrey = HexColor.fromHex('#525252');
  static Color lightYellow = HexColor.fromHex('#FFF9EC');
  static Color lightYellow2 = HexColor.fromHex('#FFE4C7');
  static Color lightYellow3 = HexColor.fromHex('#FFE4C7');
  static Color lightGreen = HexColor.fromHex('#D9E6DC');
  static Color lightOrange = HexColor.fromHex('#fa8e5c');
  static Color lightOrange2 = HexColor.fromHex('#f97d6d');
  static Color lightpurple = HexColor.fromHex('#898edf');
  static Color lightseeBlue = HexColor.fromHex('#b9e6fc');

  /// darks
  static Color darkWhite1 = HexColor.fromHex('#FFF7EF');
  static Color darkWhite2 = HexColor.fromHex('#E1D9D1');
  static Color darkWhite3 = HexColor.fromHex('#DBDBDB');
  static Color darkWhite4 = HexColor.fromHex('#F5EDE5');
  static Color darkWhite5 = HexColor.fromHex('#EBE3DB');
  static Color darkGrey = HexColor.fromHex('#525252');
  static Color darkGreyTwo = HexColor.fromHex('#625f6a');
  static Color darkGreyThree = HexColor.fromHex('#7B7B7B');
  static Color darkRed = HexColor.fromHex('#F12A00');
  static Color darkYellow = HexColor.fromHex('#F9BE7C');
  static Color darkGreen = HexColor.fromHex('#32BC32');
  static Color darkBlue = HexColor.fromHex('#0D253F');
  static Color darkOrange = HexColor.fromHex('#f46352');
  static Color darkpurple = HexColor.fromHex('#7178d3');
  static Color extraDarkPurple = HexColor.fromHex('#494c79');
  static Color darkseeBlue = HexColor.fromHex('#63c4cf');

  static Color black = HexColor.fromHex('#000000');
  static Color white = HexColor.fromHex('#FFFFFF');
  static Color primary = HexColor.fromHex('#177FB0');
  static Color grey = HexColor.fromHex('#737477');
  static Color greyTwo = HexColor.fromHex('#9D99A7');
  static Color error = HexColor.fromHex('#e61f34'); // red color
  static Color redAccent = HexColor.fromHex('#FF5252');
  static Color yellow = HexColor.fromHex('#FFC107');
  static Color yellowTwo = HexColor.fromHex('#fbbd5c');
  static Color orange = HexColor.fromHex('#f96d5b');
  static Color purple = HexColor.fromHex('#7a81dd');
  static Color seeBlue = HexColor.fromHex('#73d4dd');
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
