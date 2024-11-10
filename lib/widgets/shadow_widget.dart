import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../helpers/assets.dart';

class PositionedShadow extends StatelessWidget {
  const PositionedShadow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      top: 0,
      left: 0,
      right: 0,
      child: SvgPicture.asset(ImageSrc.imageShadow),
    );
  }
}