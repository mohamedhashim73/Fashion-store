import 'package:fashion_store/models/product_model.dart';
import 'package:fashion_store/repositories/favorites_orders_repo/favorites_orders_repo.dart';
import 'package:fashion_store/shared/constants/constants.dart';
import 'package:fashion_store/view_model/favorites_orders_view_model/favorites_orders_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesAndOrdersCubit extends Cubit<FavoritesAndOrdersStates>{
  late FavoritesAndOrdersRepository favoritesAndOrdersRepository;
  List<ProductModel> favorites = [];
  Map<int,bool> favoritesStatus = {};                // will include product id as key and true as value if it on Favorites

  FavoritesAndOrdersCubit({required this.favoritesAndOrdersRepository}) : super(FavoritesAndOrdersInitialState());   // calling for The constructor of super class

  // Todo: make an instance from this cubit to use it across all the App
  static FavoritesAndOrdersCubit getInstance(BuildContext context) => BlocProvider.of(context);

  // Todo: add a product to Favorites using Firebase
  Future<void> addProductToFavorites({required ProductModel model}) async {
    await favoritesAndOrdersRepository.addProductToFavorite(userID: userId!,model: model).then((value){
      emit(AddProductToFavoritesSuccessState());
    }).catchError((error){
      debugPrint("Error during add product to favorites from business logic and the reason is .... $error");
      emit(AddProductToFavoritesErrorState());
    });
  }

  Future<void> removeProductFromFavorites({required int productID}) async {
    emit(DeleteProductFromFavoritesLoadingState());
    await favoritesAndOrdersRepository.deleteProductFromFavorites(userID: userId!, productID: productID).then((value){
      emit(DeleteProductFromFavoritesSuccessState());
    }).catchError((error){
      debugPrint("Error during remove product from favorites from business logic and the reason is .... $error");
      emit(DeleteProductFromFavoritesErrorState());
    });
  }

  Future<List<ProductModel>> getFavorites() async {
    favorites.clear();   // to get new data every time when it called
    favoritesStatus.clear();
    emit(GetFavoritesLoadingState());
    await favoritesAndOrdersRepository.getFavorites(userID: userId!).then((value){
      favoritesStatus = favoritesAndOrdersRepository.getFavoritesStatus();
      favorites = value;    // notice : value == List<ProductModel> which come from Firestore
      emit(GetFavoritesSuccessState());
    }).catchError((error){
      debugPrint("Error during get favorites from business logic and the reason is .... $error");
      emit(GetFavoritesErrorState());
    });
    return favorites;
  }
}