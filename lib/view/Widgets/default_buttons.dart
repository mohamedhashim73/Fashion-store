import 'package:fashion_store/shared/constants/colors.dart';
import 'package:flutter/material.dart';

Widget defaultTextFormField({
  required TextEditingController controller,
  required InputBorder inputBorder,
  String? label,
  String? hint,
  Color? fillColor,
  Widget? prefixIcon,
  int maxLines = 1,
  int? maxLength,
  TextInputType? textInputType,
  Widget? suffixIcon,
  Color? cursorColor,
  dynamic onSavedMethod,
  TextStyle? textStyle,
  dynamic validateMethod,
  dynamic onChanged,
  TextStyle? hintStyle,
  bool obscureText = false,
  EdgeInsetsGeometry? contentPadding}){
  return TextFormField(
    controller: controller,
    obscureText: obscureText,
    keyboardType: textInputType,
    cursorColor: cursorColor,
    maxLength: maxLength,
    validator: validateMethod,
    onSaved: onSavedMethod,
    style: textStyle,
    maxLines: maxLines,
    onChanged: onChanged,
    decoration: InputDecoration(
      border: inputBorder,
      labelText: label,
      hintText: hint,
      hintStyle: hintStyle,
      contentPadding: contentPadding,
      filled: true,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      fillColor: fillColor
    )
  );
}

Widget defaultButton({
  required Function() onTap,
  required Widget content,
  double? height,
  double? elevation,
  Color buttonColor = mainColor,
  Color? splashColor,
  RoundedRectangleBorder? shape,
  double? minWidth,
  Function()? onLongTap,
  EdgeInsetsGeometry? contentPadding}){
  return MaterialButton(
    onPressed: onTap,
    height: height,
    minWidth: minWidth,
    padding: contentPadding,
    color: buttonColor,
    splashColor: splashColor,
    onLongPress: onLongTap,
    elevation: elevation,
    shape: shape,
    child: content
  );
}