import 'package:flutter/material.dart';

import '../const.dart';

Positioned positionedButton(BuildContext context) {
  return Positioned(
      top: SizeConfig.safeBlockVertical! * 6.5,
      left: SizeConfig.safeBlockHorizontal! * 5,
      child: IconButton(
        icon: Icon(
          Icons.adaptive.arrow_back,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ));
}
