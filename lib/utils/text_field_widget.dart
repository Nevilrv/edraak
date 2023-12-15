import 'package:edraak/utils/color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

TextFormField commonTextField({
  TextEditingController? controller,
  bool prefixIconVisibility = false,
  bool suffixIconVisibility = false,
  IconData? prefixIcon,
  Widget? suffixIcon,
  String? labelText = '',
  String? Function(String?)? validator,
  Function(String)? onChanged,
  TextInputType? textInputType,
  List<TextInputFormatter>? textInputFormatter,
  bool obscureText = false,
}) {
  return TextFormField(
    obscureText: obscureText,
    validator: validator,
    controller: controller,
    onChanged: onChanged,
    decoration: InputDecoration(
      // constraints: BoxConstraints(maxHeight: 60),
      prefixIcon: prefixIconVisibility
          ? Icon(
              prefixIcon,
              color: ColorPicker.kGrey,
            )
          : null,

      suffixIcon: suffixIconVisibility ? suffixIcon : null,

      labelText: labelText,
      labelStyle: TextStyle(color: ColorPicker.kGrey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: ColorPicker.kGrey400,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: ColorPicker.kGrey400,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: ColorPicker.kGrey400,
        ),
      ),
    ),
    keyboardType: textInputType,
    inputFormatters: textInputFormatter,
  );
}
