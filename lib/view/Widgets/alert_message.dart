import 'package:flutter/material.dart';

SnackBar alertMessage({required String message,required Color messageColor,double height = 150}){
  return SnackBar(
      content: Container(
        height:height,
        width:double.infinity,
        alignment: Alignment.center,
        color: Colors.grey.withOpacity(0.5),
        child: Text(message,style: TextStyle(color: messageColor,fontWeight: FontWeight.bold),),
      ));
}