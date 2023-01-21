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

// healthy habits screen
int topPosition(int index) {
  if (index == 0)
    return -10;
  else if (index == 1)
    return 3;
  else if (index == 3)
    return 0;
  else
    return 15;
}

int leftPosition(int index) {
  if (index == 0)
    return -10;
  else if (index == 1)
    return 20;
  else if (index == 3)
    return 20;
  else
    return -10;
}

int circleHeight(int index) {
  if (index == 0)
    return 30;
  else if (index == 1)
    return 17;
  else if (index == 3)
    return 15;
  else
    return 35;
}

Color circleColor(int index) {
  if (index == 0)
    return Color(0xff3C3EFC);
  else if (index == 1)
    return Color(0xffD93695);
  else if (index == 3)
    return Color(0xff9C34FC);
  else
    return Color(0xffFB7706);
}

TextStyle readingText = TextStyle(
    fontSize: SizeConfig.safeBlockVertical! * 2.7,
    height: 1.4,
    fontWeight: FontWeight.w600);

List<String> img = [
  'assets/images/dopamine.png',
  'assets/images/endorphin.png',
  'assets/images/oxytocin.png',
  'assets/images/serotonin.png'
];
List<String> name = ['dopamine', 'endorphin', 'oxytocin', 'serotonin'];

const Color pink = Color(0xffE94297);

const Color blue2 = Color.fromARGB(255, 10, 136, 214);
LinearGradient gradientBluePink = const LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      blue2,
      pink,
    ]);

LinearGradient gradientPinkBlue = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      pink,
      blue,
    ]);
LinearGradient gradientBright = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      blue,
      pink,
    ]);

const BoxShadow buttonShadow = BoxShadow(
  color: Color.fromARGB(255, 223, 223, 223),
  blurRadius: 10,
  spreadRadius: 2.0,
  offset: Offset(4, 4),
);
