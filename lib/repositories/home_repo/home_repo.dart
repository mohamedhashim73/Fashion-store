abstract class HomeRepository
{
  // get all categories
  Future<List<dynamic>> getCategories();

  // get all products to show on Home Screen
  Future<List<dynamic>> getAllProducts({required int limits,required int offset});

  // will return list of productModels
  Future<List<dynamic>> getProductsForSpecificCategory({required int limits,required int offset,required int categoryId});
}