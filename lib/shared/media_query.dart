import 'package:flutter/cupertino.dart';

class MediaQueryModel{
  
  // Todo: make the method static to be accessed without making an instance from this class only by calling class name
  static double setWidth({required BuildContext context,required double widthRatio}){
    return MediaQuery.of(context).size.width*widthRatio;
  }

  static double setHeight({required BuildContext context,required double heightRatio}){
    return MediaQuery.of(context).size.width*heightRatio;
  }
}