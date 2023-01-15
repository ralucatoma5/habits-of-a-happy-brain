import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

import '../const.dart';

class BackgroundSignUp extends StatelessWidget {
  const BackgroundSignUp({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        children: [
          Positioned(
            top: -100,
            right: -150,
            width: size.width,
            child: Container(
              height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: pink, width: 1),
              ),
            ),
          ),
          child
        ],
      ),
    );
  }
}
