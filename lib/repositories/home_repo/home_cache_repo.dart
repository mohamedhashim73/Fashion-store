import 'package:fashion_store/models/category_model.dart';
import 'package:fashion_store/repositories/home_repo/home_repo.dart';

class HomeCacheRepository extends HomeRepository {
  @override
  Future<List<CategoryModel>> getCategories() {
    // TODO: implement getCategories
    throw UnimplementedError();
  }

  @override
  Future<List<dynamic>> getAllProducts({required int limits, required int offset}) {
    // TODO: implement getAllProducts
    throw UnimplementedError();
  }

  @override
  Future<List> getProductsForSpecificCategory({required int limits, required int offset, required int categoryId}) {
    // TODO: implement getProductsForSpecificCategory
    throw UnimplementedError();
  }

}