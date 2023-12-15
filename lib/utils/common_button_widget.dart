import 'package:edraak/utils/color_picker.dart';
import 'package:edraak/utils/textstyler_helper.dart';
import 'package:flutter/material.dart';

class CommonButton {
  Widget bRoundBorderPrimaryBlueButton(BuildContext context,
      {String title = '', VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorPicker.kPrimaryBlue,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyleHelper.kWhiteW600,
          ),
        ),
      ),
    );
  }

  Widget bSquareRoundBorderPrimaryBlueButton(BuildContext context,
      {String title = '', VoidCallback? onTap, double height = 50}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorPicker.kPrimaryBlue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyleHelper.kWhiteW600,
          ),
        ),
      ),
    );
  }
}
