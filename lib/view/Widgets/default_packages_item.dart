import 'package:carousel_slider/carousel_slider.dart';
import 'package:fashion_store/models/product_model.dart';
import 'package:flutter/material.dart';

// Todo: used on display product details
Widget buildCarouselSliderItem({required ProductModel productModel}){
  return CarouselSlider(
      items: productModel.images!.map((e){
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0)),
          child: Image.network(e,width: double.infinity,fit: BoxFit.cover,height: double.infinity,),
        );
      }).toList(),
      options: CarouselOptions(
        height: 180,
        aspectRatio: 16/9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 2),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      )
  );
}