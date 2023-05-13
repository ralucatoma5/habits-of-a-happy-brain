import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../const.dart';

class HideBottomNavBar extends StatefulWidget {
  final Widget child;
  final ScrollController controller;
  final Duration duration;
  const HideBottomNavBar(
      {super.key,
      required this.child,
      required this.controller,
      this.duration = const Duration(milliseconds: 200)});

  @override
  State<HideBottomNavBar> createState() => _HideBottomNavBarState();
}

class _HideBottomNavBarState extends State<HideBottomNavBar> {
  bool isVisible = true;
  final verticalBlock = SizeConfig.safeBlockVertical!;
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(listen);
  }

  @override
  void dispose() {
    widget.controller.removeListener(listen);
    super.dispose();
  }

  void listen() {
    final direction = widget.controller.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      show();
    } else if (direction == ScrollDirection.reverse) {
      hide();
    }
  }

  void show() {
    if (!isVisible) setState(() => isVisible = true);
  }

  void hide() {
    if (isVisible) setState(() => isVisible = false);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: widget.duration,
      height: isVisible ? kBottomNavigationBarHeight * 1.5 : 0,
      child: Wrap(children: [widget.child]),
    );
  }
}
