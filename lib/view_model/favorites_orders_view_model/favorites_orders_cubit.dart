import 'package:fashion_store/models/product_model.dart';
import 'package:fashion_store/shared/constants/constants.dart';
import 'package:fashion_store/view_model/favorites_orders_view_model/favorites_orders_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/favorites_orders_repo/favorites_orders_network_repo.dart';

class FavoritesAndOrdersCubit extends Cubit<FavoritesAndOrdersStates>{
  late FavoritesAndOrdersNetworkRepository favoritesAndOrdersNetworkRepo;
  List<ProductModel> favorites = [];
  FavoritesAndOrdersCubit({required this.favoritesAndOrdersNetworkRepo}) : super(FavoritesAndOrdersInitialState());   // calling for The constructor of super class

  // Todo: make an instance from this cubit to use it across all the App
  static FavoritesAndOrdersCubit getInstance(BuildContext context) => BlocProvider.of(context);

  // Todo: add a product to Favorites using Firebase
  Future<void> addProductToFavorites({required ProductModel model}) async {
    await favoritesAndOrdersNetworkRepo.addProductToFavorite(userID: userId!,model: model).then((value){
      emit(AddProductToFavoritesSuccessState());
    }).catchError((error){
      debugPrint("Error during add product to favorites from business logic and the reason is .... $error");
      emit(AddProductToFavoritesErrorState());
    });
  }

  Future<void> removeProductFromFavorites({required int productID}) async {
    emit(DeleteProductFromFavoritesLoadingState());
    await favoritesAndOrdersNetworkRepo.deleteProductFromFavorites(userID: userId!, productID: productID).then((value){
      getFavorites();  // Todo: maybe delete this instruction
      emit(DeleteProductFromFavoritesSuccessState());
    }).catchError((error){
      debugPrint("Error during remove product from favorites from business logic and the reason is .... $error");
      emit(DeleteProductFromFavoritesErrorState());
    });
  }

  Future<List<ProductModel>> getFavorites() async {
    favorites.clear();   // to get new data every time when it called
    emit(GetFavoritesLoadingState());
    await favoritesAndOrdersNetworkRepo.getFavorites(userID: userId!).then((value){
      favorites = value;
      emit(GetFavoritesSuccessState());
    }).catchError((error){
      debugPrint("Error during get favorites from business logic and the reason is .... $error");
      emit(GetFavoritesErrorState());
    });
    return favorites;
  }
}