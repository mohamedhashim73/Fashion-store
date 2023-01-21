import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_store/models/product_model.dart';
import 'package:fashion_store/repositories/favorites_orders_repo/favorites_orders_repo.dart';
import 'package:flutter/cupertino.dart';

class FavoritesAndOrdersNetworkRepository extends FavoritesAndOrdersRepository{
  List<ProductModel> favorites = [];
  Map<int,bool> favoritesStatus = {};

  @override
  Future<void> addProductToFavorite({required int userID,required ProductModel model}) async {
    await FirebaseFirestore.instance.collection('users').doc(userID.toString())
        .collection('favorites').doc(model.id.toString()).set(model.toJson()).then((value){
          debugPrint("Product sent to Favorites on Firestore successfully");
    });
  }

  @override
  Future<void> deleteProductFromFavorites({required int userID,required int productID}) async {
    await FirebaseFirestore.instance.collection('users').doc(userID.toString()).collection('favorites').doc(productID.toString()).delete().then((value){
      debugPrint("Product removed from Favorites successfully");
    });
  }

  @override
  Future<List<ProductModel>> getFavorites({required int userID}) async {
    await FirebaseFirestore.instance.collection('users').doc(userID.toString()).collection('favorites').get().then((value){
      for( var product in value.docs ) // product => map that come from Firestore (( field ))
        {
          favoritesStatus.addAll({int.parse(product.id) : true});               // convert product id to int as product.id is a string value
          favorites.add(ProductModel.fromJson(product.data()));
        }
    });
    return favorites;
  }

  @override
  Map<int,bool> getFavoritesStatus(){
    return favoritesStatus;
  }

}