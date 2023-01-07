import 'package:fashion_store/models/category_model.dart';

class ProductModel{
  int? id;
  String? title;
  int? price;
  String? description;
  List? images;
  CategoryModel? category;

  ProductModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    images = json['images'];
    category = json['category'] != null ? CategoryModel.fromJson(json['category']) : null;
  }

}
