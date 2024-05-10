// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:resume_builder/utils/colors.dart';
import 'package:resume_builder/utils/text_style.dart';
import 'package:resume_builder/view/widget/common_space_divider_widget.dart';
import 'package:resume_builder/view/widget/icon_and_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CommonButton extends StatelessWidget {
  final String? title;
  final double? height;
  final double? width;
  final double? radius;
  final double? horizontal;
  final double? fontSize;
  final Function()? onPressed;
  final Color? bColor;
  final Color? btnColor;
  final Color? textColor;

  CommonButton({
    super.key,
    this.title,
    this.height,
    this.width,
    this.onPressed,
    this.bColor,
    this.btnColor,
    this.textColor,
    this.fontSize,
    this.horizontal,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? Get.width,
        // height: height ?? Get.height * 0.07,
        height: height ?? 45,
        decoration: BoxDecoration(
            color: btnColor ?? AppColor.themeGreenColor,
            borderRadius: BorderRadius.circular(radius ?? 10),
            border: Border.all(color: bColor ?? AppColor.cTransparent)),
        padding: EdgeInsets.symmetric(horizontal: horizontal ?? Get.width * 0.1),
        child: Center(
          child: Text(
            title!,
            style: pBold14.copyWith(color: textColor ?? AppColor.cWhite, fontSize: fontSize ?? 14),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class CommonIconButton extends StatelessWidget {
  final String? title;
  final String? icon;
  final double? height;
  final double? width;
  final double? horizontal;
  final double? fontSize;
  final double? iconSize;
  final Function()? onPressed;
  final Color? bColor;
  final Color? btnColor;
  final Color? textColor;
  final Color? iconColor;

  CommonIconButton({
    super.key,
    this.title,
    this.height,
    this.width,
    this.onPressed,
    this.bColor,
    this.btnColor,
    this.textColor,
    this.fontSize,
    this.horizontal,
    this.icon,
    this.iconSize,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? Get.width,
        // height: height ?? Get.height * 0.07,
        height: height ?? 45,
        decoration: BoxDecoration(
            color: btnColor ?? AppColor.themeGreenColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: bColor ?? AppColor.cTransparent)),
        padding: EdgeInsets.symmetric(horizontal: horizontal ?? Get.width * 0.1),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              assetSvdImageWidget(
                  image: icon,
                  width: iconSize,
                  height: iconSize,
                  colorFilter: ColorFilter.mode(iconColor ?? AppColor.cWhite, BlendMode.srcIn)),
              horizontalSpace(10),
              Text(
                title!,
                style: pRegular14.copyWith(color: textColor ?? AppColor.cWhite, fontSize: fontSize ?? 14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
