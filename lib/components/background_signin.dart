import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

import '../const.dart';

class BackgroundSignIn extends StatelessWidget {
  const BackgroundSignIn({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final verticalBlock = SizeConfig.safeBlockVertical!;
    final horizontalBlock = SizeConfig.safeBlockHorizontal!;
    return SizedBox(
      width: double.infinity,
      height: size.height,
      child: Stack(
        children: [
          Positioned(
              top: -verticalBlock * 16,
              left: -verticalBlock * 5,
              width: verticalBlock * 57,
              child: Container(
                  height: verticalBlock * 57,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: gradientBluePink,
                  ))),
          Positioned(
            top: -verticalBlock * 8,
            left: verticalBlock * 7,
            width: verticalBlock * 46,
            child: Container(
              height: verticalBlock * 47,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: GradientBoxBorder(
                  gradient: gradientBright,
                  width: 3,
                ),
              ),
            ),
          ),
          Positioned(
              top: -verticalBlock * 2,
              left: -verticalBlock * 2,
              width: verticalBlock * 16,
              height: verticalBlock * 16,
              child: Container(
                  decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: gradientPinkBlue,
              ))),
          Positioned(
            top: verticalBlock * 20,
            left: verticalBlock * 4,
            width: verticalBlock * 7,
            height: verticalBlock * 7,
            child: Container(
                decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: gradientPinkBlue,
            )),
          ),
          Positioned(
            top: verticalBlock * 5,
            left: horizontalBlock * 66,
            width: verticalBlock * 5,
            height: verticalBlock * 5,
            child: Container(
                decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: gradientPinkBlue,
            )),
          ),
          child
        ],
      ),
    );
  }
}
