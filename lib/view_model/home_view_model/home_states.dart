abstract class HomeStates{}

class HomeInitialState extends HomeStates{}

class GetCategoryLoadedState extends HomeStates{}

class GetCategorySuccessState extends HomeStates{}

class GetCategoryErrorState extends HomeStates{}

class GetProductsLoadedState extends HomeStates{}

class GetProductsSuccessState extends HomeStates{}

class GetProductsErrorState extends HomeStates{}

class GetProductsForSpecificCategoryLoadedState extends HomeStates{}

class GetProductsForSpecificCategorySuccessState extends HomeStates{}

class GetProductsForSpecificCategoryErrorState extends HomeStates{}

/// related to product details screen
class ChooseProductColorSuccessState extends HomeStates{}

class ChooseProductQuantitySuccessState extends HomeStates{}

class GoToNextPageViewSuccessState extends HomeStates{}
