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
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        children: [
          Positioned(
              top: -verticalBlock * 14,
              left: -horizontalBlock * 15,
              width: size.width,
              child: Container(
                  height: verticalBlock * 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: gradientBluePink,
                  ))),
          Positioned(
            top: -verticalBlock * 4,
            left: horizontalBlock * 8,
            width: verticalBlock * 41,
            child: Container(
              height: verticalBlock * 41,
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
              left: -horizontalBlock * 1.5,
              width: verticalBlock * 16,
              height: verticalBlock * 16,
              child: Container(
                  decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: gradientPinkBlue,
              ))),
          Positioned(
            top: verticalBlock * 20,
            left: horizontalBlock,
            width: verticalBlock * 7,
            height: verticalBlock * 7,
            child: Container(
                decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: gradientPinkBlue,
            )),
          ),
          Positioned(
            top: verticalBlock * 10,
            left: horizontalBlock * 65,
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
