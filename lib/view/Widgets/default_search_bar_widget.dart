import 'package:flutter/material.dart';
import 'default_buttons_widget.dart';

Widget searchBarItem({required TextEditingController controller,required dynamic onChanged,double height = 45,double? width,EdgeInsetsGeometry? margin}){
  return Container(
    margin: margin,
    height: height,
    width: width,
    child: defaultTextFormField(
        controller: controller,
        prefixIcon: const Icon(Icons.search),
        hint: "search",
        hintStyle: const TextStyle(fontSize: 16),
        contentPadding: const EdgeInsets.symmetric(vertical: 5),
        onChanged: onChanged,
        suffixIcon: const Icon(Icons.clear,size: 22.5,),
        inputBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Colors.white),
        )
    ),
  );
}