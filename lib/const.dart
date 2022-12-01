import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

BoxShadow containerShadow = BoxShadow(
  color: Colors.grey.withOpacity(0.5),
  spreadRadius: 1,
  blurRadius: 3,
  offset: const Offset(0, 3),
);
Color blue = const Color(0xff005489);

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;

  static double? _safeAreaHorizontal;
  static double? _safeAreaVertical;
  static double? safeBlockHorizontal;
  static double? safeBlockVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData?.size.width;
    screenHeight = _mediaQueryData?.size.height;
    blockSizeHorizontal = (screenWidth! / 100);
    blockSizeVertical = (screenHeight! / 100);

    _safeAreaHorizontal =
        _mediaQueryData!.padding.left + _mediaQueryData!.padding.right;
    _safeAreaVertical =
        _mediaQueryData!.padding.top + _mediaQueryData!.padding.bottom;
    safeBlockHorizontal = (screenWidth! - _safeAreaHorizontal!) / 100;
    safeBlockVertical = (screenHeight! - _safeAreaVertical!) / 100;
  }
}

TextStyle readingText = TextStyle(
    fontSize: SizeConfig.safeBlockVertical! * 2.7,
    letterSpacing: 0.1,
    height: 1.4,
    fontWeight: FontWeight.w600);
List<String> img = [
  'assets/images/dopamine.png',
  'assets/images/endorphin.png',
  'assets/images/oxytocin.png',
  'assets/images/serotonin.png'
];
List<String> name = ['dopamine', 'endorphin', 'oxytocin', 'serotonin'];
