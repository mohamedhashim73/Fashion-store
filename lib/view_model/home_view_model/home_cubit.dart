import 'package:fashion_store/repositories/home_repo/home_repo.dart';
import 'package:fashion_store/view_model/favorites_orders_view_model/favorites_orders_cubit.dart';
import 'package:fashion_store/view_model/home_view_model/home_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates>{
  late HomeRepository homeRepository;
  HomeCubit({required this.homeRepository}) : super(HomeInitialState());
  static HomeCubit getInstance({required BuildContext context}) => BlocProvider.of(context);     // Todo: to make an instance from this Cubit

  List<dynamic> categories = [];
  List<dynamic> products = [];
  List<dynamic> productsForSpecificCategory = [];

  // Todo: get categories data to show on HomeView and on an individual screen
  Future<List<dynamic>> getCategories() async {
    emit(GetCategoryLoadedState());
    await homeRepository.getCategories().then((value){
      categories = value;
      emit(GetCategorySuccessState());
    }).catchError((e){
      debugPrint("Error during get category from home_cubit $e");
      emit(GetCategoryErrorState());
    });
    return categories;
  }

  // Todo: offset for example offset = 25 he will bring products that its ID start from 35 as he increase 10 for offset value
  Future<List<dynamic>> getAllProducts({required int limits,required int offset,required BuildContext context}) async {
    emit(GetProductsLoadedState());
    await homeRepository.getAllProducts(limits: limits, offset: offset).then((value) async {
      products = value ;
      // Todo: getFavorites to display the status of each product on HomeScreen
      await FavoritesAndOrdersCubit.getInstance(context).getFavorites();     // Todo: لو معملتش await هيعمل refresh for home screen قبل اما يجيب favorites عشان كده حطت await
      emit(GetProductsSuccessState());
    }).catchError((e){
      debugPrint("Error during get products from home_cubit $e");
      emit(GetProductsErrorState());
    });
    return products;
  }

  // Todo: get all products but for specific category depended on its ID
  Future<List> getProductsForSpecificCategory({required int limits, required int offset, required int categoryId}) async {
    emit(GetProductsForSpecificCategoryLoadedState());
    // لازم استعمل await عشان ميروحش يرجع list قبل اما يجيب الداتا بالكامل
    await homeRepository.getProductsForSpecificCategory(limits: limits, offset: offset, categoryId: categoryId).then((value){
      productsForSpecificCategory = value;
      emit(GetProductsForSpecificCategorySuccessState());
    }).catchError((error){
      debugPrint("Error during get products from specific category from cubit file $error");
      emit(GetProductsForSpecificCategoryErrorState());
    });
    return productsForSpecificCategory;
  }

  // Todo: related to product details screen
  int productQuantity = 1 ;
  void increaseQuantity(){
    productQuantity++;
    emit(ChooseProductQuantitySuccessState());
  }

  void decreaseQuantity(){
    if( productQuantity > 1 )  // عشان اقل قيمه هي ان المستخدم هيأخد كميه واحده من المنتج
    {
      productQuantity--;
    }
    emit(ChooseProductQuantitySuccessState());
  }

}