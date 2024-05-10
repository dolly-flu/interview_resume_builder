// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


Widget assetSvdImageWidget({
  String? image,
  double? width,
  double? height,
  BoxFit? fit,
  final ColorFilter? colorFilter,
  Clip clipBehavior = Clip.hardEdge,
}) =>
    SvgPicture.asset(
      image!,
      fit: fit ?? BoxFit.contain,
      height: height,
      width: width,
      colorFilter: colorFilter,
      clipBehavior: clipBehavior,
    );
