import 'package:fashion_store/view_model/layout_view_model/layout_cubit.dart';
import 'package:fashion_store/view_model/layout_view_model/layout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/constants/colors.dart';

class LayoutScreen extends StatelessWidget{
  const LayoutScreen({super.key});
  @override
  Widget build(BuildContext context){
    LayoutCubit cubit = LayoutCubit.getInstance(context);
    return BlocBuilder<LayoutCubit,LayoutStates>(
      builder: (context,stat){
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndexForBottomNavigation,
            selectedItemColor: mainColor,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            onTap: (index)
            {
              cubit.changeCurrentIndexForBottomNavigationBar(index);
            },
            items: const
            [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.category),label: "Category"),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_sharp),label: "Cart"),
              BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "Favorites"),
              BottomNavigationBarItem(icon: Icon(Icons.person),label: "Account"),
            ],
          ),
          body: cubit.layoutScreens[cubit.currentIndexForBottomNavigation],
        );
      }
    );
  }
}