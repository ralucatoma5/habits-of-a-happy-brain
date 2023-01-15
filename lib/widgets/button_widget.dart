import 'package:flutter/material.dart';
import 'package:habits/const.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Function onPressed;
  ButtonWidget({Key? key, required this.text, required this.onPressed})
      : super(key: key);
  final verticalBlock = SizeConfig.safeBlockVertical!;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => onPressed,
        child: Text(text, style: TextStyle(fontSize: verticalBlock * 2)));
  }
}
