import 'package:fashion_store/models/product_model.dart';
import 'package:fashion_store/repositories/favorites_orders_repo/favorites_orders_repo.dart';

class FavoritesAndOrdersCacheRepository extends FavoritesAndOrdersRepository{
  @override
  Future<void> addProductToFavorite({required int userID, required ProductModel model}) {
    // TODO: implement addProductToFavorite
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProductFromFavorites({required int userID, required int productID}) {
    // TODO: implement deleteProductFromFavorites
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> getFavorites({required int userID}) {
    // TODO: implement getFavorites
    throw UnimplementedError();
  }

  @override
  Map<int, bool> getFavoritesStatus() {
    // TODO: implement getFavoritesStatus
    throw UnimplementedError();
  }

}