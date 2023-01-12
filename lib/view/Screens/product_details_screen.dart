import 'package:fashion_store/models/product_model.dart';
import 'package:fashion_store/shared/constants/colors.dart';
import 'package:fashion_store/view/Widgets/default_buttons.dart';
import 'package:fashion_store/view_model/home_view_model/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/home_view_model/home_states.dart';
import '../Widgets/default_packages_item.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({Key? key,required this.model}) : super(key: key);
  ProductModel model;
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = BlocProvider.of<HomeCubit>(context);
    return Scaffold(
      appBar: _appBarItem(cubit: cubit,context: context),
      body: BlocBuilder<HomeCubit,HomeStates>(
        builder: (context,state)=> Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              Expanded(
                flex: 6,
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    margin: const EdgeInsets.all(10),
                    child: buildCarouselSliderItem(productModel: model),
                  )
              ),
              const SizedBox(height: 15,),
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(model.title.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: mainColor),),
                          Text("${model.price.toString()} \$",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: secondColor),),
                        ],
                      ),
                      const SizedBox(height: 5,),
                      const Text("Colors",style: TextStyle(color: Colors.grey,fontSize: 14),),
                      const SizedBox(height: 7,),
                      _chooseProductColor(),
                      const SizedBox(height: 25,),
                      _chooseProductCount(cubit: cubit),
                      const SizedBox(height: 25,),
                      const Text("Description",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: mainColor),),
                      const SizedBox(height: 7,),
                      Text("${model.description}",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: secondColor),),
                      const Spacer(),
                      _addToCartItems(),
                    ],
                  ),
                ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _appBarItem({required HomeCubit cubit,required BuildContext context}) => AppBar(
      title: const Text("Details"),
      elevation: 0,
      leading: BackButton(
          onPressed: ()
          {
            cubit.productQuantity = 1 ;
            Navigator.pop(context);
          })
  );

  Widget _chooseProductColor() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(height: 15,width: 15,decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(2)),),
      const SizedBox(width: 10,),
      Container(height: 15,width: 15,decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(2)),),
      const SizedBox(width: 10,),
      Container(height: 15,width: 15,decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(2)),),
    ],
  );

  Widget _chooseProductCount({required HomeCubit cubit}) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children:
    [
      GestureDetector(
        onTap: (){cubit.decreaseQuantity();},
        child: const CircleAvatar(
          radius: 15,
          backgroundColor: mainColor,
          child: Icon(Icons.remove,color: Colors.white,),
        ),
      ),
      const SizedBox(width: 10,),
      Text(cubit.productQuantity.toString(),style: const TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 20),),
      const SizedBox(width: 10,),
      GestureDetector(
        onTap: (){cubit.increaseQuantity();},
        child: const CircleAvatar(
          radius: 15,
          backgroundColor: mainColor,
          child: Icon(Icons.add,color: Colors.white,),
        ),
      ),
    ],
  );

  Widget _addToCartItems() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children:
    [
      defaultButton(
          buttonColor:mainColor,
          onTap: ()
          {
            /// Todo: function for add a product to cart using Firebase
          },
          height: 30,
          elevation: 0,
          minWidth:150,
          content: const Text("Add to Cart",style: TextStyle(color: Colors.white),)
      ),
      const SizedBox(width: 7.5,),
      defaultButton(
          onTap: ()
          {
            /// Todo: function for add a product to cart using Firebase
          },
          height: 30,
          elevation: 0,
          minWidth:50,
          contentPadding: const EdgeInsets.all(3),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: const BorderSide(color: mainColor,width: 1.5)
          ),
          content: const Icon(Icons.favorite_outline,color: mainColor,)
      ),
    ],
  );
}
