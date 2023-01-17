import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:fashion_store/models/category_model.dart';
import 'package:fashion_store/models/product_model.dart';
import 'package:fashion_store/repositories/home_repo/home_repo.dart';
import 'package:flutter/cupertino.dart';

/// responsible for connecting with server, to provide the response for business logic
class HomeNetworkRepository extends HomeRepository{
  List<dynamic> categories = [];
  List<dynamic> products = [];
  List<dynamic> productsForSpecificCategory = [];

  @override
  Future<List<dynamic>> getCategories() async {
    Response response = await Dio().get("https://api.escuelajs.co/api/v1/categories?limit=10");
    // debugPrint("response is ${response.data}");
    categories = response.data.map((item)=> CategoryModel.fromJson(item)).toList();
    return categories;
  }


  @override
  // this method for getting all products to show on HomeScreen ( take limits as on home will show for example 20 products but there is another screen will have all products )
  Future<List<dynamic>> getAllProducts({required int limits,required int offset}) async {
    Response response = await Dio().get(
      'https://api.escuelajs.co/api/v1/products',
      queryParameters:
      {
        "limit" : limits,
        "offset" : offset,
      }
    );
    // transform json that come from api to a specific form ( model ) => ProductModel
    products = await response.data.map((item)=> ProductModel.fromJson(item)).toList();
    return products;
  }

  @override   /// get products depend on the id for category
  Future<List<dynamic>> getProductsForSpecificCategory({required int limits, required int offset, required int categoryId}) async {
    try {
      Response response = await Dio().get(
          'https://api.escuelajs.co/api/v1/categories/$categoryId/products',
          queryParameters:
          {
            'limits' : limits,
            'offset' : offset,
            'id' : categoryId,
          }
      );
      /// transforming from json to productModel
      productsForSpecificCategory = response.data.map((product) => ProductModel.fromJson(product)).toList();
    }
    catch(exception)
    {
      debugPrint("Error during connect with server to get products for specific category $exception") ;
    }
    return productsForSpecificCategory;
  }

}