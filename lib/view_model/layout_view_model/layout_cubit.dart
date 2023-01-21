import 'package:fashion_store/view/Screens/categories_screen.dart';
import 'package:fashion_store/view/Screens/favorites_screen.dart';
import 'package:fashion_store/view/Screens/home_screen.dart';
import 'package:fashion_store/view/Screens/profile_screen.dart';
import 'package:fashion_store/view_model/layout_view_model/layout_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view/Screens/cart_screen.dart';

class LayoutCubit extends Cubit<LayoutStates>{
  LayoutCubit() : super(LayoutInitialState());     // LayoutInitialState will be the state for cubit before called new state so it the initial state for it
  // Todo: make an instance from this cubit to use across the Project
  static LayoutCubit getInstance(BuildContext context) => BlocProvider.of(context);

  // Todo: Method for change The index of BottomNavigationBar
  int currentIndexForBottomNavigation = 0 ;
  void changeCurrentIndexForBottomNavigationBar(int index){
    currentIndexForBottomNavigation = index;
    emit(ChangeBottomNavIndexState());
  }

  List<Widget> layoutScreens = [HomeScreen(),const CategoriesScreen(),CartScreen(),FavoritesScreen(),ProfileScreen()];

  // Todo: need for Method to change The Theme of App

}