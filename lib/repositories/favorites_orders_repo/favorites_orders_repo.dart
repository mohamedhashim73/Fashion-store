import '../../models/product_model.dart';

abstract class FavoritesAndOrdersRepository{
  // add product to favorite using FireStore
  Future<void> addProductToFavorite({required int userID,required ProductModel model});

  // remove product from favorite using FireStore
  Future<void> deleteProductFromFavorites({required int userID,required int productID});

  // get all products that on favorite throw Firebase
  Future<List<ProductModel>> getFavorites({required int userID});
}